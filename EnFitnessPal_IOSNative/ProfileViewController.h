//
//  ProfileViewController.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 15/08/2023.
//

#import <UIKit/UIKit.h>
#import "PageControl/PageControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger currentIndex;
@end

NS_ASSUME_NONNULL_END
