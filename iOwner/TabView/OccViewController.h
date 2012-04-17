//
//  OccViewController.h
//  iOwner
//
//  Created by ldb on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface OccViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSMutableArray *locationMeasurements;
    CLLocation *bestEffortAtLocation;
    NSDateFormatter *dateFormatter;
    NSString *stateString;    
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *locationMeasurements;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSString *stateString;

- (IBAction)btOccupy:(id)sender;
- (void)stopUpdatingLocation:(NSString *)state;

@end
