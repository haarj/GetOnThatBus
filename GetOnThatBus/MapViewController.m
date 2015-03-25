//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Justin Haar on 3/24/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "BusStops.h"

@interface MapViewController () <MKMapViewDelegate, BusStops>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSArray *results;
@property CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BusStops *apiCallEvent = [[BusStops alloc]init];
    apiCallEvent.delegate = self;
    [apiCallEvent pullBusStopsFromApi];


}



#pragma mark BusStop Delegate Protocol

//THIS REQUIRED METHOD GETS CALLED AFTER THE VIEWDIDLOAD AND THEN CALLS THE LOADBUSSTOPS METHOD TO ITERATE AND SHOW OUR PINS
-(void)busStops:(NSArray *)busStops;
{
    self.results = busStops;
    [self loadBusStops];

}


-(void)loadBusStops
{
    for (BusStops *busStop in self.results)
    {

        double latitude = [busStop.latitude doubleValue];
        double longitude = [busStop.longitude doubleValue];

        CLLocationCoordinate2D busStopCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        MKPointAnnotation *busStopAnnotation = [[MKPointAnnotation alloc]init];
        busStopAnnotation.coordinate = busStopCoordinate;
        [self.mapView addAnnotation:busStopAnnotation];

        //ZOOMS TO CENTER OF FIRST BUSSTOP PULLED IN AND THEN SPANS THE VALUES BELOW
        MKCoordinateSpan span = MKCoordinateSpanMake(0.8, 0.3);
        [self.mapView setRegion:MKCoordinateRegionMake(busStopCoordinate, span)];

        busStopAnnotation.title = busStop.name;
        busStopAnnotation.subtitle = busStop.routes;

    }
}


#pragma MARK CALLOUT ACTIONS

//THIS METHOD WILL ALLOW US TO ZOOM IN TO A REGION WHEN A PIN IS TAPPED
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
//    CLLocationCoordinate2D center = view.annotation.coordinate;
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.4, 0.4);
//    [mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];

}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pinAnnotation.canShowCallout = YES;
    pinAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pinAnnotation;
}


@end
