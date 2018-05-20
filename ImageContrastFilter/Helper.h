//
//  Helper.h
//  ImageContrastFilter
//
//  Created by Saikiran Komirishetty on 20/05/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject
+(void)showConfirmation:(NSString*)message confirmTitle:(NSString*)confirmTitle
            cancelTitle:(NSString*)cancelTitle onVC:(UIViewController *)vc
          confirmAction:(void(^)(void))confirmAction cancelAction:(void(^)(void))cancelAction;
+(void)showAlertMessage:(NSString *)message targetVC:(UIViewController *)vc;
+(void)showAlertMessage:(NSString *)message firstButtonTitle:(NSString *)firstButtonTitle
      secondButtonTitle:(NSString *)secondButtonTitle delegate:(id)delegate
         firstBtnAction:(void(^)(void))firstBtnActionBlock secondBtnAction:(void(^)(void))secondBtnActionBlock;
+(void)performOperationOnMainQueue :(void(^)(void))completion;
@end
