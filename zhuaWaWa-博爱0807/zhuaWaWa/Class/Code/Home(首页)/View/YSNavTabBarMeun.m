//
//  YSNavTabBarMeun.m
//  丰食买家
//
//  Created by linda on 14-12-25.
//  Copyright (c) 2014年 yskj. All rights reserved.
//

#define YSCellPadding 10
#define DOT_COORDINATE   0.0f

#import "YSNavTabBarMeun.h"
@interface YSNavTabBarMeun ()<UIScrollViewDelegate>
{
    NSMutableArray  *_items;                // YSNavTabBarMeun pressed item
    NSArray         *_itemsWidth;           // an array of items' width
//    UIView          *_line;                 // underscore show which item selected
}
/**
 *  定义属性保存选中按钮
 */
@property (nonatomic, weak) UIButton  * selectedBtn;

@property (nonatomic, strong) UIScrollView *navgationTabBar;
@property (nonatomic, strong) UIView          *line;
@end
@implementation YSNavTabBarMeun
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 创建Nav
        [self createNav];
        
    }
    return self;
}
- (void)createNav
{
    _items = [@[] mutableCopy];
    self.navgationTabBar.showsHorizontalScrollIndicator = NO;
    self.navgationTabBar.showsVerticalScrollIndicator = NO;
    self.navgationTabBar.directionalLockEnabled = YES;
    self.navgationTabBar.delegate = self;
    self.navgationTabBar.scrollEnabled = YES;
    [self addSubview:_navgationTabBar];
    [self viewShowShadow:self shadowRadius:10 shadowOpacity:10];
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOpacity = shadowOpacity;
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    
    UIButton *button = _items[currentItemIndex];
    CGFloat flag =  BA_SCREEN_WIDTH;
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count] - 1){
            offsetX = offsetX + 40.0f;
        }
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        self.line.frame = CGRectMake(button.frame.origin.x + 2.0f, self.line.frame.origin.y, [_itemsWidth[currentItemIndex] floatValue] - 4.0f, 3.0f);
    }];
    
    
}
// set
-(void)setTypeIDArray:(NSArray *)typeIDArray
{
    _typeIDArray = typeIDArray;
}

// 重写set
-(void)setButtonArray:(NSArray *)buttonArray
{
    _buttonArray = buttonArray;
}
/**传递进来的数据的数组*/
- (void)setItemTitles:(NSArray *)itemTitles
{
    _itemTitles = itemTitles;
}
- (void)setDataModel:(YSDishesDetailTypeModel *)dataModel
{
    _dataModel = dataModel;
}
/**
 提供一个创建按钮的方法
 */
- (void)createNewButton
{
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count) {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth +YSCellPadding, 0.0f);
    }
}
// 计算宽度
- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = DOT_COORDINATE;
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.frame = CGRectMake(buttonX ,DOT_COORDINATE, [widths[index] floatValue], TOP_HEIGHT);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navgationTabBar addSubview:button];
        [_items addObject:button];
        
        // 5.设置默认选中第一个按钮
        if (button.tag == 0) {
            [self itemPressed:button];
        }
        UIView *separateLine = [[UIView alloc] init];
        separateLine.frame = CGRectMake(buttonX + button.frame.size.width, DOT_COORDINATE + 5.0, 1, TOP_HEIGHT -YSCellPadding);
        separateLine.backgroundColor = [UIColor lightGrayColor];
        [_navgationTabBar addSubview:separateLine];
        
        buttonX += [widths[index] floatValue] + YSCellPadding;
        
    }
    // 设置滚动线条
    [self showLineWithButtonWidth:[widths[0] floatValue]];
    return buttonX;
    
}
// 设置滚动线条
- (void)showLineWithButtonWidth:(CGFloat)width
{
    self.line.frame  = CGRectMake(2.0f, TOP_HEIGHT - 3.0f, 2.0f, width - 4.0f);
    self.line.backgroundColor = [UIColor greenColor];
    [_navgationTabBar addSubview:self.line];
}
- (void)itemPressClick:(NSInteger)btnTag
{
    UIButton *button = _items[btnTag];
    [self itemPressed:button];
}
// 按钮点击事件
// 点击之后,把dishesGroup传递出去,跟点击的按钮的index传递过去,让外界去请求数据
- (void)itemPressed:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    // 点击了之后,加载网络请求
    // 点击按钮发送网络请求
    NSInteger tag = btn.tag;
    NSString *tagStrs =  _typeIDArray[tag];
    if ([self.navTabBarDelegate respondsToSelector:@selector(navTabBar:withGoodsMoedl:withIndex:)]) {
        [self.navTabBarDelegate navTabBar:self withGoodsMoedl:tagStrs withIndex:btn.tag];
    }
    
}

// 获取按钮的size 返回数组
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = FONT_11;
        CGSize size = [title sizeWithAttributes:dict];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
        [widths addObject:width];
    }
    
    return widths;
}
#pragma mark UIScrollView的代理方法
-(UIScrollView *)navgationTabBar
{
    if (!_navgationTabBar) {
        
        _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BA_SCREEN_WIDTH, 40)];
        _navgationTabBar.backgroundColor = [UIColor clearColor];
    }
    return _navgationTabBar;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        
    }
    return _line;
}
@end
