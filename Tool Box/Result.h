//
//  Result.h
//  Plus.
//
//  Created by Yongyang Nie on 8/19/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Result : NSObject

/*
 case -1 = init value
 case 0 = add
 case 1 = subtract
 case 2 = multiply
 case 3 = divide
 */

@property int operation;
@property (strong, nonatomic) NSNumber *value;

- (instancetype)initWithOperation:(int)operation andValue:(NSNumber *)value;

@end

NS_ASSUME_NONNULL_END
