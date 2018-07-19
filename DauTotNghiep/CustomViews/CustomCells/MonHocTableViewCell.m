//
//  MonHocTableViewCell.m
//  DauTotNghiep
//
//  Created by BaoPQ4 on 2/21/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "MonHocTableViewCell.h"
@interface MonHocTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imvIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblMonHoc;

@end
@implementation MonHocTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.lblMonHoc.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpCell:(MonHoc *)monHoc
{
    self.lblMonHoc.text = monHoc.tenMon;
    
}
- (void)setMonHoc:(MonHoc *)monHoc
{
    _monHoc  = monHoc;
    [self setUpCell:monHoc];
}
@end
