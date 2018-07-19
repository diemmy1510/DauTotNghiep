//
//  BaseCellDeThi.h
//  DauTotNghiep
//
//  Created by 507-5 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "De.h"
#import <Social/Social.h>
@protocol BaseCellDeThiDelegate <NSObject>
-(void) addDe : (De *)deThiFavor;
@end
@interface BaseCellDeThi : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *baseImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *favorButton;
- (IBAction)favorPress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)sharePress:(id)sender;
@property (nonatomic, strong) De *de;
-(void)setUpCell:(De *)de;

@property(nonatomic, assign) id<BaseCellDeThiDelegate> delegate;
@end
