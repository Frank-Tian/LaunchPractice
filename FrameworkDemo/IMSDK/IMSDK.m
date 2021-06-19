//
//  IMSDK.m
//  IMSDK
//
//  Created by Tian on 2021/6/4.
//

#import "IMSDK.h"

@implementation IMSDK

+ (instancetype)sharedSDK {
    static IMSDK *sdk;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sdk = [[IMSDK alloc] init];
    });
    return sdk;
}

- (void)sendMsg:(NSString *)msg completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    if (completion) {
        completion(@{@"msg": msg}, nil);
    }
}
@end
