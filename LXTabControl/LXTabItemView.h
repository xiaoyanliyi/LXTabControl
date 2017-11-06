//
//  LXTabItemView.h
//  segmentTest
//
//  Created by 李肖 on 2017/8/10.
//  Copyright © 2017年 李肖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXTabItemView : UIControl

@property (strong, nonatomic) UILabel *titleLabel;

@property (assign, nonatomic) CGSize titleTextSize;

// 角标
@property (assign, nonatomic) NSInteger index;

// title字体颜色
@property (strong, nonatomic) UIColor *normalItemTextColor;
@property (strong, nonatomic) UIColor *selectItemTextColor;

// title字体
@property (strong, nonatomic) UIFont  *normalItemFont;
@property (strong, nonatomic) UIFont  *selectItemFont;

// 标题
@property (copy, nonatomic) NSString *title;

// item内容宽度
@property (assign, nonatomic,readonly) CGFloat contentLength;

// 是否被选中
@property (assign, nonatomic) BOOL isSelect;

+ (instancetype)itemViewWithFrame:(CGRect)frame title:(NSString *)title;


@end
