# ABAlertHelper
使用也很简单，看例子
```
[ABAlertHelper alertWithTitle:YTLocalizedString(@"定位服务未开启") message:YTLocalizedString(@"请在系统设置中开启定位服务") cancelActionTitle:YTLocalizedString(@"暂不") destructiveActionTitle:nil actionClick:^(UIAlertAction *action, NSInteger index) {
   if (index == 1) {
      NSURL *openUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
      if ([[UIApplication sharedApplication] canOpenURL:openUrl]) {
         [[UIApplication sharedApplication] openURL:openUrl];
      }
   }
} otherActionTitles:YTLocalizedString(@"去设置"), nil];
```

额外补充
```
待定。。。。。。
```
