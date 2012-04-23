//
//  OccViewController.h
//  iOwner
//
//  Created by ldb on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface OccViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,MKReverseGeocoderDelegate>
{
    CLLocationManager *locationManager;
    NSMutableArray *locationMeasurements;
    CLLocation *bestEffortAtLocation;
    NSDateFormatter *dateFormatter;
    NSString *stateString;    
    IBOutlet MKMapView *_mkView;
    CLLocationCoordinate2D area[4];
    
    CLGeocoder *_geoCoder;
    
    MKReverseGeocoder *_reverseGeocoder;    
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *locationMeasurements;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSString *stateString;

@property (nonatomic, retain) CLGeocoder *geoCoder;
@property (nonatomic, retain) MKReverseGeocoder *reverseGeocoder;

- (IBAction)btOccupy:(id)sender;
- (void)stopUpdatingLocation:(NSString *)state;

@end
