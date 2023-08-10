//
//  HomeViewController.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 04/08/2023.
//

#import "HomeViewController.h"
#import "CustomTableCell.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"

@interface HomeViewController()

{
    BOOL isGrantedNotificationAccess;
}

@end

@implementation HomeViewController



-(void) viewDidLoad {
    [super viewDidLoad];
    isGrantedNotificationAccess = false;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        self->isGrantedNotificationAccess = granted;
    }];
    
    self.data = [[NSMutableArray alloc] initWithArray:[CustomTableCell fetchCell]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    NSObject *userStore = [[NSUserDefaults standardUserDefaults] objectForKey:@"userStore"];
//    NSDictionary *parsedObject =  [NSJSONSerialization JSONObjectWithData:userStore options:kNilOptions error:nil];
    NSLog(@"userStore: %@",userStore);
}
- (IBAction)btnLocalNotification:(id)sender {
    if (isGrantedNotificationAccess) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *mucontent = [[UNMutableNotificationContent alloc] init];
        mucontent.title = @"New Notifications";
        mucontent.subtitle = @"Tap to see information";
        mucontent.body = @"This is local notifications";
        mucontent.sound = [UNNotificationSound defaultSound];
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"LocalNotification" content:mucontent trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
        
        
    }
    
}
- (IBAction)btnLogout:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"isLoggedIn"];
    [userDefaults synchronize];
//    LoginViewController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
////    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginNav];
//    [self.navigationController initWithRootViewController:loginNav];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToLogin" object:nil];
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CustomTableCell *mainCell = [self.data objectAtIndex:indexPath.row];
    UIImageView *imageMain = (UIImageView *)[cell viewWithTag:1];
    imageMain.image = [UIImage imageNamed:mainCell.image];
    imageMain.translatesAutoresizingMaskIntoConstraints = NO;
    UILabel *titleMain = (UILabel *)[cell viewWithTag:2];
    titleMain.text = mainCell.title;
    titleMain.translatesAutoresizingMaskIntoConstraints = NO;
    UILabel *subtitleMain = (UILabel *)[cell viewWithTag:3];
    subtitleMain.text = mainCell.subtitle;
    subtitleMain.translatesAutoresizingMaskIntoConstraints=NO;
    subtitleMain.numberOfLines = 2;
    return cell;
    
}


@end
