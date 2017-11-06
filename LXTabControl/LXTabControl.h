//
//  LXTabControl.h
//  segmentTest
//
//  Created by 李肖 on 2017/8/10.
//  Copyright © 2017年 李肖. All rights reserved.
//

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#import <UIKit/UIKit.h>
@class LXTabControl,LXTabItemView;

typedef NS_ENUM(NSInteger, IndicatorWidthType){
    IndicatorWidthIsEqualItem = 0,  //下划线宽度跟随Item宽度(默认)
    IndicatorWidthIsEqualTitle = 1, //下划线宽度跟随Title宽度
    IndicatorWidthCustom = 2,       //下划线宽度自定义
};


typedef void(^SelectedTabBlock)(LXTabControl *tabControl, NSInteger index);

@interface LXTabControl : UIScrollView

// 点击选中状态的Item时 是否回调 默认为NO
@property (assign, nonatomic) BOOL shouldCallBackWhenClickedSelectedItem;

// 标题颜色
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *selectedTextColor;

// 字体
@property (strong, nonatomic) UIFont  *normalFont;
@property (strong, nonatomic) UIFont  *selectedFont;

// 动画时长
@property (assign, nonatomic) NSTimeInterval animationDuration;

// 下划线高度
@property (assign, nonatomic) CGFloat indicatorHeight;

// 下划线宽度数组
@property (strong, nonatomic) NSMutableArray <NSNumber *> *indicatorWidthsArray;

// 下划线类型
@property (assign, nonatomic) IndicatorWidthType indicatorType;

// 下划线颜色
@property (strong, nonatomic) UIColor *indicatorColor;

//下划线view
@property (strong, nonatomic) UIView *slideView;

// 选择某个按钮后的回调
@property (copy, nonatomic) SelectedTabBlock selectedBlock;


//*********************** Method ***********************//


/**
  创建一个CustomLXTabControl对象(itemView自定义)
 */
+ (instancetype)CustomTabControlWithFrame:(CGRect)frame
                                itemViews:(NSMutableArray *)itemsArray
                          itemWidthsArray:(NSArray <NSNumber *> *)itemWidthsArray
                            selectedBlock:(SelectedTabBlock)selectedBlock;

/**
  创建NormalLXTabControl对象(标准itemView统一宽度)
 */
+ (instancetype)NormalTabControlWithFrame:(CGRect)frame
                                   titles:(NSArray <NSString *> *)titles
                                itemWidth:(CGFloat)itemWidth
                            selectedBlock:(SelectedTabBlock)selectedBlock;

// 创建NormalLXTabControl对象(标准itemView宽度自定义)
+ (instancetype)NormalTabControlWithFrame:(CGRect)frame
                                   titles:(NSArray <NSString *> *)titles
                          itemWidthsArray:(NSArray <NSNumber *> *)itemWidthsArray
                            selectedBlock:(SelectedTabBlock)selectedBlock;

// 设置某个Item被选中
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;

// 更新某个Item的title
- (void)updateTitle:(NSString *)title index:(NSInteger)index;

// 更新所有Item的title
- (void)updateAllTitles:(NSArray <NSString *> *)titles;

// 更新某个ItemView
- (void)updateItem:(LXTabItemView *)itemView index:(NSInteger)index;

// 更新所有ItemView
- (void)updateAllItem:(NSMutableArray *)itemsArray;

@end

