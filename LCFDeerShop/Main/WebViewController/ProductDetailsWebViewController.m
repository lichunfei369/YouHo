//
//  ProductDetailsWebViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/13.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ProductDetailsWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LCFShoppingViewController.h"
#import "LoginViewController.h"
#define htmlAPI @"http://139.224.194.109:8080/static/mobile/index.html"
@interface ProductDetailsWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>{
    UIView      *view_bar;
    UILabel     *title_label;
    UIButton    *me_Btn;
    UIButton    *readerBtn;
    UILabel     *counterLab;//右上角的红点
}
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;

@end

@implementation ProductDetailsWebViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    
//        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
//    
//        NSString *htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    
//        [self.webView loadHTMLString:htmlStr baseURL:url];
    
    
    [self.view addSubview:self.webView];
    
    [self NavigationBa];  /* 创建导航栏 */
     [self setup];
}



-(UIView*)NavigationBa
{
    view_bar =[[UIView alloc]init];
    view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
    
    view_bar.backgroundColor=[UIColor clearColor];
    
    
    
    [self.view addSubview: view_bar];
    title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"商品详情";
    title_label.font=[UIFont boldSystemFontOfSize:17];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor blackColor];
    title_label.textAlignment= NSTextAlignmentCenter;
    title_label.hidden = YES;
    [view_bar addSubview:title_label];
    
    
    
    
    me_Btn=[[UIButton alloc]initWithFrame:CGRectMake(view_bar.frame.size.width-44, view_bar.frame.size.height-34, 25, 25)];
    [me_Btn setImage:[UIImage imageNamed:@"nav_shoppingCart_white"] forState:UIControlStateNormal];
    [me_Btn addTarget:self action:@selector(gotoShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [me_Btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // [self.scanningBtn addTarget:self action:@selector(Scanning) forControlEvents:UIControlEventTouchDown];
    
    [view_bar addSubview:me_Btn];
    
    readerBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, view_bar.frame.size.height-34, 25, 25)];
    [readerBtn setImage:[UIImage imageNamed:@"nav_goBack_white"] forState:UIControlStateNormal];
    [readerBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:readerBtn];
    
    counterLab = [[UILabel alloc]init];
    counterLab.bounds = CGRectMake(0, 0, 14, 14);
    counterLab.center = CGPointMake( me_Btn.center.x + 12, me_Btn.center.y - 10);
    counterLab.backgroundColor = [UIColor redColor];
    counterLab.textColor = [UIColor whiteColor];
    counterLab.font = XNFont(9.);
    counterLab.textAlignment = NSTextAlignmentCenter;
    counterLab.layer.masksToBounds = YES;
    counterLab.layer.cornerRadius = 7.;
    counterLab.clipsToBounds = YES;
    counterLab.hidden = YES;//模拟刚进来的时候隐藏
    [view_bar addSubview:counterLab];
    
    return view_bar;
}


- (void)setup {
    
    self.requestUrl = self.requestUrl?self.requestUrl:[NSURL URLWithString:htmlAPI];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.requestUrl]];
}


/* 创建web界面 */
- (UIWebView *)webView{
    
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.delegate = self;
        
    }
    return _webView;
    
    
}

#pragma mark------------      WebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
   
    [MBManager showLoadingMessage:@"加载中..." InView:self.webView];
    
    // 这里的productID是购物车传进来的ID   判断点击那个cell传那个商品ID
    
    JSValue *funcValue = self.context[@"ajaxProduct"];
