//
//  SettingsViewController.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 11/08/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <JTCalendarDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewSetting;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIView *blurView;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@end

NS_ASSUME_NONNULL_END
