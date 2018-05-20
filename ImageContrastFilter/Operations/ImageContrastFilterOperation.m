//
//  ImageFilterOperation.m
//  ImageFilter
//
//  Created by Saikiran on 10/08/16.
//  Copyright © 2016 Saikiran. All rights reserved.
//

#import "ImageContrastFilterOperation.h"

@implementation ImageContrastFilterOperation



- (void)setImage:(UIImage *)image andContrast:(CGFloat)contrast completion: (void (^)(UIImage *))completion{
	self.image = image;
	self.contrast = contrast;
	self.completion  = completion;
}


- (void) main {
	
 @autoreleasepool {
	
	if (self.isCancelled) {
		return;
	}
		
	CIContext *context = [CIContext contextWithOptions:nil];               // 1
	
	CIImage *image =  [CIImage imageWithData:UIImagePNGRepresentation(self.image)];
	 CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];// 3
	[filter setValue:image forKey:kCIInputImageKey];
	[filter setValue:[NSNumber numberWithFloat:self.contrast] forKey:kCIInputContrastKey];
	if (self.isCancelled) {
		return;
	}

	CIImage *result = [filter valueForKey:kCIOutputImageKey];
	if (self.isCancelled) {
		return;
	}
	// 4
	CGRect extent = [result extent];
	
	if (self.isCancelled) {
		return;
	}
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		
		if (self.isCancelled) {
			return;
		}
		CGImageRef cgImage = [context createCGImage:result fromRect:extent];   // 5
		
		self.completion([[UIImage alloc] initWithCGImage:cgImage]);
		

	}];

	}
	
}

@end
