//
//  OccViewController.h
//  iOwner
//
//  Created by ldb on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MKAnnotationView.h>
#import <MapKit/MKPinAnnotationView.h>

@interface OccViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation>
{
    CLLocationManager *locationManager;
    NSMutableArray *locationMeasurements;
    CLLocation *bestEffortAtLocation;
    NSDateFormatter *dateFormatter;
    NSString *stateString;    
    IBOutlet MKMapView *_mkView;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *locationMeasurements;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSString *stateString;

- (IBAction)btOccupy:(id)sender;
- (void)stopUpdatingLocation:(NSString *)state;

@end
