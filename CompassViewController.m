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
    
    self.latitude.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    self.longtitude.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
}

-(void)GeoPointCompass:(GeoPointCompass *)compass didUpdateHeading:(CLHeading *)newHeading{
    
    self.degrees.text = [NSString stringWithFormat:@"%.01f", newHeading.trueHeading];
}

#pragma mark Life Cycle

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
    
    if (self.view.frame.size.width == 320) {
        self.height.constant = 300;
        self.width.constant = 300;
    }
    
    // Create the image for the compass
    geoPointCompass = [[GeoPointCompass alloc] init];
    
    // Add the image to be used as the compass on the GUI
    [geoPointCompass setArrowImageView:self.arrowImageView];
    
    // Set the coordinates of the location to be used for calculating the angle
    geoPointCompass.latitudeOfTargetedPoint = 90.0;
    geoPointCompass.longitudeOfTargetedPoint = 0.0;
    geoPointCompass.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
