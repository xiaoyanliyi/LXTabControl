//
//  RRTodosTabItemView.m
//  RenrenEstate
//
//  Created by lx on 2017/9/8.
//  Copyright © 2017年 renren. All rights reserved.
//
#define RRTabItemDefaultFont [UIFont systemFontOfSize:13]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#import "RRTodosTabItemView.h"

@interface RRTodosTabItemView ()

@property (nonatomic, strong) UILabel *todosSumLabel;

@end

@implementation RRTodosTabItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commentInit];
        
    }
    return self;
}

- (void)commentInit {
    _todosNum = 0;
    
    _todosSumLabel = [[UILabel alloc] init];
    _todosSumLabel.textAlignment = NSTextAlignmentLeft;
    _todosSumLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
    _todosSumLabel.text = [NSString stringWithFormat:@"%d",(int)self.todosNum];
    _todosSumLabel.hidden = YES;
    [self addSubview:self.todosSumLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.todosNum > 0) {
        self.titleLabel.frame = CGRectMake(15, 0, 46, self.bounds.size.height);
        self.todosSumLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 5, 0, 16, self.bounds.size.height);
    }
    else {
        self.titleLabel.frame = self.bounds;
    }
}

+ (instancetype)itemViewWithFrame:(CGRect)frame title:(NSString *)title {
    RRTodosTabItemView *item = [[RRTodosTabItemView alloc] initWithFrame:frame];
    item.titleLabel.text = title;
    return item;
}

-(void)setTodosNum:(NSInteger)todosNum {
    _todosNum = todosNum;
    if (todosNum > 0) {
        self.todosSumLabel.text = [NSString stringWithFormat:@"%d",(int)todosNum];
        self.todosSumLabel.hidden = NO;
    }
    else {
        self.todosSumLabel.hidden = YES;
    }
    [self setNeedsLayout];
}

-(void)setIsSelect:(BOOL)isSelect {
    if (isSelect) {
        self.todosSumLabel.textColor = self.selectItemTextColor;
    }
    else {
        self.todosSumLabel.textColor = UIColorFromRGB(0xa0a3af);
    }
    [super setIsSelect:isSelect];
}

@end
