//
//  ZMMAudioViewController.m
//  mm
//
//  Created by 朱亚男 on 2022/5/16.
//

#import "ZMMAudioViewController.h"
#import "TYPagerController.h"

@interface ZMMAudioViewController ()

@end

@implementation ZMMAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Audio";
    
    TYPagerController *vc = [[TYPagerController alloc] init];
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
