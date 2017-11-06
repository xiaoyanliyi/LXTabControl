//
//  LXTabControl.m
//  tabTest
//
//  Created by 李肖 on 2017/8/10.
//  Copyright © 2017年 李肖. All rights reserved.
//




#import "LXTabControl.h"
#import "LXTabItemView.h"

@interface LXTabControl ()

@property (strong, nonatomic) NSMutableArray *tabItems;
@property (strong, nonatomic) UIView         *indicatorView;
@property (assign, nonatomic) NSInteger      selectedIndex;
@property (strong, nonatomic) NSMutableArray <NSNumber *> *itemWidthsArray;

@end

@implementation LXTabControl

#pragma mark - initilize

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commentInitialize];
    }
    return self;
}

- (void)commentInitialize {
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    
    _textColor = [UIColor blackColor];
    _selectedTextColor = UIColorFromRGB(0x2492Fc);
    
    _normalFont      = [UIFont systemFontOfSize:14.0];
    _selectedFont    = [UIFont systemFontOfSize:14.0];
    
    _indicatorColor  = UIColorFromRGB(0x2492Fc);
    _indicatorHeight = 4;
    
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = _indicatorColor;
    _indicatorType = IndicatorWidthIsEqualItem;
    
    _animationDuration = 0.25;
    
    _itemWidthsArray = [[NSMutableArray alloc] init];
}

+ (instancetype)CustomTabControlWithFrame:(CGRect)frame
                                itemViews:(NSMutableArray *)itemsArray
                          itemWidthsArray:(NSArray <NSNumber *> *)itemWidthsArray
                            selectedBlock:(SelectedTabBlock)selectedBlock
{
    LXTabControl *tab = [[LXTabControl alloc] initWithFrame:frame];
    tab.itemWidthsArray = [itemWidthsArray mutableCopy];
    tab.selectedBlock = selectedBlock;
    tab.tabItems = itemsArray;
    [tab addButtonsWithTabItems];
    [tab redrawComponents];
    return tab;
}

+ (instancetype)NormalTabControlWithFrame:(CGRect)frame
                                   titles:(NSArray <NSString *> *)titles
                                itemWidth:(CGFloat)itemWidth
                            selectedBlock:(SelectedTabBlock)selectedBlock
{
    LXTabControl *tab = [[LXTabControl alloc] initWithFrame:frame];
    for (int idx = 0; idx < titles.count; idx++) {
        [tab.itemWidthsArray addObject:[NSNumber numberWithFloat:itemWidth]];
    }
    tab.selectedBlock = selectedBlock;
    [tab addButtonsWithTitles:titles];
    [tab redrawComponents];
    return tab;
}

+ (instancetype)NormalTabControlWithFrame:(CGRect)frame
                                   titles:(NSArray <NSString *> *)titles
                          itemWidthsArray:(NSArray <NSNumber *> *)itemWidthsArray
                            selectedBlock:(SelectedTabBlock)selectedBlock
{
    LXTabControl *tab = [[LXTabControl alloc] initWithFrame:frame];
    tab.itemWidthsArray = [itemWidthsArray mutableCopy];
    tab.selectedBlock = selectedBlock;
    [tab addButtonsWithTitles:titles];
    [tab redrawComponents];
    return tab;
}

#pragma mark - public method

- (void)updateTitle:(NSString *)title index:(NSInteger)index {
    if (index >= self.tabItems.count) {
        return;
    } else {
        LXTabItemView *item = [self.tabItems objectAtIndex:index];
        item.title = title;
    }
}

- (void)updateAllTitles:(NSArray <NSString *> *)titles {
    if (titles.count > self.tabItems.count) {
        return;
    }
    
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.tabItems.count) {
            LXTabItemView *item = [self.tabItems objectAtIndex:idx];
            item.title = title;
        }
    }];
}

- (void)updateItem:(LXTabItemView *)itemView index:(NSInteger)index {
    self.tabItems[index] = itemView;
}

- (void)updateAllItem:(NSMutableArray *)itemsArray {
    self.tabItems = itemsArray;
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    self.selectedIndex = index;
    if (self.selectedBlock) {
        self.selectedBlock(self, index);
    }
    [self moveToIndex:index animated:animated];
}

- (void)updateItemViewWithIndex:(NSInteger)index itemView:(LXTabItemView *)itemView {
    self.tabItems[index] = itemView;
}

#pragma mark - private

