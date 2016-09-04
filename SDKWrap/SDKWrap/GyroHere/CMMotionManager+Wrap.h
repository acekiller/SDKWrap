//
//  CMMotionManager+Wrap.h
//  SDKWrap
//
//  Created by Fantasy on 16/9/2.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "NSError+Wrap.h"

@interface CMMotionManager (Wrap)
+ (instancetype) manager;
- (void) startUpdate:(NSTimeInterval)updateTimeInterval
      revicedHandler:(void(^)(CMDeviceMotion *motion))revicedHandler
              failed:(void(^)(NSError *error))failed;
- (void) stopUpdate;
@end
