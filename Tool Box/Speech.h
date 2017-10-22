//
//  Speech.h
//  Tool Box
//
//  Created by Yongyang Nie on 9/17/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Speech : NSObject <AVSpeechSynthesizerDelegate>

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) AVSpeechUtterance *utterance;

@end
