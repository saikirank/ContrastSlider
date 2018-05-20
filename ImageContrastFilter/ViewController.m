//
//  ViewController.m
//  ImageContrastFilter
//
//  Created by Saikiran on 19/05/18.
//

#import "ViewController.h"
#import "ImageContrastFilterOperation.h"
#import "UIImage+Helper.h"
@interface ViewController ()
@property (strong, nonatomic)  NSOperationQueue *operationQueue;
@property (strong, nonatomic) IBOutlet UIButton *rotateLeftButton;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIButton *rotateRightButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.operationQueue = [[NSOperationQueue alloc] init];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions
- (void) sliderMoved:(UISlider *)sender
{
    UIImage *originalImage = [UIImage imageNamed:@"img"];
    
    [self.operationQueue cancelAllOperations];
    ImageContrastFilterOperation *op = [[ImageContrastFilterOperation alloc]init];
    [op setImage:originalImage andContrast:(sender.value) completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    [self.operationQueue addOperation:op];
}

-(IBAction)rotateLeft{
    
    [self rotateimageByDegrees:90];
    
}
-(IBAction)rotateRight{
    [self rotateimageByDegrees:-90];
}

-(void)rotateimageByDegrees:(int)degrees{
    
    UIImage *rotatedImage = [self.imageView.image imageRotatedByDegrees:degrees];
    self.imageView.image = rotatedImage;
}



@end
