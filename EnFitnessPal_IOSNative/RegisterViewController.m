//
//  RegisterViewController.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 09/08/2023.
//

#import "RegisterViewController.h"

@implementation RegisterViewController


- (void)viewDidLoad {
    [self.scrollView setScrollEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO];
    CGFloat widthScreen = [[UIScreen mainScreen] bounds].size.width;
    CGFloat heightScreen = [[UIScreen mainScreen] bounds].size.height;
    NSLog(@"%f %f",widthScreen,heightScreen);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentSize:CGSizeMake(widthScreen, heightScreen)];
    self.textFieldPassword.secureTextEntry = YES;
    self.textFieldConfirmPass.secureTextEntry = YES;
    [self styleTextField:self.textFieldPassword isPassword:YES isConfirm:NO];
    [self styleTextField:self.textFieldName isPassword:NO isConfirm:NO];
    [self styleTextField:self.textFieldEmail isPassword:NO isConfirm:NO];
    [self styleTextField:self.textFieldPhone isPassword:NO isConfirm:NO];
    [self styleTextField:self.textFieldConfirmPass isPassword:YES isConfirm:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [self.view addGestureRecognizer:tapGesture];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    // Lấy thông tin về kích thước bàn phím
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
    
    // Điều chỉnh kích thước của UIScrollView để bàn phím không che mất text field
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // Đảm bảo text field được nhìn thấy bằng cách scroll nếu cần
    CGRect textFieldFrame = [self.scrollView convertRect:self.textFieldPassword.bounds fromView:self.textFieldPassword];
    CGRect textFieldFrame1 = [self.scrollView convertRect:self.textFieldConfirmPass.bounds fromView:self.textFieldConfirmPass];
    CGRect textFieldFrame2 = [self.scrollView convertRect:self.textFieldEmail.bounds fromView:self.textFieldEmail];
    CGRect textFieldFrame3 = [self.scrollView convertRect:self.textFieldPhone.bounds fromView:self.textFieldPhone];
    CGRect textFieldFrame4 = [self.scrollView convertRect:self.textFieldName.bounds fromView:self.textFieldName];
    [self.scrollView scrollRectToVisible:textFieldFrame animated:YES];
    [self.scrollView scrollRectToVisible:textFieldFrame1 animated:YES];
    [self.scrollView scrollRectToVisible:textFieldFrame2 animated:YES];
    [self.scrollView scrollRectToVisible:textFieldFrame3 animated:YES];
    [self.scrollView scrollRectToVisible:textFieldFrame4 animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // Đặt lại kích thước ban đầu cho UIScrollView khi bàn phím ẩn đi
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)dealloc {
    // Hủy đăng ký observer khi không sử dụng nữa để tránh lỗi
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return YES;
}

- (void) handleTap{
    [self.textFieldEmail resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
    [self.textFieldName resignFirstResponder];
    [self.textFieldConfirmPass resignFirstResponder];
    [self.textFieldPhone resignFirstResponder];
}

- (void)styleTextField:(UITextField *)textField isPassword:(BOOL)isPassword isConfirm:(BOOL)isConfirm{
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 10;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.shadowColor = [UIColor blackColor].CGColor;
    textField.layer.shadowOffset = CGSizeMake(0, 0.8);
    textField.layer.shadowOpacity = 0.23;
    textField.layer.shadowRadius = 2.62;
    if(isPassword == YES) {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        UIButton *buttonEyes = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImage *eye = [UIImage systemImageNamed:@"eye.fill"];
        UIImage *eyehiden = [UIImage systemImageNamed:@"eye.slash.fill"];
        [rightView addSubview:buttonEyes];
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 12)];
        [rightView addSubview:paddingView1];
        [buttonEyes setImage:eye forState:UIControlStateNormal];
        [buttonEyes setImage:eyehiden forState:UIControlStateSelected];
        buttonEyes.tintColor = [UIColor blackColor];
        isConfirm == YES ? [buttonEyes addTarget:self action:@selector(tappedButton1:) forControlEvents:UIControlEventTouchUpInside] : [buttonEyes addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];

        textField.rightView = rightView;
//        textField.rightView = buttonEyes;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
}

- (void)tappedButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.textFieldPassword.secureTextEntry = !sender.selected;
}

- (void)tappedButton1:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.textFieldConfirmPass.secureTextEntry = !sender.selected;
}

@end

