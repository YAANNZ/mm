//
//  ZMMAudioViewController.m
//  mm
//
//  Created by 朱亚男 on 2022/5/16.
//

#import "ZMMAudioViewController.h"
#import "TYTabPagerBar.h"
#import "TYPagerView.h"
#import "ZMMAudioContentVC.h"
#import <Masonry/Masonry.h>

@interface ZMMAudioViewController () <TYTabPagerBarDataSource, TYTabPagerBarDelegate, TYPagerViewDataSource, TYPagerViewDelegate>

@property (nonatomic, strong) TYTabPagerBar *pagerBar;
@property (nonatomic, strong) TYPagerView *pagerView;
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSArray<UIView *> *childViewAry;

@end

@implementation ZMMAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupSubviews];
}

- (void)setupSubviews {
    self.title = @"Audio";
    
    TYTabPagerBar *pagerBar = [[TYTabPagerBar alloc] init];
    _pagerBar = pagerBar;
    _pagerBar.dataSource = self;
    _pagerBar.delegate = self;
    _pagerBar.layout.barStyle = TYPagerBarStyleProgressView;
    _pagerBar.layout.cellSpacing = 0;
    _pagerBar.layout.cellEdging = 0;
    [_pagerBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:_pagerBar];
    [_pagerBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    
    TYPagerView *pagerView = [[TYPagerView alloc] init];
    _pagerView = pagerView;
    _pagerView.dataSource = self;
    _pagerView.delegate = self;
    [self.view addSubview:_pagerView];
    [_pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pagerBar);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (NSArray *)titleAry {
    if (_titleAry == nil) {
        _titleAry = [NSArray arrayWithObjects:@"经典", @"开车", nil];
    }
    return  _titleAry;
}

- (NSArray *)childViewAry {
    if (_childViewAry == nil) {
        ZMMAudioContentVC *classicVC = [[ZMMAudioContentVC alloc] initWithNibName:@"ZMMAudioContentVC" bundle:[NSBundle bundleForClass:[ZMMAudioContentVC class]]];
        classicVC.view.backgroundColor = [UIColor brownColor];
        classicVC.view.frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height - 45);
        ZMMAudioContentVC *carVC = [[ZMMAudioContentVC alloc] initWithNibName:@"ZMMAudioContentVC" bundle:[NSBundle bundleForClass:[ZMMAudioContentVC class]]];
        carVC.view.backgroundColor = [UIColor grayColor];
        carVC.view.frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height - 45);
        _childViewAry = [NSArray arrayWithObjects:classicVC.view, carVC.view, nil];
    }
    return  _childViewAry;
}

#pragma mark - TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar {
    return self.titleAry.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.titleAry[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSLog(@"%f", self.view.frame.size.width/self.titleAry.count);
    return self.view.frame.size.width/self.titleAry.count;
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerView scrollToViewAtIndex:index animate:YES];
}

#pragma mark - TYPagerViewDataSource
- (NSInteger)numberOfViewsInPagerView {
    return self.childViewAry.count;
}

- (UIView *)pagerView:(TYPagerView *)pagerView viewForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    return self.childViewAry[index];
}

#pragma mark - TYPagerViewDelegate

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    NSLog(@"fromIndex:%ld, toIndex:%ld",fromIndex,toIndex);
    [_pagerBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_pagerBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

@end
