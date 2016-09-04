//
//  LAContext+Wrap.h
//  SDKWrap
//
//  Created by Fantasy on 16/9/1.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>
#import "NSError+Wrap.h"

@interface LAContext (Wrap)

+ (instancetype) authorize;

+ (BOOL) isSupportTouchID;

- (void) authorize:(NSString *)useReason
            finish:(void(^)())finish
            failed:(void(^)(NSError *error))failed;

@end
