//
//  PreferenceViewController.h
//  Plus.
//
//  Created by Yongyang Nie on 6/7/17.
//  Copyright © 2017 Yongyang Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>

@import GoogleMobileAds;

BOOL areAdsRemoved;

@interface PreferenceViewController : UIViewController <MFMailComposeViewControllerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) IBOutletCollection(UIButton) NSMutableArray *buttons;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSMutableArray *labels;

- (IBAction)restore;
- (IBAction)tapsRemoveAdsButton;
@property (weak, nonatomic) IBOutlet GADBannerView *banner;

@end
