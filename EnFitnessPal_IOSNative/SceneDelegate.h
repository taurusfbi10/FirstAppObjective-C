//
//  SceneDelegate.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 02/08/2023.
//

#import <UIKit/UIKit.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;
- (void) switchToLoginScreen:(NSNotification *)notification;

@end

