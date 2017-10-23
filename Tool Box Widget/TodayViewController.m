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

#pragma mark Calculator Methods

-(IBAction)selectedNumber:(id)sender{
    
    NSString *string = [(UIButton *)sender titleLabel].text;
    self.selectString = [self.selectString stringByAppendingString:string];
    self.screen.text = self.selectString;
}

-(IBAction)Times:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 1;
    self.selectString = @"";
}

-(IBAction)Divide:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 2;
    self.selectString = @"";
}

-(IBAction)Subtract:(id)sender{
    
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 3;
    self.selectString = @"";
    
}
-(IBAction)Plus:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 4;
    self.selectString = @"";
    
}
-(IBAction)Equals:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 0;
    self.selectString = 0;
    self.screen.text = [NSString stringWithFormat:@"%.7f", self.runningTotal];
}


-(IBAction)AllClear:(id)sender{
    
    Method = 0;
    self.runningTotal = 0;
    self.selectString = @"";
    self.screen.text = [NSString stringWithFormat:@"0"];
}

-(void)calculate:(int)method{
    
    switch (method) {
        case 1:
            self.runningTotal = self.runningTotal * [self.selectString doubleValue];
            break;
        case 2:
            self.runningTotal = self.runningTotal / [self.selectString doubleValue];
            break;
        case 3:
            self.runningTotal = self.runningTotal - [self.selectString doubleValue];
            break;
        case 4:
            self.runningTotal = self.runningTotal + [self.selectString doubleValue];
            break;
        default:
            break;
    }
}


-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 10;
    view.layer.shadowRadius = 2.0f;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-1.0f, 3.0f);
    view.layer.shadowOpacity = 0.8f;
    view.layer.masksToBounds = NO;
}

-(void)setupViews{
    
    for (UIButton *button in self.buttons) {
        [self setShadowforView:button];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.selectString = @"";
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    [self setupViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake(0.0, 500);
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
