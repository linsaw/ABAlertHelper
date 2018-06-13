//
//  ABAlertHelper.m
//  Wildto
//
//  Created by Wildto on 2016/11/18.
//  Copyright © 2016年 Wildto. All rights reserved.
//

#import "ABAlertHelper.h"

@implementation ABAlertHelper

+ (UIViewController *)topViewController
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = rootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelActionTitle:(NSString *)cancelActiontitle destructiveActionTitle:(NSString *)destructiveActionTitle actionClick:(void (^)(UIAlertAction *action,NSInteger index))actionClick otherActionTitles:(NSString *)otherActionTitles, ...
{
    NSMutableArray *actions = [NSMutableArray array];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //cancelAction
    if (cancelActiontitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActiontitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionClick) {
                actionClick(action,0);
            }
        }];
        [actions addObject:cancelAction];
    }
    
    //destructiveAction
    if (destructiveActionTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveActionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (actionClick) {
                actionClick(action,-1);
            }
        }];
        [actions addObject:destructiveAction];
    }
    
    //遍历列表
    va_list args;
    id arg = nil;
    
    //num记录action的位置
    int num = 1;
    
    //otherAction
    //先把第一个存入数组
    if (otherActionTitles) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherActionTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionClick) {
                actionClick(action,num);
            }
        }];
        [actions addObject:otherAction];
        
        //扫描参数列表
        va_start(args,otherActionTitles);
        while ((arg = va_arg(args, id))) {
            if ([arg isKindOfClass:[NSString class]]) {
                num ++;
                //创建action
                otherAction =  [UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (actionClick) {
                        actionClick(action,num);
                    }
                }];
                [actions addObject:otherAction];
            }
            else {
                break;
            }
        }
        va_end(args);
    }
    
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
        if (IS_IOS9_ABOVE) {
            if (destructiveActionTitle && action.style == UIAlertActionStyleDestructive) {
                alertController.preferredAction = action;
            }
        }
    }
    
    [[ABAlertHelper topViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message cancelActionTitle:(NSString *)cancelActiontitle otherActionTitles:(NSArray *)otherActionTitles actionClick:(void (^)(UIAlertAction *action,NSInteger index))actionClick
{
    if (cancelActiontitle.length <= 0 && otherActionTitles.count == 0) {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (cancelActiontitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActiontitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (actionClick) {
                actionClick(action,0);
            }
        }];
        [alertController addAction:cancelAction];
    }
    
    for (NSInteger num = 0; num < otherActionTitles.count; num ++) {
        NSString *otherTitle = otherActionTitles[num];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionClick) {
                actionClick(action,num + 1);
            }
        }];
        [alertController addAction:otherAction];
    }
    
    [[ABAlertHelper topViewController] presentViewController:alertController animated:YES completion:nil];
}

@end
