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
    @IBOutlet weak var appointmentIDTextField: UITextField!
    
    @IBAction func testVideoButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            let appointmentID = appointmentIDTextField.text,
           !username.isEmpty,
           !password.isEmpty
        else { return }
      
        let apiKey: String = #GET_YOUR_API_KEY_FROM_MDLIVE#
        let apiSecret: String = #GET_YOUR_API_SECRET_FROM_MDLIVE#
        let bearerToken: String = #GET_YOUR_AUTH_FROM_MDLIVE#
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
           self?.startVideoAppointment(userID: String(userID), appointmentID: appointmentID, auth: token)
        }
        task.resume()
    }
    
    
    func startVideoAppointment(userID: String, appointmentID: String, auth: String) {
        MDLEmbedKitVideoCore.sharedInstance().setAuthorizationToken(auth, userID: userID)
        // This delay is only needed for the demo app. In production, there is a series of UI appointment scheduling screens before the patient is taken to the video session screen.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            MDLEmbedKitVideoCore.sharedInstance().startVideoSession(withAppointmentID: appointmentID
                , onConnect: { [weak self] vc, _ in
                    guard let vc = vc else { return }
                    self?.present(vc, animated: true, completion: nil)
                }, onDisconnect: { [weak self]  _,_ in
                    self?.dismiss(animated: true, completion: nil)
            })
        }
    }
    
}

