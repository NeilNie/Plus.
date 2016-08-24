//
//  GeoPointCompass.m
//  GeoPointCompass
//
//  Created by Maduranga Edirisinghe on 3/27/14.
//  Copyright (c) 2014 Maduranga Edirisinghe. All rights reserved.
//

#import "GeoPointCompass.h"

#define RadiansToDegrees(radians)(radians * 180.0/M_PI)
#define DegreesToRadians(degrees)(degrees * M_PI / 180.0)

float angle;

@implementation GeoPointCompass

@synthesize delegate;

- (id) init {
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        // Configure and start the LocationManager instance
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 50.0f;
        self.locationManager.headingFilter = 3;
        self.locationManager.headingOrientation = UIDeviceOrientationPortrait;
        [self.locationManager startUpdatingLocation];
        [self.locationManager startUpdatingHeading];
    }
    return self;
}

// Caculate the angle between the north and the direction to observed geo-location
-(float)calculateAngle:(CLLocation *)userlocation
{
    float userLocationLatitude = DegreesToRadians(userlocation.coordinate.latitude);
    float userLocationLongitude = DegreesToRadians(userlocation.coordinate.longitude);
    
    float targetedPointLatitude = DegreesToRadians(self.latitudeOfTargetedPoint);
    float targetedPointLongitude = DegreesToRadians(self.longitudeOfTargetedPoint);
    
    float longitudeDifference = targetedPointLongitude - userLocationLongitude;
    
    float y = sin(longitudeDifference) * cos(targetedPointLatitude);
    float x = cos(userLocationLatitude) * sin(targetedPointLatitude) - sin(userLocationLatitude) * cos(targetedPointLatitude) * cos(longitudeDifference);
    float radiansValue = atan2(y, x);
    if(radiansValue < 0.0)
    {
        radiansValue += 2*M_PI;
    }
    
    return radiansValue;
}

#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"new Location : %@",[newLocation description]);
    [delegate GeoPointCompass:self didUpdateLocation:newLocation];
    
    angle = [self calculateAngle:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@",[error localizedDescription]);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"New Heading :%@", newHeading);
    [delegate GeoPointCompass:self didUpdateHeading:newHeading];
    
    float direction = newHeading.magneticHeading;
    
    if (direction > 180)
    {
        direction = 360 - direction;
    }
    else
    {
        direction = 0 - direction;
    }
    
    // Rotate the arrow image
    if (self.arrowImageView)
    {
        [UIView animateWithDuration:1.0f animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(direction)); // + angle
        }];
    }
}

@end
