//
//  HomeViewController.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 04/08/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>


@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *localNotificationbtn;

@property (strong, nonatomic) NSMutableArray *data;

@end

