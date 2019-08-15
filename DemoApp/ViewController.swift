//
//  ViewController.swift
//  DemoApp
//
//  Created by KLau on 8/15/18.
//  Copyright © 2018 MDLive. All rights reserved.
//

import UIKit
import MDLEmbedKitVideo

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func testVideoButtonPressed(_ sender: UIButton) {
    
        let apiKey: String = "34f881b5dff46ee62cac"
        let apiSecret: String = "ee93d2e7acb5cb667f4"
        let bearerToken: String = ""
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
          //  let appointmentID = appointmentIDTextField.text,
            !username.isEmpty,
            !password.isEmpty
            else { return }
        
        
        let apiParameters:  [String: Any]  = ["api": ["username": apiKey, "password": apiSecret],
                             "auth": ["username": username, "password": password],
                             "device": ["token": "123", "os": "iOS"],
                             "app": ["current_version": "1.0", "app_id": "MDLiveConnect Demo"]]
        let sessionConfiguration: URLSessionConfiguration = .default
        sessionConfiguration.httpAdditionalHeaders = ["Authorization" : "Bearer \(bearerToken)"]
        guard let url = URL(string: "https://stage-rest-api.mdlive.com/api/v1/mobile_user_auth/auth_token"),
         let postData = (try? JSONSerialization.data(withJSONObject: apiParameters, options: []))  else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        let session: URLSession = .init(configuration: sessionConfiguration)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let token = json?["jwt"] as? String,
                let user = json?["user"] as? [String: Any],
                let userID = user["id"] as? Int else {
                    return
            }
            self?.createOnCallAppointment(userID: String(userID), auth: token)
         //  self?.startVideoAppointment(userID: String(userID), appointmentID: appointmentID, auth: token)
        }
        task.resume()
    }
    
    
    func createOnCallAppointment(userID: String, auth: String) {
        let apiParameters:  [String: Any]  = ["promocode": "",
                                              "video_backend": "philo",
                                              "chief_complaint": "fdfs",
                                              "share_medical_history": true,
                                              "consultation_state": "CA",
                                              "final_amount": "75.00",
                                              "mdlive_not_available": "Emergency Room",
                                              "user": [
                                                "call_in_number": "7838384838",
                                                "physician_type": "3",
                                                "consultation_method": "Video"
            ]]
        let sessionConfiguration: URLSessionConfiguration = .default
        sessionConfiguration.httpAdditionalHeaders = ["Authorization" : "\(auth)"]
        guard let url = URL(string: "https://stage-rest-api.mdlive.com/api/v1/patients/\(userID)/appointments/on_call_consultation"),
            let postData = (try? JSONSerialization.data(withJSONObject: apiParameters, options: []))  else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        let session: URLSession = .init(configuration: sessionConfiguration)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let appointmentID = json?["cust_appointment_id"] as? Int else {
                return
            }
            self?.startVideoAppointment(userID: userID, appointmentID: String(appointmentID), auth: auth)
        }
        task.resume()
    }
    
    func startVideoAppointment(userID: String, appointmentID: String, auth: String) {

        MDLEmbedKitVideoCore.sharedInstance().startVideoSession(withAppointmentID: appointmentID, userID: userID, authToken: auth , onConnect: { [weak self] vc, _ in
            guard let vc = vc else { return }
            let navc = UINavigationController(rootViewController: vc)
            self?.present(navc, animated: true, completion: nil)
            }, onDisconnect: { [weak self]  _,_ in
                self?.dismiss(animated: true, completion: nil)
        })
    }
    
}

