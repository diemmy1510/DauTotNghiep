#import <UIKit/UIKit.h>

typedef enum {
    ASTextFieldTypeRound
}ASTextFieldType;

@interface ASTextField : UITextField

@end


@interface UITextField ()
- (void)setupTextFieldWithType:(ASTextFieldType)type withIconName:(NSString *)name;
@end
