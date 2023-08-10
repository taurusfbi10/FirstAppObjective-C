//
//  CustomTableCell.m
//  EnFitnessPal_IOSNative
//
//  Created by G on 07/08/2023.
//

#import "CustomTableCell.h"
#import "HomeViewController.h"

@implementation CustomTableCell

- (instancetype) initWithImage:(NSString *)image title:(NSString *)title subtitle:(NSString *)subtitle {
    if (self = [super init]) {
        self.image = image;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}

+ (NSArray *) fetchCell {
    return @[
    [[CustomTableCell alloc] initWithImage:@"google" title:@"Google" subtitle:@"Google is big company about technology!"],
    [[CustomTableCell alloc] initWithImage:@"twitter" title:@"Twitter" subtitle:@"Twiter is big social of the world!"],
    [[CustomTableCell alloc] initWithImage:@"facebook" title:@"Facebook" subtitle:@"Facebook is the most social media of the world!"],
    ];
    
}

@end
