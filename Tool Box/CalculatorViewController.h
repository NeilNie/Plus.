//
//  CalculatorViewController.h
//  
//
//  Created by Yongyang Nie on 9/11/16.
//  (c) Yongyang Nie 2017
//

#import "SpeechParser.h"
#import "PreferenceViewController.h"
#import "Result.h"
#import "ResultTableViewCell.h"

#import <UIKit/UIKit.h>
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@import GoogleMobileAds;

@interface CalculatorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    //calc
    int method;
    int cases;
    int cases1;
    int cases2;
}

@property double runningTotal;
@property (strong, nonatomic) NSNumber *initialValue;
@property (strong, nonatomic) NSString *selectString;
@property (strong, nonatomic) GADInterstitial *interstitial;
@property (strong, nonatomic) NSMutableArray<Result *> *resultsArray;

@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (weak, nonatomic) IBOutlet UILabel *equalSignLabel;
@property (weak, nonatomic) IBOutlet UILabel *largeResultLabel;
@property (weak, nonatomic) IBOutlet GADBannerView *banner;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *buttons;

@end
