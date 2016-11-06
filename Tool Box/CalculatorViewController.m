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

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark Calculator Methods

-(IBAction)selectedNumber:(id)sender{
    
    NSString *string = [(UIButton *)sender titleLabel].text;
    SelectNumber = SelectNumber * 10;
    SelectNumber = SelectNumber + [string intValue];
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

-(void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    
    if (available) {
        self.speechButton.enabled = YES;
    }else{
        self.speechButton.enabled = NO;
    }
}

#pragma mark - IBActions

-(IBAction)microphoneTapped:(id)sender{
    
    [UIView animateWithDuration:1 animations:^{
        self.tableHeight.constant = 8;
        [self.view layoutIfNeeded];
    }];
    
    if (audioEngine.isRunning) {
        [audioEngine stop];
        [recognitionRequest endAudio];
        self.speechButton.enabled = NO;
    }else{
        [self startRecording];
    }
}

-(void)swipeGesture:(UISwipeGestureRecognizer *)swipeUp{
    
    if (audioEngine.isRunning) {
        [audioEngine stop];
        [recognitionRequest endAudio];
        self.speechButton.enabled = NO;
    }
    
    if (swipeUp.direction == UISwipeGestureRecognizerDirectionUp) {
        [UIView animateWithDuration:0.75 animations:^{
            self.tableHeight.constant = 415;
            [self.view layoutIfNeeded];
        }];
    }else if (swipeUp.direction == UISwipeGestureRecognizerDirectionDown){
        [UIView animateWithDuration:0.75 animations:^{
            self.tableHeight.constant = 8;
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - Private

-(void)startRecording{
    
    self.listening.hidden = YES;
    
    if (recognitionTask != nil) {
        [recognitionTask cancel];
        recognitionTask = nil;
    }
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    
    recognitionRequest = [SFSpeechAudioBufferRecognitionRequest new];
    
    AVAudioInputNode *inputNode = audioEngine.inputNode;
    
    recognitionRequest.shouldReportPartialResults = YES;
    
    SpeechParser *parse = [[SpeechParser alloc] init];
    
    recognitionTask = [speech recognitionTaskWithRequest:recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        
        BOOL isFinal = NO;
        
        if (result != nil) {
            self.questionLabel.text = [NSString stringWithFormat:@"\"%@\"", result.bestTranscription.formattedString];
            isFinal = result.isFinal;
        }
        
        if (error != nil || isFinal) {
            
            [audioEngine stop];
            [inputNode removeTapOnBus:0];
            
            recognitionRequest = nil;
            recognitionTask = nil;
            
            self.speechButton.enabled = YES;
            
            parse.text = result.bestTranscription.formattedString;
            [parse parseEquation];
            [parse parseNumbersOperators:^(BOOL success, NSString *error) {
                
                if (success) {
                    [parse calculate];
                    
                }
            }];
            self.answerLabel.text = [NSString stringWithFormat:@"%@ = %f", parse.equation, parse.result.floatValue];
            
        }
    }];
    
    NSLog(@"answer %@", parse.result);
    
    AVAudioFormat *recordingFormate = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormate block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    [audioEngine prepare];
    
    [audioEngine startAndReturnError:nil];
    
    //self.speechResult.text = @"Say Something, I'm listening";

}

-(void)setUpSpeechRecognition{
    
    audioEngine = [[AVAudioEngine alloc] init];
    
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
                enabled = YES;
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
    
    switch ([[AVAudioSession sharedInstance] recordPermission]) {
        case AVAudioSessionRecordPermissionGranted:
            
            break;
        case AVAudioSessionRecordPermissionDenied:
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    NSLog(@"premission granted");
                }else{
                    enabled = NO;
                }
            }];
            break;
        case AVAudioSessionRecordPermissionUndetermined:
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    NSLog(@"premission granted");
                }else{
                    enabled = NO;
                }
            }];
            break;
        default:
            break;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.speechButton.enabled = enabled;
    }];
}

-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 15;
    view.layer.shadowRadius = 2.0f;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-1.0f, 3.0f);
    view.layer.shadowOpacity = 0.8f;
    view.layer.masksToBounds = NO;
}

-(void)setupViews{
    
    for (UIButton *button in self.buttons) {
        [self setShadowforView:button];
    }
    self.tableHeight.constant = 415;
    [self setShadowforView:self.table];
    [self setShadowforView:self.speechButton];
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    self.answerLabel.text = @"";
    self.questionLabel.text = @"";
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    if(areAdsRemoved == YES){
        self.banner.hidden = YES;
    }else{
        self.banner.adUnitID = @"ca-app-pub-7942613644553368/1714159132";
        self.banner.rootViewController = self;
        [self.banner loadRequest:[GADRequest request]];
    }

    [self setUpSpeechRecognition];
    [self setupViews];
    [super viewDidLoad];
    
    self.speechButton.hidden = YES;
    self.table.hidden = YES;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
