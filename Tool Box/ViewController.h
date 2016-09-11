//
//  ViewController.h
//  Tool Box
//
//  Created by Yongyang Nie on 7/14/15.
//  Copyright (c) 2015 Yongyang Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>

@import GoogleMobileAds;

//Setting
BOOL areAdsRemoved;

//Timer
int countnumber;
int countnumber2;
int countnumber3;
int timercases;
int timercases1;
//Unit Convert

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    //Timer
    IBOutlet UILabel *timerdisplay;
    IBOutlet UILabel *timerdisplay2;
    IBOutlet UILabel *timerdisplay3;
    IBOutlet UIButton *Start;
    NSTimer *timer;
}

//Timer
-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)restart:(id)sender;

//Setting
-(IBAction)rate:(id)sender;
-(IBAction)Foremore:(id)sender;
- (IBAction)restore;
- (IBAction)tapsRemoveAdsButton;
- (IBAction)tapsRemoveAdsButton2;
-(IBAction)feedback:(id)sender;
@property (weak, nonatomic) IBOutlet GADBannerView *banner;

@end


