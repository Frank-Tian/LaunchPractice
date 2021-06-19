//
//  IMSDK.h
//  IMSDK
//
//  Created by Tian on 2021/6/4.
//

#import <Foundation/Foundation.h>

//! Project version number for IMSDK.
FOUNDATION_EXPORT double IMSDKVersionNumber;

//! Project version string for IMSDK.
FOUNDATION_EXPORT const unsigned char IMSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IMSDK/PublicHeader.h>


@interface IMSDK : NSObject

+ (instancetype)sharedSDK;

- (void)sendMsg:(NSString *)msg
     completion:(void(^)(NSDictionary *_Nullable user, NSError *_Nullable error))completion;
@end
