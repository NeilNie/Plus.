//
//  MasterViewController.h
//  
//
//  Created by Yongyang Nie on 8/26/16.
//
//

#import <UIKit/UIKit.h>
#import "CompassViewController.h"

@interface MasterViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
