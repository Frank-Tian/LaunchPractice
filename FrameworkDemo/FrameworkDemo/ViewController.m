//
//  ViewController.m
//  FrameworkDemo
//
//  Created by Tian on 2021/6/4.
//

#import "ViewController.h"
#import <IMSDK/IMSDK.h>
#import <LiveSDK/LiveSDK.h>
#import <UserSDK/NWUserSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[IMSDK sharedSDK] sendMsg:@"vvvv" completion:^(NSDictionary * _Nullable user, NSError * _Nullable error) {
        NSLog(@"-----------%@", user);
    }];
    [[LiveSDK sharedSDK] sendMsg:@"vaaa" completion:^(NSDictionary * _Nullable user, NSError * _Nullable error) {
        NSLog(@"-----------%@", user);
    }];
    [[NWUserSDK sharedSDK] loginWithPhone:@"2222" code:@"2222" completion:^(NSDictionary * _Nullable user, NSError * _Nullable error) {
        NSLog(@"-----------%@", user);
    }];
}


@end
