
#import <UIKit/UIKit.h>
// 通知
// 表情选中的通知
NSString * const XC_EmotionDidSelectNotification = @"XC_EmotionDidSelectNotification";

// 删除文字的通知
NSString * const XC_EmotionDidDeleteNotification = @"XC_EmotionDidDeleteNotification";

//选中某个表情发出的通知
NSString * const XC_SelectEmotionNotification = @"XC_SelectEmotionNotification";

//删除某个表情。存入通知userInfo字典的key
NSString * const XC_SelectEmotionKey = @"XC_DeleteEmotionKey";

CGFloat inputHeight = 34 ;//输入框的默认高度
CGFloat keyboardHeight = 216 ; //默认的键盘的高度
