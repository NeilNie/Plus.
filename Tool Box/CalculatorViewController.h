//
//  CalculatorViewController.h
//  
//
//  Created by Yongyang Nie on 9/11/16.
//
//

#import <UIKit/UIKit.h>
#import <Speech/Speech.h>

@interface CalculatorViewController : UIViewController <SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate>{
    
    //calc
    int Method;
    int SelectNumber;
    float RunningTotal;
    int cases;
    int cases1;
    int cases2;
    
    //Calc
    IBOutlet UILabel *Screen;
    
    SFSpeechRecognizer *speech;
    
    SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
    SFSpeechRecognitionTask *recognitionTask;
    AVAudioEngine *const audioEngine;
}

@property (weak, nonatomic) IBOutlet UIButton *speechButton;
@property (weak, nonatomic) IBOutlet UILabel *speechResult;

//Calc
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
-(IBAction)Times:(id)sender;
-(IBAction)Divide:(id)sender;
-(IBAction)Subtract:(id)sender;
-(IBAction)Plus:(id)sender;
-(IBAction)Equals:(id)sender;
-(IBAction)AllClear:(id)sender;

@end
