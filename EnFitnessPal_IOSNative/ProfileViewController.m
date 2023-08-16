//
//  ProfileViewController.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 15/08/2023.
//

#import "ProfileViewController.h"
#import "CellPageControl.h"

@interface ProfileViewController ()
@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = @[@"image1", @"image2", @"image3"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.imageArray.count;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}

- (void)scrollToNextPage {
    self.currentIndex = (self.currentIndex + 1) % self.imageArray.count;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    self.pageControl.currentPage = self.currentIndex;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CellPageControl *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imagePage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.currentIndex = self.collectionView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = self.currentIndex;
    NSIndexPath *centerIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:centerIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
