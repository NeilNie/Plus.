//
//  Result.m
//  Plus.
//
//  Created by Yongyang Nie on 8/19/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

#import "Result.h"

@implementation Result

- (instancetype)initWithOperation:(int)operation andValue:(NSNumber *)value
{
    self = [super init];
    if (self) {
        
        if (operation > 3) {
            [NSException raise:@"Invalid Operation" format:@"Please check the call stack and parameter values"];
        }
        self.operation = operation;
        self.value = value;
    }
    return self;
}

@end
