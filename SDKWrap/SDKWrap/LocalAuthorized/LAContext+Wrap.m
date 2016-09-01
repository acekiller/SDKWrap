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
    return error;
}

@end
