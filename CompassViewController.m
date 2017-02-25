//
//  CompassViewController.m
//  Tool Box
//
//  Created by Yongyang Nie on 8/21/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "CompassViewController.h"

@interface CompassViewController ()

@end

@implementation CompassViewController

GeoPointCompass *geoPointCompass;

#pragma mark GeoPointCompass Delegate

-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateLocation:(CLLocation *)newLocation{
    
    self.latitude.text = [NSString stringWithFormat:@"%.05f", newLocation.coordinate.latitude];
    self.longtitude.text = [NSString stringWithFormat:@"%.05f", newLocation.coordinate.longitude];
}

-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateHeading:(CLHeading *)newHeading{
    
    self.degrees.text = [NSString stringWithFormat:@"%.00f°N", newHeading.trueHeading];
}

#pragma mark - MapView Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1100, 1100);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}

-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateGeocoder:(NSString *)newCoder{
    
    self.location.text = newCoder;
}

#pragma mark - Private Methods

-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 15;
    view.layer.shadowRadius = 2.0f;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-1.0f, 3.0f);
    view.layer.shadowOpacity = 0.8f;
    view.layer.masksToBounds = NO;
}

#pragma mark - Life Cycle

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
    [super viewDidDisappear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    // Create the image for the compass
    geoPointCompass = [[GeoPointCompass alloc] init];
    
    // Add the image to be used as the compass on the GUI
    [geoPointCompass setArrowImageView:self.arrowImageView];
    
    // Set the coordinates of the location to be used for calculating the angle
    geoPointCompass.latitudeOfTargetedPoint = 90.0;
    geoPointCompass.longitudeOfTargetedPoint = 0.0;
    geoPointCompass.delegate = self;
    
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.view.frame.size.width == 320) {
        self.height.constant = 300;
        self.width.constant = 300;
    }
    
    if(areAdsRemoved == YES)
        self.banner.hidden = YES;
    else{
        self.banner.adUnitID = @"ca-app-pub-7942613644553368/1714159132";
        self.banner.rootViewController = self;
        [self.banner loadRequest:[GADRequest request]];
    }
    
    [self setShadowforView:self.contentView];
    
    self.mapView.showsUserLocation = YES;
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.010;
    mapRegion.span.longitudeDelta = 0.010;
    [self.mapView setRegion:mapRegion animated:YES];
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
