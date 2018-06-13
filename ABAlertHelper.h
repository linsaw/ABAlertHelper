//
//  ABAlertHelper.h
//  Wildto
//
//  Created by Wildto on 2016/11/18.
//  Copyright © 2016年 Wildto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YTAlertAction;

@interface ABAlertHelper : NSObject

/**
 Alert

 @param title 标题
 @param message 内容信息
 @param cancelActiontitle 取消按钮标题
 @param destructiveActionTitle 强调红色警示按钮标题
 @param actionClick 按钮点击Block回调
 @param otherActionTitles 其他按钮标题
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelActionTitle:(NSString *)cancelActiontitle destructiveActionTitle:(NSString *)destructiveActionTitle actionClick:(void(^)(UIAlertAction *action, NSInteger index))actionClick otherActionTitles:(NSString *)otherActionTitles,...NS_REQUIRES_NIL_TERMINATION;

/**
 ActionSheet

 @param title 标题
 @param message 内容信息
 @param cancelActiontitle 取消按钮标题
 @param otherActionTitles 其他标题
 @param actionClick 按钮点击Block回调
 */
+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message cancelActionTitle:(NSString *)cancelActiontitle otherActionTitles:(NSArray *)otherActionTitles actionClick:(void (^)(UIAlertAction *action, NSInteger index))actionClick;


@end
