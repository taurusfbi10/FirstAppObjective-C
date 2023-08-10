//
//  ViewController.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 02/08/2023.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* password;
- (IBAction)handleLogin:(id)sender;

- (void) styleTextField: (UITextField *)textField  isPassword: (BOOL)isPassword;

- (void) setupContraintsTextField: (UITextField *)textField;

@end

