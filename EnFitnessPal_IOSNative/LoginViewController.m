//
//  ViewController.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 02/08/2023.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import <AFNetworking.h>



@interface LoginViewController ()
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(390, 844)];
    self.textFieldPassword.secureTextEntry = YES;
    self.textFieldEmail.delegate = self;
    self.textFieldPassword.delegate = self;
    
    [self styleTextField:self.textFieldEmail isPassword:NO];
    [self styleTextField:self.textFieldPassword isPassword:YES];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd/MM/yyyy z HH:mm:ss"];
    NSLog(@"%@",currentDate);
    NSString *formatDate = [dateFormatter stringFromDate:currentDate];
    NSLog(@"%@",currentDate);
    NSLog(@"%@",formatDate);
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
    [self.scrollView scrollRectToVisible:textFieldFrame animated:YES];
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
}

- (void)styleTextField:(UITextField *)textField isPassword:(BOOL)isPassword{
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
    if(isPassword) {
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
        [buttonEyes addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        textField.rightView = rightView;
//        textField.rightView = buttonEyes;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
}

- (void)tappedButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.textFieldPassword.secureTextEntry = !sender.selected;
}

- (void) startLoading {
    self.overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.center = self.view.center;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    [self.view addSubview:self.overlayView];
}

- (void) stopLoading {
    [self.activityIndicator stopAnimating];
    
    // Xóa UIActivityIndicatorView và overlay view khỏi self.view
    [self.activityIndicator removeFromSuperview];
    [self.overlayView removeFromSuperview];
}

- (IBAction)handleLogin:(id)sender {
    [self startLoading];
    NSLog(@"Email is: %@ \n Password is %@",self.textFieldEmail.text, self.textFieldPassword.text);
    
    NSString *urlString = @"https://qdfd3vamwuca2ou6a63flfzvqy0nvuds.lambda-url.ap-east-1.on.aws/api/auth/login";
    
    NSDictionary *parameters = @{
            @"EmailAddress": self.textFieldEmail.text,
            @"Password": self.textFieldPassword.text
        };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POST request success, response: %@", responseObject);
        NSUserDefaults *storeResponseObject = [NSUserDefaults standardUserDefaults];
        [storeResponseObject setObject:responseObject forKey:@"userStore"];
        [storeResponseObject setBool:YES forKey:@"isLoggedIn"];
        [storeResponseObject synchronize];
        
        [self stopLoading];
        HomeViewController *homeNavigation = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self.navigationController setViewControllers:@[homeNavigation] animated:YES];
//        [UIApplication sharedApplication].delegate.window.rootViewController = self.navigationController;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POST request failed, error: %@", error);
        [self stopLoading];
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please login again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertError addAction:okAction];
        [self presentViewController:alertError animated:YES completion:nil];
    }];
    
    
}

@end


