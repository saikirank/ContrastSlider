//
//  ImageFilterOperation.h
//  ImageFilter
//
//  Created by Saikiran on 10/08/16.
//  Copyright © 2016 Saikiran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageContrastFilterOperation : NSOperation
@property (nonatomic, assign) CGFloat contrast;
@property (nonatomic, strong) UIImage *image;
@property (strong) void (^completion) (UIImage *);

- (void)setImage:(UIImage *)image andContrast:(CGFloat)contrast completion: (void (^)(UIImage *))completion;
@end
