//
//  CommentTableViewCell.h
//  DauTotNghiep
//
//  Created by test on 3/6/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationComment.h"

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *Date;
-(void)setUpCell: (InformationComment *)itemComment;
@end
