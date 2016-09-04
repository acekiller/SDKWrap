//
//  LAContext+Wrap.m
//  SDKWrap
//
//  Created by Fantasy on 16/9/1.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "LAContext+Wrap.h"

@implementation LAContext (Wrap)

+ (instancetype) authorize {
    static dispatch_once_t once;
    static id _authorize = nil;
    dispatch_once(&once, ^{
        _authorize = [[LAContext alloc] init];
    });
    return _authorize;
}

+ (BOOL) isSupportTouchID
{
    LAContext *auth = [LAContext authorize];
    BOOL isSupport = [auth canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                       error:nil];
    return isSupport;
}

- (void) authorize:(NSString *)useReason
            finish:(void(^)())finish
            failed:(void(^)(NSError *error))failed
{
    NSError *error = nil;
    if (![self canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                           error:&error])
    {
        failed([self erroMapping:error]);
        return;
    }
    
    [self evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
         localizedReason:useReason
                   reply:^(BOOL success, NSError * _Nullable error) {
                       if (!success) {
                           failed([self erroMapping:error]);
                       } else {
                           finish();
                       }
                   }];
}

- (NSError *) erroMapping:(NSError *)error {
    NSString *errorDomain = error.domain;
    NSInteger code = error.code;
    NSMutableDictionary *userInfo = [[error userInfo] mutableCopy];
    
    NSString *errorDescription = [self errorDescriptionWithKLACode:code];
    if (errorDescription == nil) {
        errorDescription = [userInfo objectForKey:NSLocalizedDescriptionKey];
    }
    return [NSError errorWithDomain:errorDomain
                               code:code
                           userInfo:userInfo];
}

- (NSString *) errorDescriptionWithKLACode:(NSInteger)code
{
    return [@{
              @(kLAErrorAuthenticationFailed) : NSLocalizedString(@"验证失败", @"验证失败"),
              @(kLAErrorUserCancel) : NSLocalizedString(@"您已取消", @"您已取消"),
              @(kLAErrorUserFallback) : NSLocalizedString(@"用户回退", @"用户回退"),
              @(kLAErrorSystemCancel) : NSLocalizedString(@"系统取消", @"系统取消"),
              @(kLAErrorPasscodeNotSet) : NSLocalizedString(@"您的设备还未设置密码!", @"您的设备还未设置密码!"),
              @(kLAErrorTouchIDNotAvailable) : NSLocalizedString(@"您设备不支持TouchID", @"您设备不支持TouchID"),
              @(kLAErrorTouchIDNotEnrolled) : NSLocalizedString(@"未设置TouchID", @"未设置TouchID"),
              @(kLAErrorTouchIDLockout) : NSLocalizedString(@"TouchID已锁定", @"TouchID已锁定"),
              @(kLAErrorAppCancel) : NSLocalizedString(@"应用取消", @"应用取消"),
              @(kLAErrorInvalidContext) : NSLocalizedString(@"非法验证", @"非法验证"),
              } objectForKey:@(code)];
}

@end
