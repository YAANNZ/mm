//
//  SceneDelegate.m
//  mm
//
//  Created by 朱亚男 on 2022/5/10.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
@import Flutter;

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if ([scene isKindOfClass:[UIWindowScene class]]) {
        UIWindow *window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];

        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        FlutterEngine *engine = appDelegate.flutterEngine;

        FlutterViewController *flutterVC = [[FlutterViewController alloc] initWithEngine:engine nibName:nil bundle:nil];
        // White background to avoid black flash during Flutter engine init
        flutterVC.view.backgroundColor = [UIColor whiteColor];

//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:flutterVC];
//        navController.navigationBarHidden = YES;

        window.rootViewController = flutterVC;
        window.backgroundColor = [UIColor whiteColor];
        self.window = window;
        [window makeKeyAndVisible];
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
}

- (void)sceneWillResignActive:(UIScene *)scene {
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
}

@end
