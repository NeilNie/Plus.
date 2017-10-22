//
//  InterfaceController.h
//  ToolBox Apple Watch WatchKit Extension
//
//  Created by Neil Nie on 5/29/15.
//  Copyright (c) 2015 Yongyang Nie. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

int Method;
int SelectNumber;
float RunningTotal;
float KM;
float Temp;
float IN;
float KG;
BOOL KMRevert;
BOOL KGRevert;
BOOL inRevert;
BOOL TempRevert;

@interface InterfaceController : WKInterfaceController

@property (strong, nonatomic) IBOutlet WKInterfaceLabel *Number;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *KM;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *C;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *In;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *Kg;
-(IBAction)Plus;
-(IBAction)Times;
-(IBAction)Divide;
-(IBAction)Subtract;
-(IBAction)Equals:(id)sender;
-(IBAction)AllClear:(id)sender;
-(IBAction)Number1:(id)sender;
-(IBAction)Number2:(id)sender;
-(IBAction)Number3:(id)sender;
-(IBAction)Number4:(id)sender;
-(IBAction)Number5:(id)sender;
-(IBAction)Number6:(id)sender;
-(IBAction)Number7:(id)sender;
-(IBAction)Number8:(id)sender;
-(IBAction)Number9:(id)sender;
-(IBAction)Number0:(id)sender;
-(IBAction)KMEqual:(id)sender;
-(IBAction)OCEqual:(id)sender;
-(IBAction)INEqual:(id)sender;
-(IBAction)KGEqual:(id)sender;
-(IBAction)KGRevert:(id)sender;
-(IBAction)KMRevert:(id)sender;
-(IBAction)OCRevert:(id)sender;
-(IBAction)INRevert:(id)sender;
@end