- (void)moveToIndex:(NSInteger)index animated:(BOOL)animated {
    
    [UIView animateWithDuration:animated ? (_animationDuration) : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (index < self.tabItems.count) {
            LXTabItemView *button = [self.tabItems objectAtIndex:index];
            
            if (self.contentSize.width > SCREEN_WIDTH) {
                CGFloat offsetX = CGRectGetMidX(button.frame) - SCREEN_WIDTH * 0.5;
                if (offsetX < 0) {
                    offsetX = 0;
                }
                CGFloat maxOffsetX = self.contentSize.width - SCREEN_WIDTH;
                if (maxOffsetX < 0) {
                    maxOffsetX = 0;
                }
                if (offsetX > maxOffsetX) {
                    offsetX = maxOffsetX;
                }
                [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            }
            
            [self redrawButtons];
            
            LXTabItemView *itemView = self.tabItems[index];
            CGFloat width = itemView.frame.size.width;
            if (self.indicatorType == IndicatorWidthIsEqualTitle) {
                
                CGFloat x = CGRectGetMinX(itemView.frame) + (width - button.contentLength) / 2;
                self.indicatorView.frame = CGRectMake(x, self.frame.size.height - self.indicatorHeight,button.contentLength, self.indicatorHeight);
            }
            else if (self.indicatorType == IndicatorWidthIsEqualItem) {
                self.indicatorView.frame = CGRectMake(CGRectGetMinX(itemView.frame), self.frame.size.height - self.indicatorHeight, button.frame.size.width, self.indicatorHeight);
            }
            else if (self.indicatorType == IndicatorWidthCustom && self.indicatorWidthsArray.count > 0) {
                CGFloat x = CGRectGetMinX(itemView.frame) + (width - [self.indicatorWidthsArray[index] floatValue]) / 2;
                self.indicatorView.frame = CGRectMake(x, self.frame.size.height - self.indicatorHeight, [self.indicatorWidthsArray[index] floatValue], self.indicatorHeight);
            }
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)redrawComponents {
    [self redrawButtons];
    
    if (self.tabItems.count > 0) {
        [self moveToIndex:_selectedIndex animated:false];
    }
}

- (void)redrawButtons {
    if (self.tabItems.count == 0) {
        return;
    }
    CGFloat Scrollwidth = 0;
    for (NSNumber *width in self.itemWidthsArray) {
        Scrollwidth += [width floatValue];
    }
    self.contentSize = CGSizeMake(Scrollwidth, CGRectGetHeight(self.frame));
    CGFloat itemWidth = 0;
    for (int idx = 0; idx < self.itemWidthsArray.count; idx++) {
        LXTabItemView *item = self.tabItems[idx];
        item.frame = CGRectMake(itemWidth, 0, [self.itemWidthsArray[idx] floatValue], CGRectGetHeight(self.frame) - self.indicatorHeight);
        item.isSelect = (idx == self.selectedIndex) ? YES : NO;
        itemWidth += [self.itemWidthsArray[idx] floatValue];
    }
}

- (void)addButtonsWithTitles:(NSArray <NSString *> *)titles {
    [self.tabItems makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tabItems removeAllObjects];
    
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        LXTabItemView *button = [LXTabItemView itemViewWithFrame:CGRectZero title:title];
        button.normalItemFont = self.normalFont;
        button.selectItemFont = self.selectedFont;
        button.normalItemTextColor = self.textColor;
        button.selectItemTextColor = self.selectedTextColor;
        button.index = idx;
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabItems addObject:button];
        [self addSubview:button];
        
    }];
    [self addSubview:self.indicatorView];
}

- (void)addButtonsWithTabItems {
    [self.tabItems enumerateObjectsUsingBlock:^(LXTabItemView *itemView, NSUInteger idx, BOOL * _Nonnull stop) {
        itemView.normalItemFont = self.normalFont;
        itemView.selectItemFont = self.selectedFont;
        itemView.normalItemTextColor = self.textColor;
        itemView.selectItemTextColor = self.selectedTextColor;
        [itemView addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemView];
    }];
    [self addSubview:self.indicatorView];
}

- (void)buttonSelected:(LXTabItemView *)btn {
    if (btn.index == self.selectedIndex) {
        if (_shouldCallBackWhenClickedSelectedItem) {
            if (self.selectedBlock) {
                self.selectedBlock(self, btn.index);
            }
        }
        return;
    }
    [self setSelectedIndex:btn.index animated:YES];
}

#pragma mark - setter && getter

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self redrawComponents];
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor {
    _selectedTextColor = selectedTextColor;
    [self redrawComponents];
}

- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    [self redrawComponents];
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    [self redrawComponents];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}

-(void)setIndicatorType:(IndicatorWidthType)indicatorType {
    _indicatorType = indicatorType;
    [self redrawComponents];
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight {
    _indicatorHeight = indicatorHeight;
    [self redrawComponents];
}

- (NSMutableArray *)tabItems{
    if (!_tabItems) {
        _tabItems = [[NSMutableArray alloc]init];
    }
    return _tabItems;
}

-(NSMutableArray<NSNumber *> *)itemWidthsArray {
    if (!_itemWidthsArray) {
        _itemWidthsArray = [[NSMutableArray alloc] init];
    }
    return _itemWidthsArray;
}

-(NSMutableArray<NSNumber *> *)indicatorWidthsArray {
    if (!_indicatorWidthsArray) {
        _indicatorWidthsArray = [[NSMutableArray alloc] init];
    }
    return _indicatorWidthsArray;
}

@end
