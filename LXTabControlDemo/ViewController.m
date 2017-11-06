//
//  ViewController.m
//  LXTabControlDemo
//
//  Created by lx on 2017/11/6.
//  Copyright © 2017年 lx. All rights reserved.
//


#import "ViewController.h"
#import "LXTabControl.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) LXTabControl *tabControl;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat horizonScrollViewHeight = SCREEN_HEIGHT - 64 - 40;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, horizonScrollViewHeight)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, horizonScrollViewHeight);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100 + i*SCREEN_WIDTH, 200, 100, 30)];
        label.text = @"test";
        [self.scrollView addSubview:label];
    }

    __weak typeof(self) weakSelf = self;
    self.tabControl = [LXTabControl NormalTabControlWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)
                                                      titles:@[@"test one", @"test twwwwwwo", @"test three"]
                                                   itemWidth:375 / 3.f
                                               selectedBlock:^(LXTabControl *tabControl, NSInteger index) {
                                                   [weakSelf.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
                                               }];
    self.tabControl.indicatorType = IndicatorWidthCustom;
    self.tabControl.indicatorWidthsArray = [NSMutableArray arrayWithArray:@[@(70.f),@(110.f),@(77.f)]];
    self.tabControl.normalFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl.selectedFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl.textColor = UIColorFromRGB(0x515666);
    self.tabControl.selectedTextColor = UIColorFromRGB(0x2492Fc);
    [self.view addSubview:self.tabControl];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.tabControl setSelectedIndex:index animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
