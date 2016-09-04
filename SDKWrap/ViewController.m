//
//  ViewController.m
//  SDKWrap
//
//  Created by Fantasy on 16/9/1.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CMMotionManager+Wrap.h"
#import "LAContext+Wrap.h"

@interface ViewController ()
<
    MKMapViewDelegate
>
@property (nonatomic, strong, readonly) MKMapView *mapView;
@end

@implementation ViewController

@synthesize mapView=_mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.mapView setDelegate:self];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
    [self.mapView setShowsUserLocation:YES];
    if ([self.mapView respondsToSelector:@selector(setShowsBuildings:)]) {
        [self.mapView setShowsBuildings:YES];
    }
    [self.mapView setMapType:MKMapTypeSatellite];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
    
    [[CMMotionManager manager] startUpdate:(1 / 60.f)
                            revicedHandler:^(CMDeviceMotion *motion)
    {
        //CMDeviceMotion Data
    }
                                    failed:^(NSError *error)
    {
        //Error;
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[LAContext authorize] authorize:@"TouchID test" finish:^{
        NSLog(@"success");
    } failed:^(NSError *error) {
        NSLog(@"failed : %@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.errorTitle
                                                        message:error.errorDescription
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKMapView *) mapView {
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

@end
