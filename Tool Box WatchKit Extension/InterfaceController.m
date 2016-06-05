//
//  InterfaceController.m
//  ToolBox Apple Watch WatchKit Extension
//
//  Created by Neil Nie on 5/29/15.
//  Copyright (c) 2015 Yongyang Nie. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController



-(IBAction)Number1:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 1;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number2:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 2;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number3:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 3;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number4:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 4;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number5:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 5;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number6:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 6;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number7:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 7;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number8:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 8;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number9:(id)sender{
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 9;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}
-(IBAction)Number0:(id)sender{
    
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + 0;
    self.Number.text = [NSString stringWithFormat:@"%i", SelectNumber];
    
}


-(IBAction)Plus{
    
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

-(IBAction)Times{
    
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
-(IBAction)Divide{
    
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
-(IBAction)Subtract{
    
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
    self.Number.text = [NSString stringWithFormat:@"%f", RunningTotal];
    
}

-(IBAction)OCEqual:(id)sender{
    
    if (TempRevert == NO) {
        RunningTotal = SelectNumber * 1.8 + 32;
        if (RunningTotal > SelectNumber) {
            self.C.text = [NSString stringWithFormat:@"%f℉", RunningTotal];
            NSLog(@"%fF.", RunningTotal);
        }else{
            self.C.text = [NSString stringWithFormat:@"%f℃", RunningTotal];
            NSLog(@"%fC.", RunningTotal);
        }
    }else{
        float X = SelectNumber - 32;
        RunningTotal = X / 1.8;
        if (RunningTotal > SelectNumber) {
            self.C.text = [NSString stringWithFormat:@"%f℉", RunningTotal];
            NSLog(@"%fF, %f", RunningTotal, X);
        }else{
            self.C.text = [NSString stringWithFormat:@"%f℃", RunningTotal];
            NSLog(@"%fC", RunningTotal);
        }
    }
    
}
-(IBAction)INEqual:(id)sender{
    
    if (inRevert == NO) {
        RunningTotal = SelectNumber * 2.54;
        if (RunningTotal < SelectNumber) {
            self.In.text = [NSString stringWithFormat:@"%fin", RunningTotal];
            NSLog(@"%fin", RunningTotal);
        }else{
            self.In.text = [NSString stringWithFormat:@"%fcm", RunningTotal];
            NSLog(@"%fcm", RunningTotal);
        }
    }else if (inRevert == YES){
        RunningTotal = SelectNumber / 2.54;
        if (RunningTotal < SelectNumber) {
            self.In.text = [NSString stringWithFormat:@"%fin", RunningTotal];
            NSLog(@"%fin", RunningTotal);
        }else{
            self.In.text = [NSString stringWithFormat:@"%fcm", RunningTotal];
            NSLog(@"%fcm", RunningTotal);
        }
    }
    
}
-(IBAction)KGEqual:(id)sender{
    
    if (KGRevert == NO) {
        RunningTotal = SelectNumber / 0.453592;
        if (RunningTotal > SelectNumber) {
            self.Kg.text = [NSString stringWithFormat:@"%fib", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }else{
            self.Kg.text = [NSString stringWithFormat:@"%fkg", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }
    }else if (KGRevert == YES){
        RunningTotal = SelectNumber * 0.453592;
        if (RunningTotal > SelectNumber) {
            self.Kg.text = [NSString stringWithFormat:@"%fib", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }else{
            self.Kg.text = [NSString stringWithFormat:@"%fkg", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }
    }
    
}

-(IBAction)KMEqual:(id)sender{
    
    if (KMRevert == NO) {
        RunningTotal = SelectNumber / 0.62137;
        if (RunningTotal > SelectNumber) {
            self.KM.text = [NSString stringWithFormat:@"%fkm", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }else{
            self.KM.text = [NSString stringWithFormat:@"%fmi", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }
    }else if (KMRevert == YES){
        RunningTotal = SelectNumber * 0.62137;
        if (RunningTotal > SelectNumber) {
            self.KM.text = [NSString stringWithFormat:@"%fkm", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }else{
            self.KM.text = [NSString stringWithFormat:@"%fmi", RunningTotal];
            NSLog(@"%f", RunningTotal);
        }
    }
    
    
}
-(IBAction)KGRevert:(id)sender{
    if (KGRevert == YES) {
        self.Kg.text = [NSString stringWithFormat:@"000ib"];
        NSLog(@"Converted");
        KGRevert = NO;
    }else{
        self.Kg.text = [NSString stringWithFormat:@"000kg"];
        NSLog(@"Converted");
        KGRevert = YES;
    }
    
}
-(IBAction)KMRevert:(id)sender{
    if (KMRevert == YES) {
        self.KM.text = [NSString stringWithFormat:@"000km"];
        NSLog(@"Converted");
        KMRevert = NO;
    }else{
        self.KM.text = [NSString stringWithFormat:@"000mi"];
        NSLog(@"Converted");
        KMRevert = YES;
    }
    
}
-(IBAction)OCRevert:(id)sender{
    if (TempRevert == YES) {
        self.C.text = [NSString stringWithFormat:@"000℉"];
        NSLog(@"ConvertedF");
        TempRevert = NO;
    }else{
        self.C.text = [NSString stringWithFormat:@"000℃"];
        NSLog(@"ConvertedC");
        TempRevert = YES;
    }
    
}
-(IBAction)INRevert:(id)sender{
    if (inRevert == YES) {
        self.In.text = [NSString stringWithFormat:@"000cm"];
        NSLog(@"Converted");
        inRevert = NO;
    }else{
        self.In.text = [NSString stringWithFormat:@"000in"];
        NSLog(@"Converted");
        inRevert = YES;
    }
    
}


-(IBAction)AllClear:(id)sender{
    
    Method = 0;
    RunningTotal = 0;
    SelectNumber = 0;
    self.Number.text = [NSString stringWithFormat:@"00"];
    self.KM.text = [NSString stringWithFormat:@"00"];
    self.C.text = [NSString stringWithFormat:@"00"];
    self.In.text = [NSString stringWithFormat:@"00"];
    self.Kg.text = [NSString stringWithFormat:@"00"];
}


- (void)awakeWithContext:(id)context {
    
    TempRevert = YES;
    inRevert = YES;
    KGRevert = YES;
    KMRevert = YES;
    if (KMRevert == YES) {
        self.KM.text = [NSString stringWithFormat:@"000mi"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }else{
        self.KM.text = [NSString stringWithFormat:@"000km"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }
    
    if (KGRevert == YES) {
        self.Kg.text = [NSString stringWithFormat:@"000kg"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }else{
        self.Kg.text = [NSString stringWithFormat:@"000ib"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }
    
    if (TempRevert == YES) {
        self.C.text = [NSString stringWithFormat:@"000℃"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }else{
        self.C.text = [NSString stringWithFormat:@"000℉"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }
    
    if (inRevert == YES) {
        self.In.text = [NSString stringWithFormat:@"000cm"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }else{
        self.In.text = [NSString stringWithFormat:@"000in"];
        self.Number.text = [NSString stringWithFormat:@"00"];
    }
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end


