//
//  ViewController.m
//  LXTabControlDemo
//
//  Created by lx on 2017/11/6.
//  Copyright © 2017年 lx. All rights reserved.
//


#import "ViewController.h"
#import "LXTabControl.h"
#import "RRTodosTabItemView.h"
#import "RREngagementTabItemView.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) LXTabControl *tabControl1;
@property (nonatomic, strong) LXTabControl *tabControl2;
@property (nonatomic, strong) LXTabControl *tabControl3;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RRTodosTabItemView *todosItemView; //顶部TabControl内todosItemView
@property (nonatomic, strong) RREngagementTabItemView *engagementItemView; //顶部TabControl内engagementItemView
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat horizonScrollViewHeight = SCREEN_HEIGHT - 64 - 120;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 120, SCREEN_WIDTH, horizonScrollViewHeight)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, horizonScrollViewHeight);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < 5; i++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, horizonScrollViewHeight)];
        if (i == 0) {
            bgView.backgroundColor = [UIColor redColor];
        }
        else if (i == 1) {
            bgView.backgroundColor = [UIColor yellowColor];
        }
        else if (i == 2) {
            bgView.backgroundColor = [UIColor blueColor];
        }
        else if (i == 3) {
            bgView.backgroundColor = [UIColor greenColor];
        }
        else {
            bgView.backgroundColor = [UIColor purpleColor];
        }
        [self.scrollView addSubview:bgView];
    }

    [self setupTabControl1];
    [self setupTabControl2];
    [self setupTabControl3];

}

- (void)setupTabControl1 {
    __weak typeof(self) weakSelf = self;
    self.tabControl1 = [LXTabControl NormalTabControlWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)
                                                        titles:@[@"one", @"two", @"three", @"four", @"five"]
                                                     itemWidth:SCREEN_WIDTH / 5.f
                                                 selectedBlock:^(LXTabControl *tabControl, NSInteger index) {
                                                     [weakSelf.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
                                                     
                                                 }];
    self.tabControl1.indicatorType = IndicatorWidthIsEqualTitle;
    self.tabControl1.normalFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl1.selectedFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl1.textColor = UIColorFromRGB(0x515666);
    self.tabControl1.selectedTextColor = UIColorFromRGB(0x2492Fc);
    [self.view addSubview:self.tabControl1];
}


- (void)setupTabControl2 {
    __weak typeof(self) weakSelf = self;
    self.tabControl2 = [LXTabControl NormalTabControlWithFrame:CGRectMake(0, 64 + 40, SCREEN_WIDTH, 40)
                                                        titles:@[@"one", @"twwwo", @"threeeee", @"fooooooour", @"fivvvvvvvvvvve"]
                                               itemWidthsArray:@[@(80.f),@(100.f),@(120.f),@(140.f),@(160.f)]
                                                 selectedBlock:^(LXTabControl *tabControl, NSInteger index) {
                                                     [weakSelf.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
                                                 }];
    
    self.tabControl2.indicatorType = IndicatorWidthIsEqualTitle;
    self.tabControl2.normalFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl2.selectedFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl2.textColor = UIColorFromRGB(0x515666);
    self.tabControl2.selectedTextColor = UIColorFromRGB(0x2492Fc);
    [self.view addSubview:self.tabControl2];
}

- (void)setupTabControl3 {
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *titleArray = @[@"Profile", @"Timeline", @"To-dos", @"Engagement", @"Documents"].mutableCopy;
    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count; i++) {
        if (i == 2) {
            self.todosItemView = [RRTodosTabItemView itemViewWithFrame:CGRectZero title:titleArray[i]];
            self.todosItemView.index = i;
            self.todosItemView.todosNum = 25;
            [itemsArray addObject:self.todosItemView];
        }
        else if (i == 3) {
            self.engagementItemView = [RREngagementTabItemView itemViewWithFrame:CGRectZero title:titleArray[i]];
            self.engagementItemView.index = i;
            self.engagementItemView.displayRedPoint = YES;
            [itemsArray addObject:self.engagementItemView];
        }
        else {
            LXTabItemView *itemView = [LXTabItemView itemViewWithFrame:CGRectZero title:titleArray[i]];
            itemView.index = i;
            [itemsArray addObject:itemView];
        }
    }
    NSMutableArray *widthArray = @[@(71.f),@(84.f),@(89.f),@(109.f),@(102.f)].mutableCopy;
    self.tabControl3 = [LXTabControl CustomTabControlWithFrame:CGRectMake(0, 64 + 80, SCREEN_WIDTH, 40)
                                                      itemViews:itemsArray
                                                itemWidthsArray:widthArray
                                                  selectedBlock:^(LXTabControl *tabControl, NSInteger index) {
                                                      [weakSelf.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];

                                                  }];
    
    self.tabControl3.backgroundColor = [UIColor whiteColor];
    self.tabControl3.indicatorType = IndicatorWidthCustom;
    NSMutableArray *indicatorWidthsArray = [NSMutableArray arrayWithArray:@[@(61.f),@(74.f),@(79.f),@(99.f),@(92.f)]];
    self.tabControl3.indicatorWidthsArray = indicatorWidthsArray;
    self.tabControl3.normalFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl3.selectedFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.tabControl3.textColor = UIColorFromRGB(0x515666);
    self.tabControl3.selectedTextColor = UIColorFromRGB(0x2492Fc);

    [self.view addSubview:self.tabControl3];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.tabControl1 setSelectedIndex:index animated:YES];
    [self.tabControl2 setSelectedIndex:index animated:YES];
    [self.tabControl3 setSelectedIndex:index animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
