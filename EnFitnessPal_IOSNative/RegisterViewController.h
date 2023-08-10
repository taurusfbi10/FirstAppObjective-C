//
//  RegisterViewController.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 09/08/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldConfirmPass;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegister;
- (void) styleTextField: (UITextField *)textField  isPassword: (BOOL)isPassword isConfirm: (BOOL)isConfirm;
@end

NS_ASSUME_NONNULL_END
