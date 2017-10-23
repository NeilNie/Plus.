//
//  TodayViewController.h
//  Tool Box Widget
//
//  Created by Yongyang Nie on 6/5/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController{
    
    //calc
    int Method;
    int cases;
    int cases1;
    int cases2;
}

@property double runningTotal;
@property (strong, nonatomic) NSString *selectString;
@property (weak, nonatomic) IBOutlet UILabel *screen;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *buttons;

@end

