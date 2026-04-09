//
//  AppDelegate.h
//  mm
//
//  Created by 朱亚男 on 2022/5/10.
//

#import <UIKit/UIKit.h>
@import Flutter;

@class VoiceChannelHandler;

@interface AppDelegate : FlutterAppDelegate

@property (nonatomic, strong) FlutterEngine *flutterEngine;
@property (nonatomic, strong) VoiceChannelHandler *voiceHandler;

@end
