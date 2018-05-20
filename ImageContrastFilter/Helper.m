
//
//  Helper.m
//  ImageContrastFilter
//
//  Created by Saikiran Komirishetty on 20/05/18.
//

#import "Helper.h"

@implementation Helper

+(void)showConfirmation:(NSString*)message confirmTitle:(NSString*)confirmTitle
            cancelTitle:(NSString*)cancelTitle onVC:(UIViewController *)vc
          confirmAction:(void(^)(void))confirmAction cancelAction:(void(^)(void))cancelAction
{
    [self showAlertMessage:message firstButtonTitle:confirmTitle secondButtonTitle:cancelTitle
                  delegate:vc firstBtnAction:confirmAction secondBtnAction:cancelAction];
}


+(void)showAlertMessage:(NSString *)message targetVC:(UIViewController *)vc
{
    [self showAlertMessage:message firstButtonTitle:@"Ok"
         secondButtonTitle:nil delegate:vc firstBtnAction:^{
             [vc dismissViewControllerAnimated:YES completion:nil];
         } secondBtnAction:nil];
}

+(void)showAlertMessage:(NSString *)message targetVC:(UIViewController *)vc
            buttonTitle:(NSString *)btnTitle buttonAction:(void(^)(void))buttonAction
{
    [self showAlertMessage:message firstButtonTitle:btnTitle secondButtonTitle:nil delegate:vc
            firstBtnAction:buttonAction secondBtnAction:nil];
}



+(void)showAlertMessage:(NSString *)message firstButtonTitle:(NSString *)firstButtonTitle
      secondButtonTitle:(NSString *)secondButtonTitle delegate:(id)delegate
         firstBtnAction:(void(^)(void))firstBtnActionBlock secondBtnAction:(void(^)(void))secondBtnActionBlock
{
    //Helvetica Neue
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil preferredStyle:UIAlertControllerStyleAlert];
    alertController.title = message;
    if (firstButtonTitle)
    {
        [alertController addAction:({
            [UIAlertAction actionWithTitle:firstButtonTitle style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                       if (firstBtnActionBlock) { firstBtnActionBlock(); }
                                   }]; })];
    }
    
    if (secondButtonTitle)
    {
        [alertController addAction:({
            [UIAlertAction actionWithTitle:secondButtonTitle style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                       if (secondBtnActionBlock) { secondBtnActionBlock(); }
                                   }]; })];
    }
    
    [delegate presentViewController:alertController animated:YES completion:nil];

}
+(void)performOperationOnMainQueue :(void(^)(void))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        completion();
    });
}

@end
