

// 通知
// 表情选中的通知
extern NSString * const XC_EmotionDidSelectNotification;

// 删除文字的通知
extern NSString * const XC_EmotionDidDeleteNotification;



#define XCNotificationCenter  [NSNotificationCenter defaultCenter]

/**  打印   */
#ifdef DEBUG
#define XCLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define XCLog(format, ...)
#endif
