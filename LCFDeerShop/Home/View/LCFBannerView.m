//
//  LCFBannerView.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFBannerView.h"

@interface LCFBannerView()<UIScrollViewDelegate>
@property   (nonatomic,strong)  NSMutableArray  *   arraySource;//banner数据源
@property   (nonatomic,strong)  UIScrollView    *   bannerScorllView;
@property   (nonatomic,strong)  UIImageView     *   bannerImageView;
@property   (nonatomic,strong)  UIPageControl   *   pageControll;
@property   (nonatomic,strong)  NSTimer         *   timer;

@end

@implementation LCFBannerView

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSMutableArray *)arraySource{
    
    if (self = [super initWithFrame:frame]) {
        _arraySource = arraySource;
        dispatch_async(dispatch_get_main_queue(),^{
             [self scrollBannerView:frame];
        
        });
        
    }
    return  self;
}
-(void)scrollBannerView:(CGRect)frame{
    //初始化滚动试图
    _bannerScorllView=[[UIScrollView alloc]initWithFrame:frame];
    //设置滚动区域
    _bannerScorllView.contentSize=CGSizeMake(LCF_SCREEN_WIDTH * ([self.arraySource count] + 2), 0);
    _bannerScorllView.delegate = self;
    _bannerScorllView.pagingEnabled = YES;//分页效果
    _bannerScorllView.showsVerticalScrollIndicator = NO;
    _bannerScorllView.showsHorizontalScrollIndicator = NO;
    _bannerScorllView.bounces = NO;
    
    
    for (int i = 0; i < ([self.arraySource count] + 2); i ++) {//前后各增加一张图 所以加二
        _bannerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(LCF_SCREEN_WIDTH * i, 0, _bannerScorllView.frame.size.width, _bannerScorllView.frame.size.height)];
        _bannerImageView.userInteractionEnabled = YES;
        //添加点击手势
        UITapGestureRecognizer *top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureAction:)];
        _bannerImageView.tag = i + 1;
        [_bannerImageView addGestureRecognizer:top];
        //取出数组最后一张图片
        if (i == 0) {
            
            [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:[self.arraySource lastObject]] placeholderImage:[UIImage imageNamed:@"banner_default"]];
        }
        //取出数组第一张图
        else if (i == ([self.arraySource count] + 1)){
            [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:[self.arraySource firstObject]] placeholderImage:[UIImage imageNamed:@"banner_default"]];
        }
        else{
            //            [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://gdp.alicdn.com/imgextra/i4/56254268/TB260dkXV95V1Bjy0FhXXb5wXXa_!!56254268.jpg"] placeholderImage:nil];
            [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:self.arraySource[i - 1]] placeholderImage:[UIImage imageNamed:@"banner_default"]];
        }
        
        [_bannerScorllView addSubview:_bannerImageView];
    }
    
    //设置偏移量
    [_bannerScorllView setContentOffset:CGPointMake(LCF_SCREEN_WIDTH, 0)];
    //默认开启滚动和设置时间
    _isAutoBanner = YES;
    _autoScrollTime = /* DISABLES CODE */ (0)?0:3.0f;
    
    
    
    //开启定时器
    [self timerOn];
    
    
    _pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _bannerScorllView.frame.size.height - 30, _bannerScorllView.frame.size.width, 30)];
    //设置总页数
    //    [_pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventValueChanged];
    _pageControll.userInteractionEnabled = NO;
    _pageControll.numberOfPages = [self.arraySource count];
    _pageControll.pageIndicatorTintColor = [UIColor whiteColor];
    //设置显示某页面
    _pageControll.currentPage = 0;
    _pageControll.currentPageIndicatorTintColor=[UIColor blackColor];
    
    
    [self addSubview:_bannerScorllView];
    [self addSubview:_pageControll];
}
#pragma mark-UIScrollView的代理方法
//用户准备拖拽的时候关闭,定时器
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self timerOff];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取当前的偏移量
    CGPoint current = _bannerScorllView.contentOffset;
    CGPoint offset = CGPointMake(current.x + LCF_SCREEN_WIDTH, 0);
    
    //判断是否已经翻到最后
    if (offset.x == ([self.arraySource count] + 2) * LCF_SCREEN_WIDTH)
    {
        //将当前位置设置为原来的第一张图片
        [_bannerScorllView setContentOffset:CGPointMake(LCF_SCREEN_WIDTH, 0)];
        
    }
    //判断是否已经翻到最前
    if (current.x == 0)
    {
        //将当前位置设置为原来的最后一张图片
        [_bannerScorllView setContentOffset:CGPointMake([self.arraySource count] * LCF_SCREEN_WIDTH, 0)];
    }
    
    [self timerOn];
}

- (void)clickPageControl{
    
    //    [self timerOff];
    //令UIScrollView做出相应的滑动显示
    //    CGSize viewSize = _bannerScrollView.frame.size;
    ////    CGRect rect = CGRectMake(_pageControl.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    //    CGPoint offset = CGPointMake((_pageControl.currentPage + 1) * viewSize.width, 0);
    //    [_bannerScrollView setContentOffset:offset animated:YES];
    //    NSLog(@"%ld",(long)_pageControl.currentPage);
    //    [self timerOn];
}


//滑动任何偏移的改变都会触发该方法
//解决最后一张有延时的问题
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint current = _bannerScorllView.contentOffset;
    
    if (current.x == ([self.arraySource count] + 1) * LCF_SCREEN_WIDTH)
    {
        
        [_bannerScorllView setContentOffset:CGPointMake(LCF_SCREEN_WIDTH, 0)];
    }
    
    //显示滑动点的位置
    _pageControll.currentPage = _bannerScorllView.contentOffset.x / LCF_SCREEN_WIDTH - 1;
}

//开启定时器
-(void)timerOn{
    
    if (_autoScrollTime < 0.5 || !_isAutoBanner){
        
        return  ;
    }
    //通过定时器来实现定时滚动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTime target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}
//关闭定时器
-(void)timerOff{
    
    [self.timer invalidate];
    self.timer = nil;
    
}
#pragma mark-定时器实现的方法
- (void)changeOffset
{
    
    //设置滚动偏移
    CGPoint current = _bannerScorllView.contentOffset;
    CGPoint offset = CGPointMake(current.x + LCF_SCREEN_WIDTH, 0);
    [_bannerScorllView setContentOffset:offset animated:YES];
    
    
    //设置为0时,pageControl.currentPage不会加1;
    if ( _pageControll.currentPage == [self.arraySource count] - 1) {
        _pageControll.currentPage = 0;
        //改变内容显示的位置瞬间改变
    }
    else{
        _pageControll.currentPage ++;
        
    }
}

#pragma mark-手势
-(void)GestureAction:(UITapGestureRecognizer *)top{
    NSLog(@"tag:%ld",(long)top.view.tag);
    if ([self.delegate respondsToSelector:@selector(clickBannerView:)]) {
        [self.delegate performSelector:@selector(clickBannerView:) withObject:@(top.view.tag)];
    }
    
}
-(void)removeTimer{
    if (!_timer)return;
    [_timer invalidate];
    _timer = nil;
}


@end
