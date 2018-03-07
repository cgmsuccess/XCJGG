# XCJGG & XC_keyboardManager

### 此demo主要是简单的写了一个 九宫格 和 表情键盘 。

[Stata](http:\\www.stata.com)
<a href= "target" ></a>
[如果你喜欢，请送我一个星星鼓励✨✨✨✨✨✨✨✨✨✨吧😄](https://github.com/cgmsuccess/XCJGG)

###  此demo参考了小码哥代码。主要在于学习，，内部UI和逻辑已经封装好了 XC_EmotionsView  。XC_EmotionInputView 希望你喜欢，便于快速开发。大神勿喷



### 键盘的思维导图。大致流程

![屏幕快照 2018-03-06 下午5.31.05.png](http://upload-images.jianshu.io/upload_images/2018474-2d6101ec76f11266.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 里面涉及的正则学习记录，可以配合demo看
地址<https://www.jianshu.com/p/32eeb62687e2>

### 简单的效果图

![test1.gif](http://upload-images.jianshu.io/upload_images/2018474-a97ea1160f2c2629.gif?imageMogr2/auto-orient/strip)

### 使用方法
直接导入  XC_emotionKeyBoard  文件夹， 表情键盘是 依赖 masonry.h 第三方库，。 使用
导入 #import "XC_keyboardManager.h"   XC_keyboardManager.h 内部已经导入了 masonry.h 。如果工程没有masonry.h，那么会报错。导入masonry.h 即可

具体使用demo 情况已经写的很清楚。我把2种写好了UI和逻辑的 XC_EmotionsView  。XC_EmotionInputView ，如果嫌麻烦直接可以用这2个。通过 XC_keyboardManager 键盘管理类，进行创建。

内部使用了正则框架 RegexKitLite , 导入了 XC_emotionKeyBoard 文件夹后，需要在 Build Phases 设置，找到RegexKitLite.m  设置 -fno-objc-arc
同时导入动态库  libcucore.tbd


![屏幕快照 2018-03-06 下午5.43.30.png](http://upload-images.jianshu.io/upload_images/2018474-b715b0ed06db808b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![屏幕快照 2018-03-06 下午5.43.25.png](http://upload-images.jianshu.io/upload_images/2018474-61bb7ccb14c65fa6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


```
    //自定义键盘
    self.view.backgroundColor = [UIColor whiteColor];
    XC_keyboardManager *manager  = [[XC_keyboardManager alloc] init];
    self.keyBoardManager = manager ;
    XC_EmotionInputView *emtionsInputView = [manager getXC_EmotionInputView];
    emtionsInputView.stringAndHeightHandle = ^(NSString *inputString, CGFloat height) {

    };
    emtionsInputView.backgroundColor = [UIColor whiteColor];
    emtionsInputView.frame =  CGRectMake(0, KmainScreenHeiht,  KmainScreenWidth, 106);

    //一定要设置
    emtionsInputView.keyBoardY = KmainScreenHeiht ;
    emtionsInputView.delegate = self;
    [self.view addSubview:emtionsInputView];

    //唤起键盘
    [self.keyBoardManager.getXC_EmotionInputView showXCKeyboard];

```




