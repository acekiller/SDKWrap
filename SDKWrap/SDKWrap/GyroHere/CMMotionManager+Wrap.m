//
//  CMMotionManager+Wrap.m
//  SDKWrap
//
//  Created by Fantasy on 16/9/2.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "CMMotionManager+Wrap.h"

@implementation CMMotionManager (Wrap)

+ (instancetype) manager
{
    static dispatch_once_t once;
    static id _instance = nil;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void) startUpdate:(NSTimeInterval)updateTimeInterval
      revicedHandler:(void (^)(CMDeviceMotion *))revicedHandler
              failed:(void (^)(NSError *))failed
{
    [self stopUpdate];
    self.deviceMotionUpdateInterval = updateTimeInterval;
    [self startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
                                              toQueue:[NSOperationQueue currentQueue]
                                          withHandler:^(CMDeviceMotion *motion,
                                                        NSError *error)
    {
        if (error) {
            if (failed) {
                failed(error);
            }
        } else {
            if (revicedHandler) {
                revicedHandler(motion);
            }
        }
    }];
}

- (void) stopUpdate
{
    [self stopDeviceMotionUpdates];
}

@end
