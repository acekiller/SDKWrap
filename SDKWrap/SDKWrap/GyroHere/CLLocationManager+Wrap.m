//
//  CLLocationManager+Wrap.m
//  SDKWrap
//
//  Created by Fantasy on 16/9/1.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "CLLocationManager+Wrap.h"

@implementation CLLocationManager (Wrap)

+ (instancetype) locationManager
{
    static dispatch_once_t once;
    static id _instance = nil;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void) authorization:(NSInteger)type
               success:(void(^)())success
                failed:(void(^)(NSError *))failed
{
    BOOL isEnable = [CLLocationManager locationServicesEnabled];
    if (!isEnable) {
        failed([self errorWithFailedReasonCode:1]);
        return;
    }
    isEnable = [CLLocationManager headingAvailable];
    if (!isEnable) {
        failed([self errorWithFailedReasonCode:2]);
        return;
    }
    [[CLLocationManager locationManager] requestAlwaysAuthorization];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        success();
        return;
    }
    
    [[CLLocationManager locationManager] requestWhenInUseAuthorization];
    status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        success();
        return;
    }
    
    failed([self errorWithFailedReasonCode:status]);;
}

- (void) startUpdate:(void(^)(id))locationHandler
     authorizeFailed:(void(^)(NSError *))authorizeFailed
        updateFailed:(void(^)(NSError *))updateFailed
{
    [self authorization:0 success:^{
        [self startUpdate:locationHandler
             updateFailed:updateFailed];
    } failed:^(NSError *error) {
        authorizeFailed(error);
    }];
}

- (void)startUpdate:(void (^)(id))locationHandler
       updateFailed:(void (^)(NSError *))updateFailed
{
    [self startUpdatingLocation];
    [self startUpdatingHeading];
}

- (void) stopUpdate
{
    [self stopUpdatingHeading];
    [self stopUpdatingLocation];
}

- (NSError *)errorWithFailedReasonCode:(NSInteger)errorCode
{
    return nil;
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
}

@end
