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
