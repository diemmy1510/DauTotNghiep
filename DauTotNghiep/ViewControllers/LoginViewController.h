#import <UIKit/UIKit.h>
#import "User.h"

@protocol LoginViewControllerDelegate <NSObject>

@optional
-(void) updateInfoLabel:(User *) user;

@end

@interface LoginViewController : UIViewController

@property(nonatomic, assign) id<LoginViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *loginMain;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

//cells
@property (strong, nonatomic) IBOutlet UITableViewCell *usernameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *doneCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cancelCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *forgotCell;

//fields
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;

- (IBAction)letMeIn:(id)sender;
- (IBAction)cancelPressed:(id)sender;
@end
