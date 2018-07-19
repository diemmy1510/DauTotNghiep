#import <UIKit/UIKit.h>
#import "User.h"

@protocol RegisterViewControllerDelegate <NSObject>

@optional
-(void) updateInfoLabel:(User *) user;

@end

@interface RegisterViewController : UIViewController

@property(nonatomic, assign) id<RegisterViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *registerMain;
@property (weak, nonatomic) IBOutlet UITableView *registerTableView;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
// cells
@property (strong, nonatomic) IBOutlet UITableViewCell *emailRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *addressRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *birthdayRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *passwordRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *confirmPasswordRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *doneRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cancelRegisterCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *calendarCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *fullNameCell;

// fields
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;

- (IBAction)registerPressed:(id)sender;


@end
