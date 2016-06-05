//
//  ViewController.m
//  ToolBox Apple Watch
//
//  Created by Neil Nie on 5/29/15.
//  Copyright (c) 2015 Yongyang Nie. All rights reserved.
//

#import "ViewController.h"
#import <sys/sysctl.h>

@interface ViewController ()

@property (strong, nonatomic) NSArray *DistanceUnitArray;
@property (strong, nonatomic) NSArray *MassUnitArray;
@property (strong, nonatomic) NSArray *TemperatureArray;
@property (strong, nonatomic) NSArray *VolumeArray;

@end

@implementation ViewController



#define kRemoveAdsProductIdentifier @"noads.toolbox"
#define kRemoveAdsProductIdentifier2 @"donation.toobox"

//Setting
//
//
-(IBAction)feedback:(id)sender{
    
    MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
    [mailcontroller setMailComposeDelegate:self];
    NSArray *emailArray = [[NSArray alloc] initWithObjects:@"neil@nspiresoftware.net", nil];
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
    else{
        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
}
- (IBAction)tapsRemoveAdsButton2{
    NSLog(@"User requests to remove ads");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier2]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
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
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        if(transaction == SKPaymentTransactionStateRestored){
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
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/artist/huan-he/id966523275"]];
    
}
-(IBAction)Foremore:(id)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://nspiresoftware.net"]];
    
}

//
//
//Timer
//
//
//
//
//

-(IBAction)start:(id)sender{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(Timercount) userInfo:nil repeats:YES];
    Start.enabled = NO;
}
-(void)Timercount{
    
    countnumber = countnumber + 1;
    timerdisplay.text = [NSString stringWithFormat:@"%i", countnumber];
    if (countnumber == 60) {
        countnumber2 = countnumber2 + 1;
        countnumber = 0;
    }
    if (countnumber2 == 60) {
        countnumber3 = countnumber3 + 1;
        countnumber2 = 0;
    }
    timerdisplay3.text = [NSString stringWithFormat:@"%i", countnumber3];
    timerdisplay2.text = [NSString stringWithFormat:@"%i", countnumber2];
    
}
-(IBAction)stop:(id)sender{
    
    [timer invalidate];
    Start.enabled = YES;
    
}
-(IBAction)restart:(id)sender{
    
    [timer invalidate];
    countnumber = 0;
    countnumber2 = 0;
    countnumber3 = 0;
    timerdisplay.text = [NSString stringWithFormat:@"00"];
    timerdisplay2.text = [NSString stringWithFormat:@"00"];
    timerdisplay3.text = [NSString stringWithFormat:@"00"];
}


//
//
//
//Calc
//
//
//

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
//
//UnitConvert
//
//
//
/*
 
 
 
 
 */

-(void)viewDidLoad {
    
    if(areAdsRemoved == YES){
        self.adBanner.delegate = self;
        self.adBanner2.delegate = self;
        self.adBanner4.delegate = self;
        self.adBanner.alpha = 0.0;
        self.adBanner2.alpha = 0.0;
        self.adBanner4.alpha = 0.0;
        NSLog(@"No Ads");
        
    }else{
        self.adBanner.delegate = self;
        self.adBanner2.delegate = self;
        self.adBanner4.delegate = self;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [self.adBanner setAlpha:1];
        [self.adBanner2 setAlpha:1];
        [self.adBanner4 setAlpha:1];
        [UIView commitAnimations];
        
    }
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    NSLog(@"iPhone Device %i",[self platformType:platform]);
    int ScreenSize = [self platformType:platform];
    free(machine);
    if (ScreenSize < 650) {
        self.adBanner.hidden = YES;
        self.adBanner2.hidden = YES;
        self.adBanner4.hidden = YES;
    }
    
    NSArray *data1 = [[NSArray alloc] initWithObjects:@"kilometer", @"centimeter", @"inches", @"feet", nil];
    self.DistanceUnitArray = data1;
    NSArray *data2 = [[NSArray alloc] initWithObjects:@"fahrenheit", @"celsius", @"Kelvin", nil];
    self.TemperatureArray = data2;
    NSArray *data3 = [[NSArray alloc] initWithObjects:@"kilgrams", @"pounds", @"grams", @"ounce", nil];
    self.MassUnitArray = data3;
    NSArray *data4 = [[NSArray alloc] initWithObjects:@"gallon", @"quart", @"liter", @"pint", nil];
    self.VolumeArray = data4;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)Selection:(id)sender{
    [self.UniPicker reloadAllComponents];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.UnitTextField1 resignFirstResponder];
    [self.UnitTextField2 resignFirstResponder];
}

