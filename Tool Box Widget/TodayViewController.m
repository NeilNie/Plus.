//
//  TodayViewController.m
//  Tool Box Widget
//
//  Created by Yongyang Nie on 6/5/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

-(IBAction)Number1:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 1;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number2:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 2;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
    
}
-(IBAction)Number3:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 3;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
}
-(IBAction)Number4:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 4;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
}
-(IBAction)Number5:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 5;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
}
-(IBAction)Number6:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 6;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
    
}
-(IBAction)Number7:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 7;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
    
}
-(IBAction)Number8:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 8;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number9:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 9;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number0:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 0;
    Screen.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
    
    
}
-(IBAction)Times:(id)sender{
    
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal - SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            default:
                break;
        }
        
        
    }
    
    Method = 1;
    SelectNumber = 0;
    
    
    
}
-(IBAction)Divide:(id)sender{
    
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal - SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            default:
                break;
        }
        
    }
    
    
    Method = 2;
    SelectNumber = 0;
    
    
}
-(IBAction)Subtract:(id)sender{
    
    
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal - SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            default:
                break;
        }
        
    }
    
    Method = 3;
    SelectNumber = 0;
    
}
-(IBAction)Plus:(id)sender{
    
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal - SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            default:
                break;
        }
        
    }
    
    Method = 4;
    SelectNumber = 0;
    
}
-(IBAction)Equals:(id)sender{
    
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal - SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            default:
                break;
        }
        
    }
    
    Method = 0;
    SelectNumber = 0;
    Screen.text = [NSString stringWithFormat:@"%f", RunningTotal];
    
    
}

-(IBAction)AllClear:(id)sender{
    
    Method = 0;
    RunningTotal = 0;
    SelectNumber = 0;
    Screen.text = [NSString stringWithFormat:@"0"];
    
}

-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 15;
    view.layer.shadowRadius = 2.0f;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-1.0f, 3.0f);
    view.layer.shadowOpacity = 0.8f;
    view.layer.masksToBounds = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    for (UIButton *button in self.buttons) {
        [self setShadowforView:button];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake(0.0, 350);
    } else if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = maxSize;
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
