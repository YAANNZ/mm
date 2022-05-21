//
//  ZMMTabBarController.m
//  mm
//
//  Created by 朱亚男 on 2022/5/16.
//

#import "ZMMTabBarController.h"
#import "ZMMAudioViewController.h"
#import "mm-Swift.h"

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
