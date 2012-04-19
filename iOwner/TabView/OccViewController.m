//
//  OccViewController.m
//  iOwner
//
//  Created by ldb on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OccViewController.h"
#import "constants.h"
#import "ASIHTTPRequest.h"

@interface OccViewController ()

@end

@implementation OccViewController

@synthesize locationManager;
@synthesize locationMeasurements;
@synthesize bestEffortAtLocation;
@synthesize stateString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationMeasurements = [NSMutableArray array];
    [_mkView setMapType:MKMapTypeStandard];
    
}

- (void)viewDidUnload
{
    [_mkView release];
    _mkView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.stateString = nil;
    // For the readonly properties, they must be released and set to nil directly.
    [dateFormatter release];
    dateFormatter = nil;
}

- (void)dealloc {
    [locationManager release];
    [locationMeasurements release];
    [bestEffortAtLocation release];
    [stateString release];
    [dateFormatter release];
    [_mkView release];
    [super dealloc];
}

/*
 * The lazy "getter" for the readonly property.
 */
- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    }
    return dateFormatter;
}

- (void)updateArea
{
    double size = 0.001;
    CLLocationCoordinate2D center = bestEffortAtLocation.coordinate;
    area[0].latitude = center.latitude - size;
    area[0].longitude = center.longitude - size;

    area[1].latitude = center.latitude - size;
    area[1].longitude = center.longitude + size;

    area[2].latitude = center.latitude + size;
    area[2].longitude = center.longitude + size;
    
    area[3].latitude = center.latitude + size;
    area[3].longitude = center.longitude - size;
    [self testHttpRequest];
    
}

- (void)updateMKView
{
//    CLLocationCoordinate2D theCoordinate;
//    theCoordinate.latitude=40.0436;
//    theCoordinate.longitude=116.2858;
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.01;
    theSpan.longitudeDelta=0.01;
    MKCoordinateRegion theRegion;
    theRegion.center=bestEffortAtLocation.coordinate;
    theRegion.span=theSpan;
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = bestEffortAtLocation.coordinate;
    [ann setTitle:@"雷"];
    [ann setSubtitle:@"2012年4月"];
    //触发viewForAnnotation
    [_mkView addAnnotation:ann];
    
    [_mkView setZoomEnabled:YES]; 
    [_mkView setScrollEnabled:YES]; 
    [_mkView setMapType:MKMapTypeStandard];
    [_mkView setRegion:theRegion animated:YES];
    
    [self updateArea];
    MKPolygon* mypyA = [MKPolygon polygonWithCoordinates:area count:4];
    [_mkView addOverlay:mypyA];
    [_mkView setRegion:theRegion animated:NO];

}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    NSLog(@"in viewForOverlay!");
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        
        MKPolygonView*    aView = [[[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay] autorelease];
        
        aView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        
        aView.lineWidth = 3;
        
        return aView;
        
    }
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)testHttpRequest
{
    CLLocationCoordinate2D center = bestEffortAtLocation.coordinate;
    int x = (int)(center.latitude * 1000000);
    int y = (int)(center.longitude * 1000000);
    NSString * regapiurl = [NSString stringWithFormat:REST_API_ONETAKE,x,y];
    NSURL *url = [NSURL URLWithString:regapiurl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        int scode = [request responseStatusCode];
        NSLog(@"%d %@",scode , response);

    }else {
        NSLog(@"%@  %@",[error localizedDescription],[error localizedFailureReason]);
    }
    
}

// get the current location
- (IBAction)btOccupy:(id)sender {
    // Create the manager object 
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate = self;
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // Once configured, the location manager must be "started".
    [locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:45.0];
    self.stateString = NSLocalizedString(@"Updating", @"Updating");
}

/*
 * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
 *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
 *      accuracy, or both together.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // store all of the measurements, just so we can see what kind of data we might receive
    [locationMeasurements addObject:newLocation];
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    // test the measurement to see if it is more accurate than the previous measurement
    if (bestEffortAtLocation == nil || bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"
        self.bestEffortAtLocation = newLocation;
        // test the measurement to see if it meets the desired accuracy
        //
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue 
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of 
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            // 
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            //
            [self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
            // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:nil];
        }
    }
    
    if (bestEffortAtLocation != nil) {
        [self updateMKView];
        [self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
        // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:nil];
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
    }
}

- (void)stopUpdatingLocation:(NSString *)state {
    self.stateString = state;
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
    
    UIBarButtonItem *resetItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reset", @"Reset") style:UIBarButtonItemStyleBordered target:self action:@selector(reset)] autorelease];
    [self.navigationItem setLeftBarButtonItem:resetItem animated:YES];;
}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.locowner.pin";
    pinView = (MKPinAnnotationView *)[_mkView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) 
        pinView = [[[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
    pinView.pinColor = MKPinAnnotationColorGreen;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    return pinView;
}

@end
