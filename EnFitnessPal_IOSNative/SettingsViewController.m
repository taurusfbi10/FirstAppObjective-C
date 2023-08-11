//
//  SettingsViewController.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 11/08/2023.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.alertView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
//    self.blurView.bounds =self.view.bounds;
    self.alertView.layer.cornerRadius = 10;
    [self setBottomLeftCornerRadiusForButton:self.okBtn cornerRadius:10 cornerDicrection:@"bottomLeft"];
    [self setBottomLeftCornerRadiusForButton:self.cancelBtn cornerRadius:10 cornerDicrection:@"bottomRight"];
    
}

- (void)setBottomLeftCornerRadiusForButton:(UIButton *)button cornerRadius:(CGFloat)cornerRadius cornerDicrection:(NSString *)cornerDicrection
{
    if ([cornerDicrection  isEqual: @"bottomLeft"]) cornerRadius = UIRectCornerBottomLeft;
    if ([cornerDicrection  isEqual: @"bottomRight"]) cornerRadius = UIRectCornerBottomRight;
    
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                                     byRoundingCorners:cornerRadius
                                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = roundedPath.CGPath;
    button.layer.mask = shapeLayer;
}

- (IBAction)okBtn:(id)sender {
    [self animatedViewOut:self.alertView];
}
- (IBAction)cancelBtn:(id)sender {
    [self animatedViewOut:self.alertView];
}
- (IBAction)showAlert:(id)sender {
    [self animatedAlertIn:self.alertView];
}

- (void) animatedAlertIn: (UIView *)view {
    self.blurView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.blurView.backgroundColor = [UIColor blackColor];
    self.blurView.alpha = 0.5;
    [self.view addSubview:self.blurView];
    [self.view addSubview:view];
    [view setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    [view setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    view.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        view.alpha = 1;
    }];
    
}
- (void) animatedViewOut: (UIView *)view {
    [view setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    [view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    view.alpha = 1;
    
    [UIView animateWithDuration:0.3 animations:^{
        [view setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
        view.alpha = 0;
    }   completion:^(BOOL finished) {
        [self.blurView removeFromSuperview];
        [view removeFromSuperview];
    }];
}

@end
