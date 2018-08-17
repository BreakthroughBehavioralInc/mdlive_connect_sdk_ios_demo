//
//  EMKFMVideoSessionDelegate.h
//  MDLEmbedKitCore
//
//  Created by Akshit on 22/03/17.
//  Copyright © 2017 MDLive. All rights reserved.
//

#ifndef EMKFMVideoSession_h
#define EMKFMVideoSession_h

typedef NS_ENUM(NSInteger, EMKFMVideoSessionState)
{
	EMKFMVideoSessionStateInitializing,
	EMKFMVideoSessionStateConnected,
	EMKFMVideoSessionStateFailed,
};

@protocol EMKFMVideoSessionDelegate <NSObject>

- (void) videoViewControllerToShow:(UIViewController *)viewController;

- (void) videoViewControllerToHide:(UIViewController *)viewController userHangUp:(BOOL)userHangUp;

@optional

- (void) checkSessionStatusWithBlock:(void (^)(BOOL))theBlock;

- (void) serverConnectionStateDidChange:(NSString*)session
								  state:(NSInteger)state;

- (void) connectionDidEndWithError:(NSString*)errorStr;

@end

@protocol EMKVideoLoggable <NSObject>

@optional
- (void)logVerbose:(NSString *)logMessage;

@end


#endif /* EMKFMVideoSession_h */
