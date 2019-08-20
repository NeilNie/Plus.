//
//  ResultTableViewCell.h
//  Plus.
//
//  Created by Yongyang Nie on 8/19/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *operationSignLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

NS_ASSUME_NONNULL_END
