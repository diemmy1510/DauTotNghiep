//
//  BaseCellDeThi.m
//  DauTotNghiep
//
//  Created by 507-5 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "BaseCellDeThi.h"

@implementation BaseCellDeThi

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setUpCell:(De *)de{
    self.titleLabel.text = de.tenDe;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ _%ld", de.maMon, de.maDe];
       self.favorButton.selected =de.isFavorite	;
}
-(void) setDe:(De *)de{
    _de = de;
    [self setUpCell:de];
}

- (IBAction)sharePress:(id)sender
{
    [self ShowShareFBDialog];
}
- (IBAction)favorPress:(id)sender
{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(addDe:)])
    {
        [self.delegate addDe:self.de];
    }
    
    
    
}

-(void)ShowShareFBDialog
{
    SLComposeViewController *fbSLComposeViewController;
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        fbSLComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSLComposeViewController addURL:[NSURL URLWithString:kAppStore_Link]];
        //        [self presentViewController:fbSLComposeViewController animated:YES completion:nil];
        fbSLComposeViewController.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"facebook: CANCELLED");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"facebook: SHARED");
                    break;
            }
        };
    }
    else
    {
        UIAlertView *fbError = [[UIAlertView alloc] initWithTitle:kString_Share_Facebook_Error_Title message:kString_Share_Facebook_Error_Message delegate:self cancelButtonTitle:kString_Close otherButtonTitles:nil];
        [fbError show];
    }
}
@end
//
//  BaseCellDeThi.m
//  DauTotNghiep
//
//  Created by 507-5 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//


