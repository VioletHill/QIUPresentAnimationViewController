# QIUPresentKit


仿照  iOS 内置的邮件 App 点击新建后弹出一个编辑邮件的 ViewController 的效果

![Demo](demo.gif)

使用

	#import "QIUPresentKit.h"

	UIViewController *nextController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    QIUPresentViewController *controller = [[QIUPresentViewController alloc] initWithViewController:nextController];
    //    nextController.topGuide = 80;
	//    nextController.scale = 0.9;
    [self presentViewController:controller animated:YES completion:nil];
    
具体说明实现见 [这里](http://qiufeng.me/ios8uipresentationcontroller)
