//
//  PreferenceViewController.m
//  Plus.
//
//  Created by Yongyang Nie on 6/7/17.
//  Copyright © 2017 Yongyang Nie. All rights reserved.
//

#import "PreferenceViewController.h"

@interface PreferenceViewController ()

@end

@implementation PreferenceViewController

#define kRemoveAdsProductIdentifier @"noads.toolbox"
#define kRemoveAdsProductIdentifier2 @"donation.toobox"

-(IBAction)feedback:(id)sender{
    
    MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
    [mailcontroller setMailComposeDelegate:self];
    NSArray *emailArray = [[NSArray alloc] initWithObjects:@"appledeveloper.neil@gmail.com", nil];
    [mailcontroller setToRecipients:emailArray];
    [mailcontroller setSubject:@"Contact Us/subsribe"];
    [mailcontroller setMessageBody:@"Your Email:               Your Message:        " isHTML:NO];
    [self presentViewController:mailcontroller animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)tapsRemoveAdsButton{
    NSLog(@"User requests to remove ads");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else
        NSLog(@"User cannot make payments due to parental controls");
    //this is called the user cannot make payments, most likely due to parental controls
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    NSUInteger count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct)
        NSLog(@"No products available");
    //this is called if your product id is not valid, this shouldn't be called unless that happens.
}

- (IBAction)purchase:(SKProduct *)product{
    
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    areAdsRemoved = NO;
    [[NSUserDefaults standardUserDefaults] setBool:areAdsRemoved forKey:@"areAdsRemoved"];
    //use NSUserDefaults so that you can load wether or not they bought it
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    for (SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            NSLog(@"Transaction state -> Restored");
            //called when the user successfully restores a purchase
            [self doRemoveAds];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                [self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased NoAds");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored NoAds");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finnish
                if(transaction.error.code != SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateDeferred:
                break;
        }
    }
}

- (void)doRemoveAds{
    
    areAdsRemoved = YES;
    [[NSUserDefaults standardUserDefaults] setBool:areAdsRemoved forKey:@"areAdsRemoved"];
    //use NSUserDefaults so that you can load wether or not they bought it
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(IBAction)rate:(id)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/plus/id992505214?ls=1"] options:@{} completionHandler:nil];
    
}
-(IBAction)foremore:(id)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.neilnie.com"] options:@{} completionHandler:nil];
}

-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 6;
}

-(void)setupViews{
    
    for (UIButton *button in self.buttons) {
        [self setShadowforView:button];
    }
}

#pragma mark - Private

- (void)viewDidLoad {
    
    if(areAdsRemoved == YES){
        self.banner.hidden = YES;
    }else{
        self.banner.adUnitID = @"ca-app-pub-7942613644553368/1714159132";
        self.banner.rootViewController = self;
        [self.banner loadRequest:[GADRequest request]];
    }
    [self setupViews];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
