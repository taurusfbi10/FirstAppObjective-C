//
//  CellPageControl.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 16/08/2023.
//

#import "CellPageControl.h"

@implementation CellPageControl

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imagePage.layer.cornerRadius = 10.0; // Đặt bán kính cong viền là 10.0 (hoặc bất kỳ giá trị nào bạn muốn)
    self.imagePage.clipsToBounds = YES; // Để đảm bảo hình ảnh không vượt qua viền làm tròn
}


@end
