//
//  LiveSDK.m
//  LiveSDK
//
//  Created by Tian on 2021/6/4.
//

#import "LiveSDK.h"

@implementation LiveSDK
+ (instancetype)sharedSDK {
    static LiveSDK *sdk;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sdk = [[LiveSDK alloc] init];
    });
    return sdk;
}

- (void)sendMsg:(NSString *)msg completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    if (completion) {
        completion(@{@"msg": msg}, nil);
    }
}
@end
