//
//  ViewController.m
//  ImageContrastFilter
//
//  Created by Saikiran on 19/05/18.
//

#import "ViewController.h"
#import "ImageContrastFilterOperation.h"
#import "UIImage+Helper.h"
#import <Photos/Photos.h>
#import "Helper.h"
#import "DGActivityIndicatorView.h"
@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
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

#pragma mark method to check Camera access permission
- (void)showImagePicker:(BOOL)launchCamera {
    
    if (launchCamera && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [Helper showAlertMessage:@"Device has no camera" targetVC:self];
        
        return;
    }
    if (launchCamera) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted)
            {
                [self showcamera];
            }
            else {
                
                
                if (authStatus != AVAuthorizationStatusNotDetermined) {
                    [self camDenied];
                }
            }
            
        }];
        
    }
    else {
        //Photo library
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                [self showPhotoLibrary];
            }
            else {
                if (authStatus != PHAuthorizationStatusNotDetermined) {
                    [self photoLibraryPermissionDenied];
                    
                }
            }
            
        }];
    }
    
}
#pragma mark Show camera
-(void)showcamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.showsCameraControls = YES;
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark Show photo library
-(void)showPhotoLibrary {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:NULL];
    
}
#pragma mark methods to handle Cam/Photo libaray access denied
- (void)camDenied
{
    NSString *alertText = @"To take pictures, you have to authorize App! to use the camera. You can configure it in Settings on your device.";
    [Helper showConfirmation:alertText confirmTitle:@"Yes" cancelTitle:@"No" onVC:self confirmAction:^{
        
        BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
        if (canOpenSettings)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        
    } cancelAction:^{
    }];
}

- (void)photoLibraryPermissionDenied
{
    
    NSString *alertText = @"To use photos, you have to authorize App! to access it. You can configure it in Settings on your device.";
    [Helper showConfirmation:alertText confirmTitle:@"Yes" cancelTitle:@"No" onVC:self confirmAction:^{
        
        BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
        if (canOpenSettings)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        
        
    } cancelAction:^{
        
    }];
    
}


- (BOOL)shouldAutorotate
{
    return NO;
}
#pragma mark Imagepicker delegate methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeThreeDots tintColor:[UIColor redColor] size:20.0f];
    activityIndicatorView.frame = self.view.bounds;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    //compress image to max 1mb
    UIImage *chosenImage = [[info[UIImagePickerControllerOriginalImage] fixOrientation] compressImagetoMaxFileSize:1024];
    [activityIndicatorView stopAnimating];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];

}


@end
