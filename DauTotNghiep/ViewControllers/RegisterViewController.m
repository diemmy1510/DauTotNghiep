#import "RegisterViewController.h"
#import "ASTextField.h"
#import "UIButton+Glossy.h"
#import "User.h"
#import "RegisterController.h"
#import "DataManager.h"
#import "User.h"
#import "MenuViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,retain) NSMutableArray *cellRegisArray;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundTableImage;
@end

@implementation RegisterViewController
- (id)init
{
    self = [super initWithNibName:@"RegisterViewController" bundle:nil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerTableView.scrollEnabled = NO;
    self.cellRegisArray = [NSMutableArray arrayWithObjects: _fullNameCell, _emailRegisterCell, _addressRegisterCell, _passwordRegisterCell, _confirmPasswordRegisterCell, _birthdayRegisterCell, _calendarCell, _doneRegisterCell,_cancelRegisterCell, nil];
    [self setTextFieldAndLabel];
    [self setButton];
    [self setBackground];
    self.calendarCell.hidden = YES;
    [[RegisterController getInstance] addDelegate:self];
}
- (void) setTextFieldAndLabel{
    //set full name field
    [_fullNameTextField setupTextFieldWithType: ASTextFieldTypeRound withIconName:@"username_icon"];
    self.fullNameTextField.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.fullNameTextField.layer.borderWidth = 1.0f;
    self.fullNameTextField.layer.cornerRadius = 15.0f;
    // set email field
    [_emailTextField setupTextFieldWithType: ASTextFieldTypeRound withIconName:@"username_icon"];
    self.emailTextField.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.emailTextField.layer.borderWidth = 1.0f;
    self.emailTextField.layer.cornerRadius = 15.0f;
    // set address field
    [_addressTextField setupTextFieldWithType: ASTextFieldTypeRound withIconName:@"address"];
    self.addressTextField.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.addressTextField.layer.borderWidth = 1.0f;
    self.addressTextField.layer.cornerRadius = 15.0f;
    // set password field
    [_passwordTextField setupTextFieldWithType: ASTextFieldTypeRound withIconName:@"Password_icon"];
    self.passwordTextField.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.passwordTextField.layer.borderWidth = 1.0f;
    self.passwordTextField.layer.cornerRadius = 15.0f;
    // set confirm password field
    [_confirmPasswordTextField setupTextFieldWithType: ASTextFieldTypeRound withIconName:@"Password_icon"];
    self.confirmPasswordTextField.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.confirmPasswordTextField.layer.borderWidth = 1.0f;
    self.confirmPasswordTextField.layer.cornerRadius = 15.0f;
    //set title label
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:107.0/255.0 blue:92.0/255.0 alpha:1.0f];
    self.titleLabel.layer.borderWidth = 1.0f;
    self.titleLabel.clipsToBounds = YES;
}
- (void) setButton{
    //Register button
    self.registerButton.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:140.0/255.0 blue:110.0/255.0 alpha:1.0f];
    self.registerButton.layer.borderWidth = 1.0f;
    self.registerButton.layer.cornerRadius = 15;
    [self.registerButton makeGlossy];
    //Cancel button
    self.cancleButton.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0f];
    self.cancleButton.layer.borderWidth = 1.0f;
    self.cancleButton.layer.cornerRadius = 15;
    [self.cancleButton makeGlossy];
    //Birthday button
    self.birthdayButton.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:87.0/255.0 blue:83.0/255.0 alpha:1.0f];
    self.birthdayButton.layer.borderWidth = 1.0f;
    self.birthdayButton.layer.cornerRadius = 15.0f;
}
- (void) setBackground{
    // set background
    self.backgroundTableImage.layer.cornerRadius = 15.0f;
    self.backgroundTableImage.layer.borderWidth = 1.0f;
    self.backgroundTableImage.clipsToBounds = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return cell's height for particular row
    return ((UITableViewCell*)[self.cellRegisArray objectAtIndex:indexPath.row]).frame.size.height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return number of cells for the table
    return self.cellRegisArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    //return cell for particular row
    cell = [self.cellRegisArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //set clear color to cell.
    [cell setBackgroundColor:[UIColor clearColor]];
}
- (void) notification : (NSString *) message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thong Bao" message:message preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)dateChangePressed:(id)sender {
    NSDateFormatter *datefomatter = [[NSDateFormatter alloc] init];
    datefomatter.dateFormat =@"dd/MM/yyyy";
    NSString *dateString =   [datefomatter stringFromDate:self.datePicker.date];
    [self.birthdayButton setTitle:dateString forState:UIControlStateNormal];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)birthdayPressed:(id)sender {
    self.calendarCell.hidden = NO;
}
- (IBAction)registerPressed:(id)sender {
    if (!self.fullNameTextField.text.length || !self.emailTextField.text.length || !self.passwordTextField.text.length || !self.addressTextField.text.length ) {
        [self notification:@"Vui lòng điền đầy đủ thông tin cần thiết"];
    }
    else if (self.passwordTextField.text.length < 6) {
        [self notification:@"Mật khẩu phải dài hơn 6 kí tự"];
    }
    else if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text] == 0) {
        [self notification:@"Mật khẩu không trùng khớp \n Vui lòng nhập lại mật khẩu"];
    }
    else{
        User *user = [[User alloc] initWithEmail:self.emailTextField.text fullName:self.fullNameTextField.text password:self.passwordTextField.text address:self.addressTextField.text birthday:self.datePicker.date];
        [[RegisterController getInstance] postRegisterWithUser:user];
    }
}
-(void) didRequestRegister: (User *)user taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject
{
    if (error) {
        [self notification:@"Lỗi kêt nối ! \n Vui lòng kiểm tra lại kết nối"];
    }
    else if (errorObject){
        [self notification:@"Email này đã được đăng kí \n Vui lòng sử dụng email khác hoặc tìm lại mật khẩu"];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
        [DataManager sharedInstance].currentUserLogin = user;
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateInfoLabel:)]) {
            [self.delegate updateInfoLabel:user];
        }
    }
}
- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