#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    // This method returns the number of components we want in our Picker.
    // The components are the colums.
    return 2;
    
}
#pragma mark Picker Delegate Methods

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    // This method provides the data for a specific row in a specific component.
    switch (self.UnitSelectorSegmentedControl.selectedSegmentIndex) {
        case 0:
            NSLog(@"Distance Unit Convert");
            switch (component) {
                case 0:
                    return [_DistanceUnitArray objectAtIndex:row];
                    break;
                case 1:
                    return [_DistanceUnitArray objectAtIndex:row];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            NSLog(@"Temperature Unit Convert");
            switch (component) {
                case 0:
                    return [_TemperatureArray objectAtIndex:row];
                    break;
                case 1:
                    return [_TemperatureArray objectAtIndex:row];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 2:
            NSLog(@"Mass Unit Convert");
            switch (component) {
                case 0:
                    return [_MassUnitArray objectAtIndex:row];
                    break;
                case 1:
                    return [_MassUnitArray objectAtIndex:row];
                    break;
                    
                default:
                    break;
            }
            break;
        case 3:
            NSLog(@"Volume Unit Convert");
            switch (component) {
                case 0:
                    return [_VolumeArray objectAtIndex:row];
                    break;
                case 1:
                    return [_VolumeArray objectAtIndex:row];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    return 0;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    // This returns the number of rows in each component. We use the count of our array to determine the number of rows.
    switch (self.UnitSelectorSegmentedControl.selectedSegmentIndex) {
        case 0:
            NSLog(@"Distance Unit Convert");
            switch (component) {
                case 0:
                    return _DistanceUnitArray.count;
                    break;
                case 1:
                    return _DistanceUnitArray.count;
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            NSLog(@"Temperature Unit Convert");
            switch (component) {
                case 0:
                    return _TemperatureArray.count;
                    break;
                case 1:
                    return _TemperatureArray.count;
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 2:
            NSLog(@"Mass Unit Convert");
            switch (component) {
                case 0:
                    return _MassUnitArray.count;
                    break;
                case 1:
                    return _MassUnitArray.count;
                    break;
                    
                default:
                    break;
            }
            break;
        case 3:
            NSLog(@"Volume Unit Convert");
            switch (component) {
                case 0:
                    return _VolumeArray.count;
                    break;
                case 1:
                    return _VolumeArray.count;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    return 0;

    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"%@ , %@", [_DistanceUnitArray objectAtIndex:[self.UniPicker selectedRowInComponent:0]], [_DistanceUnitArray objectAtIndex:[self.UniPicker selectedRowInComponent:1]]);
}

//
//Return Hardware Enviroment.
- (int)platformType:(NSString *)platform
{
    if ([platform isEqualToString:@"iPhone4,1"])    return 550;
    if ([platform isEqualToString:@"iPhone5,1"])    return 670;
    if ([platform isEqualToString:@"iPhone5,2"])    return 670;
    if ([platform isEqualToString:@"iPhone5,3"])    return 670;
    if ([platform isEqualToString:@"iPhone5,4"])    return 670;
    if ([platform isEqualToString:@"iPhone6,1"])    return 670;
    if ([platform isEqualToString:@"iPhone6,2"])    return 670;
    if ([platform isEqualToString:@"iPhone7,2"])    return 700;
    if ([platform isEqualToString:@"iPhone7,1"])    return 720;
    if ([platform isEqualToString:@"iPod4,1"])      return 630;
    if ([platform isEqualToString:@"iPod5,1"])      return 630;
    if ([platform isEqualToString:@"iPad2,1"])      return 550;
    if ([platform isEqualToString:@"iPad2,2"])      return 550;
    if ([platform isEqualToString:@"iPad2,3"])      return 550;
    if ([platform isEqualToString:@"iPad2,4"])      return 550;
    if ([platform isEqualToString:@"iPad2,5"])      return 550;
    if ([platform isEqualToString:@"iPad2,6"])      return 550;
    if ([platform isEqualToString:@"iPad2,7"])      return 550;
    if ([platform isEqualToString:@"iPad3,1"])      return 550;
    if ([platform isEqualToString:@"iPad3,2"])      return 550;
    if ([platform isEqualToString:@"iPad3,3"])      return 550;
    if ([platform isEqualToString:@"iPad3,4"])      return 550;
    if ([platform isEqualToString:@"iPad3,5"])      return 550;
    if ([platform isEqualToString:@"iPad3,6"])      return 550;
    if ([platform isEqualToString:@"iPad4,1"])      return 550;
    if ([platform isEqualToString:@"iPad4,2"])      return 550;
    if ([platform isEqualToString:@"iPad4,3"])      return 550;
    if ([platform isEqualToString:@"iPad4,4"])      return 550;
    if ([platform isEqualToString:@"iPad4,5"])      return 550;
    if ([platform isEqualToString:@"iPad4,6"])      return 550;
    if ([platform isEqualToString:@"iPad4,7"])      return 550;
    if ([platform isEqualToString:@"iPad4,8"])      return 550;
    if ([platform isEqualToString:@"iPad4,9"])      return 550;
    if ([platform isEqualToString:@"iPad5,3"])      return 550;
    if ([platform isEqualToString:@"iPad5,4"])      return 550;
    if ([platform isEqualToString:@"i386"])         return 630;
    if ([platform isEqualToString:@"x86_64"])       return 690;
    
    return 700;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
