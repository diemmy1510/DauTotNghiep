#import "LoginViewController.h"
#import "ASTextField.h"
#import "UIButton+Glossy.h"
#import "LoginController.h"
#import "ForgetPasswordController.h"
#import "DataManager.h"
#import "MenuViewController.h"

@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundLogin;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundForgot;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundAlert;
@property (weak, nonatomic) IBOutlet UIScrollView *forgotScollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLoginLabel;
- (IBAction)forgotPasswordPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *enterEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterEmailTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelForgetButton;
@property (nonatomic,retain) NSMutableArray *cellArray;
@end

@implementation LoginViewController
- (id)init
{
    self = [super initWithNibName:@"LoginViewController" bundle:nil];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //bake a cellArray to contain all cells
    self.tableView.scrollEnabled = NO;
    self.cellArray = [NSMutableArray arrayWithObjects: _usernameCell, _passwordCell, _doneCell, _cancelCell, _forgotCell, nil];
    //setup text field with respective icons
    [_usernameField setupTextFieldWithType:ASTextFieldTypeRound withIconName:@"username_icon"];
    [_passwordField setupTextFieldWithType:ASTextFieldTypeRound withIconName:@"Password_icon"];
    [self setBackground];
    [self setTextFieldAndLabel];
    [self setButton];
    [self hiddenForgot];
    [[LoginController getInstance] addDelegate:self];
}
- (void) hiddenForgot{
    self.forgotScollView.hidden = YES;
}
- (void) hiddenLogin{
    self.titleLoginLabel.hidden = YES;
    self.backgroundAlert.hidden = YES;
    self.tableView.hidden = YES;
    self.forgotButton.hidden = YES;
}
- (void) showForgot{
    self.forgotScollView.hidden = NO;
}
- (void) showLogin{
    self.titleLoginLabel.hidden = NO;
    self.backgroundAlert.hidden = NO;
    self.tableView.hidden = NO;
    self.forgotButton.hidden = NO;
}
#pragma mark - tableview deleagate datasource stuff
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return cell's height for particular row
    return ((UITableViewCell*)[self.cellArray objectAtIndex:indexPath.row]).frame.size.height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return number of cells for the table
    return self.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    //return cell for particular row
    cell = [self.cellArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //set clear color to cell.
    [cell setBackgroundColor:[UIColor clearColor]];
}
- (void) setButton {
    //set login button
    self.loginButton.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:140.0/255.0 blue:110.0/255.0 alpha:1.0f];
    [self.loginButton makeGlossy];
    //set cancel login button
    self.cancelButton.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0f];
    [self.cancelButton makeGlossy];
    //set enter login button
    self.sendButton.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:140.0/255.0 blue:110.0/255.0 alpha:1.0f];
    [self.sendButton makeGlossy];
    //set cancel forgot button
    self.cancelForgetButton.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0f];
    [self.cancelForgetButton makeGlossy];
}
- (void)setTextFieldAndLabel{
    // set usernameField
    self.usernameField.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.usernameField.layer.cornerRadius = 15;
    self.usernameField.layer.borderWidth = 1.0f;
    //set passwordField
    self.passwordField.backgroundColor= [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.passwordField.layer.cornerRadius = 15;
    self.passwordField.layer.borderWidth = 1.0f;
    //set titleLoginLabel
    self.titleLoginLabel.textColor = [UIColor whiteColor];
    self.titleLoginLabel.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:107.0/255.0 blue:92.0/255.0 alpha:1.0f];
    self.titleLoginLabel.layer.borderWidth = 1.0f;
    self.titleLoginLabel.clipsToBounds = YES;
    //set enterEmailField
    self.enterEmailTextField.layer.cornerRadius = 13;
    self.enterEmailTextField.layer.borderWidth = 1.0f;
}
- (void) setBackground{
    // set backgroundAlert
    self.backgroundAlert.layer.borderWidth = 1.0f;
    self.backgroundAlert.layer.cornerRadius = 15.0f;
    self.backgroundAlert.clipsToBounds = YES;
    // set backgroundForgot
    self.backgroundForgot.layer.borderWidth = 1.0f;
    self.backgroundForgot.layer.cornerRadius = 15;
    self.backgroundForgot.clipsToBounds = YES;
}
- (void) notification : (NSString *) message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thong Bao" message:message preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)letMeIn:(id)sender {
    if (!self.usernameField.text.length || !self.passwordField.text.length) {
        [self notification:@"Vui lòng điền đầy đủ thông tin"];
    }else{
    [[LoginController getInstance] postLoginWithEmail:self.usernameField.text password:self.passwordField.text];
    }
}
- (IBAction)sendPressed:(id)sender {
    if (!self.enterEmailTextField.text.length) {
        [self notification:@"Vui lòng điền Email"];
    }else{
        [[ForgetPasswordController getInstance] postForgetPassword:self.enterEmailTextField.text];
    }
}
-(void) didRequestLogin: (User *)user taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject{
    NSString *errorObjectMess = [errorObject objectForKey:@"message"];
    if (errorObject) {
        [self notification:errorObjectMess];
    }
    else if (error){
        [self notification:@"Lỗi kết nổi \n Vui lòng kiểm tra lại kết nối"];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
        [DataManager sharedInstance].currentUserLogin = user;
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateInfoLabel:)]) {
            [self.delegate updateInfoLabel:user];
        }
    }
}
-(void) didRequestForgetPassword: (NSArray *)arr taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject{
    if (errorObject) {
        [self notification:@"Vui lòng kiểm tra lại địa chỉ email vừa nhập"];
    }else if (error){
        [self notification:@"Lỗi kết nối \n Vui lòng kiểm tra lại kết nối"];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgotPasswordPressed:(id)sender {
    [self hiddenLogin];
    [self showForgot];
}
- (IBAction)cancelForgotPressed:(id)sender {
    [self hiddenForgot];
    [self showLogin];
}
@end
