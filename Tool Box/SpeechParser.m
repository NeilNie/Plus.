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

-(NSString *)calculate{
    
    NSString *number;
    
    return number;
}

-(void)parseEquation{
    
    NSArray *array = [self.text componentsSeparatedByString:@" "];
    
    for (int i = 0; i < array.count; i++) {
        
        NSString *currentString = array[i];
        
        const char *c = [currentString UTF8String];
        
        if ([self isNumber:c[0]]) {
            self.equation = currentString;
            
            return;
        }
    }
}
-(void)parseNumbersOperators:(void (^)(BOOL success, NSString *error))completionHandler{
    
    const char *array = [self.equation UTF8String];
    
    NSMutableArray *numberArr = [NSMutableArray new];
    
    NSMutableArray *opArray = [NSMutableArray new];
    
    NSString *numberString = [NSString new];
    
    for (int i = 0; i < self.equation.length; i++) {
        
        BOOL isLast = self.equation.length - 1;
        char c = array[i];
        char nc = array[i + 1];
        
        //all cases before the last case
        //c parsing
        if ([self isNumber:c]) { //if c is a number
            
            numberString = [numberString stringByAppendingString:[NSString stringWithFormat:@"%c", c]];
            
            if (isLast) {
                NSString *operator = [NSString stringWithFormat:@"%c", c];
                [opArray addObject:operator];
            }
            
        }else if ([self isOperator:c]) { //if c is a char
            
            NSString *operator = [NSString stringWithFormat:@"%c", c];
            [opArray addObject:operator];
            
            if (![self isNumber:nc]) { //c is operator, safty check
                completionHandler(NO, @"ER_WR-OP");
                return;
            }
        }
        
        //ns parsing and safty check
        if ([self isOperator:nc]){ //if next char is operator add string to array and reset;
            
            [numberArr addObject:numberString];
            numberString = [NSString new];
            
        }else if (![self isOperator:nc] && ![self isNumber:nc] && !isLast){ //if next char is not number nor operator return error
            
            completionHandler(NO, @"ER_WR-VAL");
            return;
        }
    }
    
    self.numbers = numberArr;
    self.operations = opArray;
    
    completionHandler(YES, nil);
}

-(BOOL)isNumber:(char)c{
    
    if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' ||
        c == '5' || c == '6' || c == '7' || c == '8' || c == '9') {
        
        return YES;
        
    }else{
        return NO;
    }
}

-(BOOL)isOperator:(char)c{
    
    NSString *divide = @"÷";
    
    if (c == [divide characterAtIndex:0] || c == '+' || c == '-' || c == '*') {
        
        return YES;
        
    }else{
        return NO;
    }
}

@end
