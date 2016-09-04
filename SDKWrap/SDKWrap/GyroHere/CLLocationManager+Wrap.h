//
//  CLLocationManager+Wrap.h
//  SDKWrap
//
//  Created by Fantasy on 16/9/1.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "NSError+Wrap.h"

@interface CLLocationManager (Wrap)
<
    CLLocationManagerDelegate
>

+ (instancetype) locationManager;

- (void) authorization:(NSInteger)type
               success:(void(^)())success
                failed:(void(^)(NSError *))failed;

- (void) startUpdate:(void(^)(id))locationHandler
     authorizeFailed:(void(^)(NSError *))authorizeFailed
        updateFailed:(void(^)(NSError *))updateFailed;

- (void) stopUpdate;

@end
