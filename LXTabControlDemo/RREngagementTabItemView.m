//
//  RREngagementTabItemView.m
//  EstateEnterprise-Formal
//
//  Created by lx on 2017/9/18.
//  Copyright © 2017年 renren. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#import "RREngagementTabItemView.h"

@interface RREngagementTabItemView ()

@property (nonatomic, strong) UIView *redPointView;

@end

@implementation RREngagementTabItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commentInit];
        
    }
    return self;
}

- (void)commentInit {
    _displayRedPoint = NO;
    
    self.redPointView = [[UIView alloc] initWithFrame:CGRectMake(5, 14, 6, 6)];
    self.redPointView.backgroundColor = UIColorFromRGB(0xf0454c);
    self.redPointView.layer.cornerRadius = 6 / 2;
    [self addSubview:self.redPointView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.displayRedPoint) {
        self.redPointView.hidden = NO;
    }
    else {
        self.redPointView.hidden = YES;
    }
}

+ (instancetype)itemViewWithFrame:(CGRect)frame title:(NSString *)title {
    RREngagementTabItemView *item = [[RREngagementTabItemView alloc] initWithFrame:frame];
    item.titleLabel.text = title;
    return item;
}

-(void)setDisplayRedPoint:(BOOL)displayRedPoint {
    _displayRedPoint = displayRedPoint;
    [self setNeedsLayout];
}

@end
