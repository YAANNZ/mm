//
//  ZMMTabBarController.m
//  mm
//
//  Created by 朱亚男 on 2022/5/16.
//

#import "ZMMTabBarController.h"
#import "ZMMAudioViewController.h"
#import "mm-Swift.h"


//#import "Flutter/Flutter.h"

@interface ZMMTabBarController ()

@end

@implementation ZMMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *audioNav = [[UINavigationController alloc] initWithRootViewController:[[ZMMAudioViewController alloc] init]];
    audioNav.title = @"Audio";
    [self addChildViewController:audioNav];
    
    UINavigationController *videoNav = [[UINavigationController alloc] initWithRootViewController:[[ZMMVideoViewController alloc] init]];
    videoNav.title = @"Video";
    [self addChildViewController:videoNav];
    
    // 1.初始化 FlutterViewController
//    FlutterViewController *readerVC = [[FlutterViewController alloc] initWithProject:nil initialRoute:@"route1?{\"message\":\"嗨，本文案来自第一个原生页面，将在Flutter页面看到我\"}" nibName:nil bundle:nil];
//    // 为FlutterViewController指定路由以及路由携带的参数
////    [readerVC setInitialRoute:@"route1?{\"message\":\"嗨，本文案来自第一个原生页面，将在Flutter页面看到我\"}"];
//    UINavigationController *readerNav = [[UINavigationController alloc] initWithRootViewController:readerVC];
//    readerNav.title = @"Reader";
//    [self addChildViewController:readerNav];
    
    // 2.初始化 FlutterEngine
//    FlutterEngine *flutterEngine = [[FlutterEngine alloc] initWithName:@"FirstFlutterViewController"];
//    // 指定路由打开某一页面，Flutter1.12版本指定路由后在Flutter代码里获取的路由统一为“/”,为Flutter bug
//    [[flutterEngine navigationChannel] invokeMethod:@"setInitialRoute" arguments:@"route1?{\"message\":\"嗨，本文案来自第一个原生页面，将在Flutter页面看到我\"}"];
//    // 路由的指定需要在FlutterEngine run方法之前，run方法之后指定路由不管用
//    [flutterEngine run];
//    // 使用FlutterEngine初始化FlutterViewController
//    FlutterViewController *readerVC = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    
    
    UINavigationController *photoNav = [[UINavigationController alloc] initWithRootViewController:[[ZMMPhotoViewController alloc] init]];
    photoNav.title = @"Photo";
    [self addChildViewController:photoNav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
