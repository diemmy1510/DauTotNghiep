//
//  MenuViewController.m
//  DauTotNghiep
//
//  Created by BaoPQ4 on 2/21/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "MenuViewController.h"
#import "DataManager.h"
#import "MonHocTableViewCell.h"
#import "ListDeViewController.h"
#import "UserTableViewCell.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MonHocController.h"
#import "DeThiController.h"
#import "Favorite.h"
#import "User.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource, LoginViewControllerDelegate, RegisterViewControllerDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tlbMenu;
@property (nonatomic,strong) NSArray *arrSubjects;
//@property (nonatomic,strong) NSArray *arrSubjects;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tlbMenu registerNib:[UINib nibWithNibName:@"MonHocTableViewCell" bundle:nil] forCellReuseIdentifier:@"MonHocTableViewCellIdentifier"];
    [self.tlbMenu registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
    self.tlbMenu.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"right.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.tlbMenu.backgroundColor = [UIColor clearColor];
    //Load Data from server
    self.arrSubjects = [NSArray new];
    self.arrSubjects = [[DataManager sharedInstance] getAllSubjects];
    [self.tlbMenu reloadData];
    self.userInfoLabel.text = nil;
}
-(void) updateInfoLabel:(User *) user{
    self.userInfoLabel.text = [NSString stringWithFormat:@"\t \t Welcome \n \t %@",user.fullName];
    [self.tlbMenu reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return [self.arrSubjects count];
        
    }
    else{
        if ([[DataManager sharedInstance] currentUserLogin]) {
            return 1;
        }
        else
            return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MonHocTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonHocTableViewCellIdentifier"];
        MonHoc *item = [self.arrSubjects objectAtIndex:indexPath.row];
        cell.monHoc = item;
        return cell;
    }
    else
    {
        UserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if ([[DataManager sharedInstance] currentUserLogin]) {
            userCell.titleLabel.text = @"Logout";
        }
        else if (indexPath.row == 0) {
            userCell.titleLabel.text = @"Login";
        }else{
            userCell.titleLabel.text = @"Register";
        }
        return userCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"showListDe" sender: [self.arrSubjects objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if ([[DataManager sharedInstance] currentUserLogin]) {
                [DataManager sharedInstance].currentUserLogin = nil;
                self.userInfoLabel.text = nil;
                [self.tlbMenu reloadData];
            }else{
                LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                loginVC.definesPresentationContext = YES;
                loginVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:loginVC animated:YES completion:nil];
                loginVC.delegate = self;
            }
        }else{
            RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
            registerVC.definesPresentationContext = YES;
            registerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:registerVC animated:YES completion:nil];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    ListDeViewController *listDeThiViewController =  [destViewController childViewControllers].firstObject;
    listDeThiViewController.monHoc = sender;
    listDeThiViewController.viewTarget = ViewTargetNoneMon;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.bounds.size.width, 30)];
    if (section == 1)
        [headerView setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:41.0/255.0 blue:88.0/25.0 alpha:1]];
    else
        [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

@end
