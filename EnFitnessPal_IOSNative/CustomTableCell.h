//
//  CustomTableCell.h
//  EnFitnessPal_IOSNative
//
//  Created by G on 07/08/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableCell : NSObject

@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;

-(instancetype) initWithImage: (NSString *)image title:(NSString *)title subtitle:(NSString *)subtitle;

+ (NSMutableArray *)fetchCell;

@end

NS_ASSUME_NONNULL_END
