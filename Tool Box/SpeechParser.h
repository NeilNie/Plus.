//
//  SpeechParser.h
//  Tool Box
//
//  Created by Yongyang Nie on 9/11/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeechParser : NSObject

@property (strong, nonatomic) NSNumber *result;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *exceptions;
@property (strong, nonatomic) NSString *equation;
@property (strong, nonatomic) NSMutableArray<NSString *> *operations;
@property (strong, nonatomic) NSMutableArray<NSString *> *numbers;

-(void)calculate;
-(void)parseEquation;
-(void)parseNumbersOperators:(void (^)(BOOL success, NSString *error))completionHandler;
-(instancetype)initWithText:(NSString *)text;

@end
