//
//  UIImage+RotationMethods.h
//  ImageFilter
//
//  Created by Saikiran on 11/08/16.
//  Copyright © 2016 Saikiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HelperMethods)
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
+ (UIImage *)imageFromColor:(UIColor *)color;
-(UIImage *)compressImagetoMaxFileSize:(int)size;
- (UIImage *)rotateImage:(UIImage *)image onDegrees:(float)degrees;
- (UIImage *)fixOrientation;
+ (UIImage*)imageWithBorderFromImage:(UIImage*)source;
@end

