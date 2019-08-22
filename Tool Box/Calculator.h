//
//  Calculator.h
//  Plus.
//
//  Created by Yongyang Nie on 8/20/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calculator : NSObject

@property (strong, nonatomic) NSNumber *runningTotal;

- (void)add:(NSNumber *)value;

- (void)subtract:(NSNumber *)value;

- (void)multiply:(NSNumber *)value;

- (void)divide:(NSNumber *)value;

@end

NS_ASSUME_NONNULL_END
