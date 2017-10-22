//
//  SpeechParser.m
//  Tool Box
//
//  Created by Yongyang Nie on 9/11/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "SpeechParser.h"

@implementation SpeechParser

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        self.text = text;
    }
    return self;
}

-(void)calculate{
    
    float sum = 0.0;
    
    int value1 = [[self.numbers objectAtIndex:0] intValue];
    int value2 = value2 = [[self.numbers objectAtIndex:0 + 1] intValue];
    NSString *c = [self.operations objectAtIndex:0];
    
    if ([c isEqualToString:@"×"]) {
        sum = sum + (value1 * value2);
    }else if ([c isEqualToString:@"-"]){
        sum = sum + (value1 - value2);
    }else if ([c isEqualToString:@"÷"]){
        sum = sum + (value1 / value2);
    }else if ([c isEqualToString:@"+"]){
        sum = sum + (value1 + value2);
    }
    
    for (int i = 2; i < self.numbers.count; i = i + 1) { // 1- 2 - 3 -4 - 5
        
        NSString *c = [self.operations objectAtIndex:i - 1];
        value1 = [[self.numbers objectAtIndex:i] intValue];
        
        if ([c isEqualToString:@"×"]) {
            sum = sum * value1;
        }else if ([c isEqualToString:@"-"]){
            sum = sum - value1;
        }else if ([c isEqualToString:@"÷"]){
            sum = sum / value1;
        }else if ([c isEqualToString:@"+"]){
            sum = sum + value1;
        }
        
    }
    self.result = [NSNumber numberWithFloat:sum];
}

-(void)parseEquation{
    
    NSArray *array = [self.text componentsSeparatedByString:@" "];
    
    for (int i = 0; i < array.count; i++) {
        
        NSString *currentString = array[i];
        
        const char *c = [currentString UTF8String];
        
        if ([self isNumber:[NSString stringWithFormat:@"%c", c[0]]]) {
            self.equation = currentString;
            
            return;
        }
    }
}

-(NSMutableArray <NSString *> *)convertToChars{
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (int i = 0; i < self.equation.length; i++) {
        
        unichar s = [self.equation characterAtIndex:i];
        [array addObject:[NSString stringWithFormat:@"%c", s]];
    }
    
    return array;
}

-(void)parseNumbersOperators:(void (^)(BOOL success, NSString *error))completionHandler{

    NSMutableArray *array = [self convertToChars];
    
    NSMutableArray *numberArr = [NSMutableArray new];
    NSMutableArray *opArray = [NSMutableArray new];
    
    NSString *numberString = [NSString new];
    
    for (int i = 0; i < self.equation.length; i++) {
        
        BOOL isLast = (i == (int)self.equation.length - 1)? YES : NO;
        NSString *c = array[i];
        NSString *nc = (isLast) ? nil : array[i + 1];

        //all cases before the last case
        //c parsing
        if ([self isNumber:c]) { //if c is a number
            
            numberString = [numberString stringByAppendingString:c];
            
        }else if ([self isOperator:c]) { //if c is a operator

            [opArray addObject:c];
        }
        
        //ns parsing and safty check
        if ([self isOperator:nc] || isLast){ //if next char is operator add string to array and reset;
            
            [numberArr addObject:numberString];
            numberString = [NSString new];
            
        }
    }
    
    if ([self validateNumber:numberArr withOperators:opArray]) {
        self.numbers = numberArr;
        self.operations = opArray;
    }else{
        completionHandler(NO, @"ER_BD-OP");
    }
    
    completionHandler(YES, nil);
}

-(BOOL)validateNumber:(NSMutableArray *)number withOperators:(NSMutableArray *)operations{
    
    if (number.count == operations.count + 1) {
        return YES;
    }
    return NO;
}

-(BOOL)isNumber:(NSString *)c{
    
    if ([c isEqualToString:@"1"] || [c isEqualToString:@"2"] || [c isEqualToString:@"3"] ||
        [c isEqualToString:@"4"] || [c isEqualToString:@"5"] ||
        [c isEqualToString:@"6"] || [c isEqualToString:@"7"] || [c isEqualToString:@"8"] ||
        [c isEqualToString:@"9"] || [c isEqualToString:@"0"]) {
        
        return YES;
        
    }else{
        return NO;
    }
}

-(BOOL)isOperator:(NSString *)c{
    
    if ([c isEqualToString:@"×"] || [c isEqualToString:@"-"] || [c isEqualToString:@"÷"] || [c isEqualToString:@"+"]) {
        
        return YES;
        
    }else{
        return NO;
    }
}

@end
