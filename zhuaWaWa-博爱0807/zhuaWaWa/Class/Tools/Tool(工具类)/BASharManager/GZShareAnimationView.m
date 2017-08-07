//
//  GZShareAnimationView.m
//  GZPayDemo
//
//  Created by xinshijie on 2017/4/6.
//  Copyright © 2017年 Mr.quan. All rights reserved.
//

#import "GZShareAnimationView.h"
#import "GZShareManageView.h"

#define HH  180

@interface GZShareAnimationView ()<UIScrollViewDelegate>
{
    UIPageControl *pageShow ;
}
@property (nonatomic,strong) UIView *largeView;
@property (nonatomic)        CGFloat count;
@property (nonatomic,strong) UIButton *chooseBtn;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation GZShareAnimationView


- (id)initWithTitleArray:(NSArray *)titlearray picarray:(NSArray *)picarray title:(NSString *)title
{
    BA_WEAKSELF;
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.largeView = [[UIView alloc]init];
        [_largeView  setFrame:CGRectMake(0, BA_SCREEN_WIDTH ,BA_SCREEN_WIDTH,HH)];
        [_largeView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        [self addSubview:_largeView];
        
        __weak typeof (self) selfBlock = self;
        
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(0, 10, BA_SCREEN_WIDTH, 20);
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [_largeView addSubview:_titleLabel];
        
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HH - 40, BA_SCREEN_WIDTH, 40)];
        [_chooseBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_chooseBtn setBackgroundColor:[UIColor whiteColor]];
        [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.largeView addSubview:_chooseBtn];
        
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, BA_SCREEN_WIDTH, 100)];
        scroll.contentSize = CGSizeMake((titlearray.count + 2) / 3 * BA_SCREEN_WIDTH, 0);
        scroll.bounces = NO;
        scroll.pagingEnabled = YES;
        scroll.delegate = self;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        [_largeView addSubview:scroll];
        
        
        pageShow = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 120, 60, 20)];
        pageShow.currentPageIndicatorTintColor = [UIColor redColor];
        pageShow.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageShow.numberOfPages = (titlearray.count +2)/3;
        pageShow.center = CGPointMake(BA_SCREEN_WIDTH/2, 130);
        [_largeView addSubview:pageShow];
        
        for (int i = 0; i < titlearray.count; i ++) {
            GZShareManageView *rr = [[GZShareManageView alloc]initWithFrame:CGRectMake(i *(BA_SCREEN_WIDTH / 3), 40, BA_SCREEN_WIDTH/3, 90)];
            rr.tag = 10 + i;
            rr.sheetBtn.tag = i + 1;
            [rr.sheetBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picarray[i]]] forState:UIControlStateNormal];
            [rr.sheetLab setText:[NSString stringWithFormat:@"%@",titlearray[i]]];
            
            [rr selectedIndex:^(NSInteger index, UILabel *sheetLab,id shareType) {
                [weakSelf dismiss];
                weakSelf.block(index,shareType);
                
            }];
            
            [scroll addSubview:rr];
        }
        
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:selfBlock action:@selector(dismiss)];
        [selfBlock addGestureRecognizer:dismissTap];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageShow.currentPage = scrollView.contentOffset.x /BA_SCREEN_WIDTH;
}

- (void)selectedWithIndex:(CLBlock)block
{
    self.block = block;
}

- (void)CLBtnBlock:(CLBtnBlock)block
{
    self.btnBlock = block;
}

- (void)chooseBtnClick:(UIButton *)sender
{
    self.btnBlock(sender);
    [self dismiss];
}

-(void)show  
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    BA_WEAKSELF ;
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        _largeView.transform = CGAffineTransformMakeTranslation(0,  - HH);
        for (int i = 0; i < 6; i ++) {
            
            CGPoint CLCenterPoint = CGPointMake(BA_SCREEN_WIDTH/3 * i  + (BA_SCREEN_WIDTH/6), 45);
            
            GZShareManageView *rr =  (GZShareManageView *)[weakSelf viewWithTag:10 + i];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                 NSLog(@"%@",self);
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    rr.center = CLCenterPoint;
                } completion:nil];
            });
        }
        
    } completion:^(BOOL finished) {
        
//        NSLog(@"所有动画之行完毕");
    }];
}

- (void)tap:(UITapGestureRecognizer *)tapG {
    [self dismiss];
}

- (void)dismiss {
       BA_WEAKSELF ;
    
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        _largeView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
@end
