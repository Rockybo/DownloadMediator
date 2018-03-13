# DownloadMediator
#简介
下载器的功能，当前只实现了下载和暂停的功能，通过action-target形式进行中间者的调度，降低使用者与组件的耦合度。
#案例参考
仔细研究了CTMediator的代码，看完后对Objective-C语言的消息发送理解的更加清晰。
CTMediator介绍两种方式：1、通过本地组件调用入口 2、通过远程APP调用入口
原理分析：通过中介者模式来处理对象的action
#项目
1、通过自己的Pod私有库来实现组件化功能
2、通过Action-target方案实现消息发送
#Cocoapods私有库
一、通过第三方托管平台(coding.net、gitee.com)搭建一个远程私有库索引(XXXSpecs)
二、创建Pod私有索引库
pod repo add XXXSpecs SSH地址
三、创建pod私有库
	1、创建模板  pod lib create DownloadLib
	2、拖入代码
	3、添加git远程仓库关联 git remote add origin 私有库远程地址
	4、修改spec
	5、提交本地仓库代码到远程仓库
	6、打标签并且提交标签到远程地址
		git tag -a '0.1.0'  -m '备份0.1.0'
		git push --tas
	7、本地验证 pod lib lint (pod lib lint --allow-warnings)
	8、远程验证 pod spec lint
	9、本地索引库提交 pod repo push XXXSpecs XXXLib.podspec




