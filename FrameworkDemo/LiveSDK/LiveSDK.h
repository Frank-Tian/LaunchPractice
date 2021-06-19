//
//  LiveSDK.h
//  LiveSDK
//
//  Created by Tian on 2021/6/4.
//

#import <Foundation/Foundation.h>

//! Project version number for LiveSDK.
FOUNDATION_EXPORT double LiveSDKVersionNumber;

//! Project version string for LiveSDK.
FOUNDATION_EXPORT const unsigned char LiveSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <LiveSDK/PublicHeader.h>


@interface LiveSDK : NSObject

+ (instancetype)sharedSDK;

- (void)sendMsg:(NSString *)msg
     completion:(void(^)(NSDictionary *_Nullable user, NSError *_Nullable error))completion;
@end
