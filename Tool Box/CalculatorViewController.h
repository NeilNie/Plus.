//
//  CalculatorViewController.h
//  
//
//  Created by Yongyang Nie on 9/11/16.
//
//

#import "SpeechParser.h"
#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@import GoogleMobileAds;

@interface CalculatorViewController : UIViewController <SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate, AVSpeechSynthesizerDelegate>{
    
    //calc
    int Method;
    int SelectNumber;
    float RunningTotal;
    int cases;
    int cases1;
    int cases2;

    IBOutlet UILabel *Screen;
    SFSpeechRecognizer *speech;
    SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
    SFSpeechRecognitionTask *recognitionTask;
    AVAudioEngine *audioEngine;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet UIView *listenResult;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet GADBannerView *banner;
@property (weak, nonatomic) IBOutlet UIButton *speechButton;
@property (weak, nonatomic) IBOutlet UILabel *listening;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *buttons;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSMutableArray *width;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSMutableArray *height;

//Calc
-(IBAction)Times:(id)sender;
-(IBAction)Divide:(id)sender;
-(IBAction)Subtract:(id)sender;
-(IBAction)Plus:(id)sender;
-(IBAction)Equals:(id)sender;
-(IBAction)AllClear:(id)sender;

@end
