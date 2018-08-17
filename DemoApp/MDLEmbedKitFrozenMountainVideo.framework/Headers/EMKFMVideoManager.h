//
//  EMKFMVideoManager.h
//  FrozenMountain
//
//  Created by Waseem on 10/10/16.
//  Copyright © 2016 MDLIVE. All rights reserved.
//
// IceLink Version 3.0.14 (on 2017/22/7)
//

#import "EMKFMServer.h"
#import "EMKFMVideoSession.h"
#import "MDLEmbedKitFrozenMountainVideo.h"

@interface EMKFMVideoManager : NSObject
{
}

@property (nonatomic, assign) id<EMKVideoLoggable> logDelegate;

+ (void) setLicenceKey:(NSString*)key;

/// The singleton video view manager object
+ (instancetype) sharedInstance;

/** Start a video call
 * @param sessionId ID
 * @param delegate ID
 */
- (void) startVideoCallWithSessionID:(NSString*)sessionId
                    websyncServerUrl:(NSString*)websyncServerUrl
                icelinkServerAddresses:(NSArray <EMKFMServer*>*)servers
						withDelegate:(id <EMKFMVideoSessionDelegate>) delegate;

/** Close video calls
 */
- (void) endVideoCalls;

/** Switch Camera
 */
- (void) switchCamera;

/** Toggle Video Mute
 */
- (void) toggleVideoMute;

/** Toggle Audio Mute
 */
- (void) toggleAudioMute;

@end
