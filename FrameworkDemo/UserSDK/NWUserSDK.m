//
//  NWUserSDK.m
//  UserSDK
//
//  Created by Tian on 2021/6/4.
//

#import "NWUserSDK.h"

@implementation NWUserSDK

+ (instancetype)sharedSDK {
    static NWUserSDK *sdk;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sdk = [[NWUserSDK alloc] init];
    });
    return sdk;
}

- (void)loginWithPhone:(NSString *)phone
                  code:(NSString *)code
            completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    
    if (completion) {
        if ([phone isEqualToString:code]) {
            completion(@{@"user":phone}, nil);
        } else {
            completion(nil, [NSError errorWithDomain:@"com.zy.test" code:499 userInfo:nil]);
        }
    }
}

@end
