//
//  NWUserSDK.h
//  UserSDK
//
//  Created by Tian on 2021/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWUserSDK : NSObject

+ (instancetype)sharedSDK;

- (void)loginWithPhone:(NSString *)phone
                  code:(NSString *)code
            completion:(void(^)(NSDictionary *_Nullable user, NSError *_Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
