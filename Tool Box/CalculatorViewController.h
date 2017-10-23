//
//  CalculatorViewController.h
//  
//
//  Created by Yongyang Nie on 9/11/16.
//  (c) Yongyang Nie 2017
//

#import "SpeechParser.h"
#import "PreferenceViewController.h"
#import <UIKit/UIKit.h>
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@import GoogleMobileAds;

@interface CalculatorViewController : UIViewController <SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate, AVSpeechSynthesizerDelegate>{
    
    //calc
    int Method;
    int cases;
    int cases1;
    int cases2;

    SFSpeechRecognizer *speech;
    SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
    SFSpeechRecognitionTask *recognitionTask;
    AVAudioEngine *audioEngine;
}
@property double runningTotal;
@property (strong, nonatomic) NSString *selectString;
@property (weak, nonatomic) IBOutlet UILabel *screen;
@property (weak, nonatomic) IBOutlet GADBannerView *banner;
@property (nonatomic, strong) GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet UIButton *speechButton;
@property (weak, nonatomic) IBOutlet UILabel *listening;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *buttons;

@end
