//
//  AppDelegate.m
//  mm
//
//  Created by 朱亚男 on 2022/5/10.
//

#import "AppDelegate.h"
#import "mm-Swift.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    // Flutter (Dart VM) 的 HTTP 请求走 BSD socket 而非 NSURLSession，
    // 首次安装后直连局域网 IP 不会触发 iOS 网络权限弹窗，导致请求直接失败 (errno 65)。
    // 这里用 NSURLSession 发一个轻量请求，强制 iOS 弹出网络权限对话框。
    // 授权后 Dart 的 socket 请求也能正常访问局域网。仅 Debug 模式执行。
    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"https://www.apple.com"]
                               completionHandler:^(NSData *d, NSURLResponse *r, NSError *e) {}] resume];
#endif

    // Pre-warm Flutter engine
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"main_engine"];
    [self.flutterEngine run];

    // Register Flutter plugins
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];

    // Register voice channel handler (STT/TTS bridge)
    self.voiceHandler = [[VoiceChannelHandler alloc] init];
    [self.voiceHandler registerWith:self.flutterEngine];

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}

@end
