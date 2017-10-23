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

-(IBAction)selectedNumber:(id)sender{
    
    NSString *string = [(UIButton *)sender titleLabel].text;
    self.selectString = [self.selectString stringByAppendingString:string];
    self.screen.text = self.selectString;
//
//    self.selectString = self.selectString * 10;
//    self.selectString = self.selectString + [string intValue];
//    self.screen.text = [NSString stringWithFormat:@"%i", self.selectString];
}

-(IBAction)Times:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 1;
    self.selectString = @"";
}

-(IBAction)Divide:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];

    else
        [self calculate:Method];
    
    Method = 2;
    self.selectString = @"";
}

-(IBAction)Subtract:(id)sender{
    
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 3;
    self.selectString = @"";
    
}
-(IBAction)Plus:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];
    
    Method = 4;
    self.selectString = @"";
    
}
-(IBAction)Equals:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:Method];

    Method = 0;
    self.selectString = 0;
    self.screen.text = [NSString stringWithFormat:@"%.7f", self.runningTotal];
}


-(IBAction)AllClear:(id)sender{
    
    Method = 0;
    self.runningTotal = 0;
    self.selectString = @"";
    self.screen.text = [NSString stringWithFormat:@"0"];
}

-(void)calculate:(int)method{
    
    switch (method) {
        case 1:
            self.runningTotal = self.runningTotal * [self.selectString doubleValue];
            break;
        case 2:
            self.runningTotal = self.runningTotal / [self.selectString doubleValue];
            break;
        case 3:
            self.runningTotal = self.runningTotal - [self.selectString doubleValue];
            break;
        case 4:
            self.runningTotal = self.runningTotal + [self.selectString doubleValue];
            break;
        default:
            break;
    }
}

#pragma mark - Speech Recognition Methods

-(void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    
    if (available)
        self.speechButton.enabled = YES;
    else
        self.speechButton.enabled = NO;
}

#pragma mark - IBActions
/*- (IBAction)cancelSpeech:(id)sender {
    
    [UIView animateWithDuration:0.75 animations:^{
        self.tableHeight.constant = 415;
        [self.view layoutIfNeeded];
    }];
    if (audioEngine.isRunning) {
        [audioEngine stop];
        [recognitionRequest endAudio];
    }
}

-(IBAction)microphoneTapped:(id)sender{
    
    [UIView animateWithDuration:1 animations:^{
        self.tableHeight.constant = 8;
        [self.view layoutIfNeeded];
    }];
    
    if (audioEngine.isRunning) {
        [audioEngine stop];
        [recognitionRequest endAudio];
        [UIView animateWithDuration:0.75 animations:^{
            self.tableHeight.constant = 415;
            [self.view layoutIfNeeded];
        }];
    }else{
        [self startRecording];
    }
    
    [self createAndLoadInterstitial];    
}

-(void)swipeGesture:(UISwipeGestureRecognizer *)swipeUp{
    
    if (audioEngine.isRunning) {
        [audioEngine stop];
        [recognitionRequest endAudio];
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
}*/

#pragma mark - Private

- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7942613644553368/5594711931"];
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
}
/*
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
                
                if (success)
                    [parse calculate];
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
            enabled = YES;
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
}*/

-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 10;
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
    [self setShadowforView:self.speechButton];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.selectString = @"";
    
    if(areAdsRemoved == YES){
        self.banner.hidden = YES;
    }else{
        self.banner.adUnitID = @"ca-app-pub-7942613644553368/1714159132";
        self.banner.rootViewController = self;
        [self.banner loadRequest:[GADRequest request]];
    }

    [self setupViews];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
