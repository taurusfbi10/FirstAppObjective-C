//
//  SettingsViewController.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 11/08/2023.
//

#import "SettingsViewController.h"

@interface SettingsViewController (){
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dateSelected;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.alertView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    self.blurView.bounds =self.view.bounds;
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    CGFloat widthScreen = [[UIScreen mainScreen] bounds].size.width;
    CGFloat heightScreen = [[UIScreen mainScreen] bounds].size.height;

    self.scrollViewSetting.showsVerticalScrollIndicator = NO;
    self.scrollViewSetting.showsHorizontalScrollIndicator = NO;
    [self.scrollViewSetting setContentSize:CGSizeMake(widthScreen, heightScreen)];
    
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    self.alertView.layer.cornerRadius = 10;
    [self setBottomLeftCornerRadiusForButton:self.okBtn cornerRadius:10 cornerDicrection:@"bottomLeft"];
    [self setBottomLeftCornerRadiusForButton:self.cancelBtn cornerRadius:10 cornerDicrection:@"bottomRight"];
    
}

- (IBAction)didGoTodayTouch:(id)sender {
    [_calendarManager setDate:_todayDate];
}
- (IBAction)didChangeModeTouch:(id)sender {
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}


#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
        [self->_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}


#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    
    return label;
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
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
    NSDate *selectedDate = self.datePicker.date;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"]; // Định dạng ngày tháng tùy ý
//    NSString *dateString = [dateFormatter stringFromDate:selectedDate];
    NSLog(@"Selected Date: %@", selectedDate);
    
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
