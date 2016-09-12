//
//  SpeechViewController.m
//  
//
//  Created by Yongyang Nie on 9/11/16.
//
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

#pragma mark Calculator Methods

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

#pragma mark - Speech Recognition Methods

-(void)startRecording{
    
    if (recognitionTask != nil) {
        [recognitionTask cancel];
        recognitionTask = nil;
    }
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession new];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    
    recognitionRequest = [SFSpeechAudioBufferRecognitionRequest new];
    
    AVAudioInputNode *inputNode = audioEngine.inputNode;
    
    recognitionRequest.shouldReportPartialResults = YES;
    
    recognitionTask = [speech recognitionTaskWithRequest:recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        
        BOOL isFinal = NO;
        
        if (result != nil) {
            self.speechResult.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        
        if (error != nil || isFinal) {
            [audioEngine stop];
            [inputNode removeTapOnBus:0];
            
            recognitionRequest = nil;
            recognitionTask = nil;
            
            self.speechButton.enabled = YES;
        }
    }];
    
    AVAudioFormat *recordingFormate = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormate block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    [audioEngine prepare];
    
    [audioEngine startAndReturnError:&error];
    
    self.speechResult.text = @"Say Something, I'm listening";
}

-(void)setUpSpeechRecognition{
    
    speech = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
    
    self.speechButton.enabled = NO;
    
    speech.delegate = self;
    
    static BOOL enabled;
    
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusDenied:
                enabled = NO;
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                enabled = NO;
                break;
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                enabled = YES;
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                enabled = NO;
                break;
                
            default:
                break;
        }
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.speechButton.enabled = enabled;
    }];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [self setUpSpeechRecognition];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