//        [funcValue callWithArguments:@[self.productId]];
    [funcValue callWithArguments:@[@"1"]];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBManager hideAlert];
   
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBManager hideAlert];
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [context setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
        NSLog(@"%@", expectValue);
    }];
    
    self.context = context;
    
    __block UILabel *label = counterLab;
    
    __weak typeof(self) weakSelf = self;
    self.context[@"addCar"] = ^(NSString *productId,NSString *sku){
        //加入购物车
        if ([YMUtils loginParam]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                [MBManager showBriefAlert:@"加入购物车成功"];
                
                UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav_shoppingCart"]];
                
                imageView.backgroundColor = [UIColor whiteColor];
                imageView.frame = CGRectMake(LCF_SCREEN_WIDTH/4.69, LCF_SCREEN_WIDTH - 80, 20, 20);
                //            imageView.center = CGPointma
                
                [strongSelf.view addSubview:imageView];
                [UIView animateWithDuration:1.5 animations:^{
                    
                    imageView.center = label.center;
                    imageView.bounds = CGRectMake(0, 0, 8, 8);
                    label.hidden = NO;
                    
                    
                    CABasicAnimation* rotationAnimation;
                    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
                    rotationAnimation.duration = .2;
                    rotationAnimation.cumulative = YES;
                    rotationAnimation.repeatCount = 20;
                    
                    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
                    
                    
                } completion:^(BOOL finished) {
                    
                    
                    imageView.hidden = YES;
                    static int a = 0;
                    ++a;
                    label.text = [NSString stringWithFormat:@"%zi",a];
                    
                }];
                
                
            });
        }else{
            
            LoginViewController *login = [[LoginViewController alloc]init];
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:login animated:YES];
            
        }
        
        
        
    };
    self.context[@"addBuy"] = ^(NSString *productId,NSString *sku){
        //        立即购买
        
        
        
        //这里要判断点击购物车立即购买的情况
        
//        
//        if ([YMUtils loginParam]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                __strong typeof(weakSelf) strongSelf = weakSelf;
//                
//                
//                OrderViewController *orderVC = [[OrderViewController alloc]init];
//                strongSelf.hidesBottomBarWhenPushed = YES;
//                [strongSelf.navigationController pushViewController:orderVC animated:YES];
//                
//                
//            });
//        }else{
//            
//            LoginViewController *login = [[LoginViewController alloc]init];
//            weakSelf.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:login animated:YES];
//            
//            
//        }
        
    };
    
    self.context[@"clickShare"] = ^(NSString *productId){
        dispatch_async(dispatch_get_main_queue(), ^{
            //            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [MBManager showBriefAlert:@"分享成功"];
            
            
            
            
        });
    };
    self.context[@"clickMore"] = ^(NSString *productId){
        dispatch_async(dispatch_get_main_queue(), ^{
            //            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [MBManager showBriefAlert:@"没有更多了"];
            
            
            
        });
    };
    
    __block UILabel     *titleLab = title_label;
    __block UIButton    *meBtn = me_Btn;
    __block UIView      *barView = view_bar;
    self.context[@"deliveryRange"] = ^(NSString *isShow){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if ([isShow boolValue]) {
                titleLab.hidden = YES;
                meBtn.hidden = YES;
                barView.backgroundColor = [UIColor clearColor];
                strongSelf.webView.scrollView.scrollEnabled = NO;
            }else{
                if (strongSelf.webView.scrollView.contentOffset.y > 50) {
                    titleLab.hidden = NO;
                    barView.backgroundColor = [UIColor whiteColor];
                    
                }
                strongSelf.webView.scrollView.scrollEnabled = YES;
                
                meBtn.hidden = NO;
                
            }
            
        });
        
        
        
    };
    
    self.context[@"goback"] = ^(void){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.navigationController popViewControllerAnimated:YES];
        
    };
    
    
    return YES;
}


#pragma mark------导航点击事件

/* 点击返回按钮 */

- (void)popBack{
    [MBManager hideAlert]; //隐藏提示框
    
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)gotoShoppingCart{
    //    UIViewController *vc = self.navigationController.viewControllers[0];
    //    [self.navigationController popToViewController:vc animated:YES];
    //    vc.tabBarController.selectedIndex = 2;
    
    
    if ([YMUtils loginParam]) {
        LCFShoppingViewController *cart = [[LCFShoppingViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cart animated:YES];
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
        
        
    }
    
    
    
    
    
}

#pragma mark--------------   ScrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.webView.scrollView.contentOffset.y < 50) {
        
        // [self.navigationController setNavigationBarHidden:YES animated:NO];
        view_bar.backgroundColor = [UIColor clearColor];
        view_bar.alpha = 1;
        
        //        [view_bar setHidden:YES];
        
    }else if(self.webView.scrollView.contentOffset.y < 301 && self.webView.scrollView.contentOffset.y > 50){
        //        [view_bar setHidden:NO];
        
        view_bar.backgroundColor = [UIColor whiteColor];
        view_bar.alpha = self.webView.scrollView.contentOffset.y / 300;
    }else
    {
        //        [view_bar setHidden:NO];
        
        //        view_bar.backgroundColor = [UIColor whiteColor];
    }
    if (self.webView.scrollView.contentOffset.y > 50) {
        title_label.hidden = NO;
        //        [readerBtn setImage:[UIImage imageNamed:@"nav_goBack_white"] forState:UIControlStateNormal];
        //        [meBtn setImage:[UIImage imageNamed:@"nav_shoppingCart_white"] forState:UIControlStateNormal];
        
    }else{
        title_label.hidden = YES;
        //        [readerBtn setImage:[UIImage imageNamed:@"nav_goBack_white"] forState:UIControlStateNormal];
        //        [meBtn setImage:[UIImage imageNamed:@"nav_shoppingCart_white"] forState:UIControlStateNormal];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
