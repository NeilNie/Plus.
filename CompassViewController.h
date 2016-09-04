//
//  CompassViewController.h
//  Tool Box
//
//  Created by Yongyang Nie on 8/21/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "GeoPointCompass.h"
#import "ViewController.h"

@import GoogleMobileAds;

@interface CompassViewController : UIViewController <GeoPointCompassDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet UILabel *degrees;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longtitude;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vHeight;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) CLLocationManager *locationManager;

//
@property (weak, nonatomic) IBOutlet GADBannerView *banner;

@end
