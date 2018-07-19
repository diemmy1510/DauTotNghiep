//
//  CommentView.h
//  DauTotNghiep
//
//  Created by test on 3/6/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView
@property (weak, nonatomic) IBOutlet UIView *ViewComment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *TextComment;
@property (weak, nonatomic) IBOutlet UIButton *send;
- (IBAction)sendButton:(id)sender;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setUpView;
@end
