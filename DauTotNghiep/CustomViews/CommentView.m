//
//  CommentView.m
//  DauTotNghiep
//
//  Created by test on 3/6/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "CommentView.h"
#import "InformationComment.h"
#import "CommentTableViewCell.h"
@interface CommentView()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *list;
}
@end
@implementation CommentView{
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    
    return self;
}
- (void)setUpView {
    UIView *view = nil;
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"CommentView"
                                                     owner:self
                                                   options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:[UIView class]]) {
            view = object;
            break;
        }
    }
    if (view) {
        [self addSubview:view];
        view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self setLayout];
    }
}
-(void)setLayout{
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
-(void) DateTime{
    InformationComment *infor = [[InformationComment alloc]init];
    NSDate *dates = [NSDate date];
    infor.time = dates;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    InformationComment *infor = [list objectAtIndex:indexPath.row];
    [cell setUpCell:infor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}
- (IBAction)sendButton:(id)sender {

}
@end
