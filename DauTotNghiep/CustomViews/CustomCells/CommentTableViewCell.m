//
//  CommentTableViewCell.m
//  DauTotNghiep
//
//  Created by test on 3/6/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "CommentTableViewCell.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpCell: (InformationComment *)itemComment{
    self.email.text = itemComment.emails;
    self.content.text = itemComment.textComment;
    self.Date.text = 	[NSDateFormatter localizedStringFromDate:itemComment.time
                                                     dateStyle:NSDateFormatterShortStyle
                                                     timeStyle:NSDateFormatterFullStyle];;
    
}
@end
