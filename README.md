# 高仿糯米
高仿百度糯米iOS版，版本号5.13.0。/**作者：ljz ; Q Q：863784757 ; 注明：版权所有，转载请注明出处，不可用于其他商业用途。 */  

高仿百度糯米iOS版，版本号：5.13.0  

iOS技术交流群：112365317  

注：采用cocoapods管理第三方库，请双击nuomi.xcworkspace启动工程。不要双击nuomi.xcodeproj启动，否则会提示“library not found for -lPods-AFNetworking”


# 注
百度糯米官方版：采用少量的xib文件 + 大量的纯代码方式开发的。  

高仿糯米版本：采用storyboard创建界面为主方式来开发，跟官方版做区别。  

美团官方版：storyboard创建界面为主方式开发。  

高仿的美团5.7：以纯代码方式来开发，以作区别。  

[高仿糯米iOS](https://github.com/lookingstars/nuomi)  

[高仿美团iOS](https://github.com/lookingstars/meituan)  

React Native仿美团小demo [https://github.com/lookingstars/RNMeituan](https://github.com/lookingstars/RNMeituan)

---

下载这个Demo时，最好采用git clone方式来下载代码，这样你就可以随时pull我的最新代码，而不用重新下载zip包了。  
git命令： git clone https://github.com/lookingstars/nuomi.git  

Xcode7，真机调试，如果出现下面的错误提示，提示友盟或者科大讯飞的library不支持bitcode

解决办法：1.更新library

2.关闭bitcode（Xcode7+以上才有，以下的没有这个配置项）

![image](https://github.com/lookingstars/meituan/blob/master/meituan/screenshots/youmeng_ios9.png)

1.更新library：
友盟官方适配iOS9方案，暂时还没有适配iOS9的library。
友盟官方解决方案：http://dev.umeng.com/social/ios/ios9

2.关闭bitcode
选择工程，target-》build setting -》enable bitcode设置为NO


下面是效果图：  
![image](https://github.com/lookingstars/nuomi/blob/master/nuomi/ScreenShot/dtt1.gif)  
![image](https://github.com/lookingstars/nuomi/blob/master/nuomi/ScreenShot/dtt2.gif)  
![image](https://github.com/lookingstars/nuomi/blob/master/nuomi/ScreenShot/dtt3.gif)  
![image](https://github.com/lookingstars/nuomi/blob/master/nuomi/ScreenShot/dtt4.gif)  




