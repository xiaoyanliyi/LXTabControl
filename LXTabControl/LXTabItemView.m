//
//  LXTabItemView.m
//  segmentTest
//
//  Created by 李肖 on 2017/8/10.
//  Copyright © 2017年 李肖. All rights reserved.
//

#import "LXTabItemView.h"


@interface LXTabItemView ()

@end

@implementation LXTabItemView 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commentInitilize];
    }
    return self;
}

- (void)commentInitilize {
    _isSelect = NO;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.frame = self.bounds;
}

+ (instancetype)itemViewWithFrame:(CGRect)frame title:(NSString *)title {
    LXTabItemView *item = [[LXTabItemView alloc]initWithFrame:frame];
    item.titleLabel.text = title;
    return item;
}

- (CGFloat)contentLength {
    return _titleTextSize.width;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

-(void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    
    if (isSelect) {
        self.titleLabel.font = self.selectItemFont;
        self.titleLabel.textColor = self.selectItemTextColor;
    }
    else {
        self.titleLabel.font = self.normalItemFont;
        self.titleLabel.textColor = self.normalItemTextColor;
    }
}

-(void)setNormalItemFont:(UIFont *)normalItemFont {
    _normalItemFont = normalItemFont;
    _titleTextSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: normalItemFont}];
}

@end
