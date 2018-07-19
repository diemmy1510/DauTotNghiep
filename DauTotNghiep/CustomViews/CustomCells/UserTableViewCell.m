//
//  UserTableViewCell.m
//  DauTotNghiep
//
//  Created by Kane Nguyen on 2/22/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "UserTableViewCell.h"
@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
