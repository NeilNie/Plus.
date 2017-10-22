//
//  GeoPointCompass.h
//  GeoPointCompass
//
//  Created by Maduranga Edirisinghe on 3/27/14.
//  Copyright (c) 2014 Maduranga Edirisinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GeoPointCompass : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;

@property (nonatomic, retain) UIImageView *arrowImageView;

@property (nonatomic) CLLocationDegrees latitudeOfTargetedPoint;

@property (nonatomic) CLLocationDegrees longitudeOfTargetedPoint;

@property (nonatomic, retain) id delegate;

@end

@protocol GeoPointCompassDelegate <NSObject>

-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateLocation:(CLLocation *)newLocation;
-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateHeading:(CLHeading *)newHeading;
-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateGeocoder:(NSString *)newCoder;

@end
