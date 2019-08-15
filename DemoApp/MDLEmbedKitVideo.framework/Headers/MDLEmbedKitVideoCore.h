//
//  MDLEmbedKitVideoCore.h
//  MDLEmbedKitVideo
//
//  Created by KLau on 1/16/18.
//  Copyright © 2018 MDLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^MDLEmbedKitVideoOnConnect)(UIViewController*  _Nullable viewController, NSString* _Nullable message);
typedef void (^MDLEmbedKitVideoOnDisconnect)(UIViewController*  _Nullable viewController, BOOL userHangUp);

@interface MDLEmbedKitVideoCore : NSObject

+ (instancetype _Nonnull) sharedInstance;

- (instancetype _Nullable) init UNAVAILABLE_ATTRIBUTE;
+ (instancetype _Nullable) new UNAVAILABLE_ATTRIBUTE;


-(void)startVideoSessionWithAppointmentID:(NSString* _Nonnull)appointmentID
                                userID:(NSString* _Nonnull)userID
                                authToken:(NSString* _Nonnull)authToken
                                onConnect:(MDLEmbedKitVideoOnConnect _Nullable)connectBlock
                                onDisconnect:(MDLEmbedKitVideoOnDisconnect _Nullable)disconnectBlock;

-(void)fetchUserSettings;

@end
