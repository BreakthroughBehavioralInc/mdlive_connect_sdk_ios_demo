//
//  EMKFMServer.h
//  MDLEmbedKitFrozenMountainVideo
//
//  Created by Waseem on 14/07/17.
//  Copyright © 2017 MDLIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMKFMServer : NSObject

@property(nonatomic, strong, readonly) NSString* serverUrl;
@property(nonatomic, strong, readonly) NSString* username;
@property(nonatomic, strong, readonly) NSString* password;

+ (EMKFMServer*) iceServerWithUrl:(NSString*)url username:(NSString*)username
						 password:(NSString*)password;

@end
