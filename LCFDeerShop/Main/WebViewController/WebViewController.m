//
//  WebViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import <WebKit/WebKit.h>
@interface WebViewController ()<UIScrollViewDelegate,UIWebViewDelegate,WKNavigationDelegate>{
    
    UIView * NavigationBar;
}
@property (nonatomic, strong) WKWebView * webView;
@property   (nonatomic ,strong)     JSContext   *   context;
@property (nonatomic, strong) UIProgressView *progressView; ///< 进度条

@end

@implementation WebViewController

- (void)dealloc
{
    self.webView.navigationDelegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
    self.webView.scrollView.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
// 释放scrollView 强引用！！
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.webView.scrollView.delegate = nil;
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        CGRect rect = CGRectZero;
        rect.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
        rect.size.width = LCF_SCREEN_WIDTH;
        rect.size.height = 2;
        _progressView = [[UIProgressView alloc] initWithFrame:rect];
        [_progressView setProgressViewStyle:UIProgressViewStyleBar]; //设置进度条类型
      
    }
    return _progressView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.webview];
//    [self NavigationLayout];
//    self.requestUrl = [NSURL URLWithString:WebURL];
//    [self.webview loadRequest:[NSURLRequest requestWithURL:self.requestUrl]];
  
        UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
        lefItemBt.frame = CGRectMake(0, 0, 20, 20);
        [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
        [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
        [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];

    // 进度条监视
//    NSLog(@"%f", self.webView.estimatedProgress); // 防止苹果改变属性名时，项目不报错。故这里先打印。
    [self.view addSubview:_progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    self.navigationItem.title = @"关于谨防诈骗";
//    WKWebView * webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
      WKWebView * webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
    webview.navigationDelegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestBody]]];
    self.webView = webview;

}
-(void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // 进度条
    if ([@"estimatedProgress" isEqualToString:keyPath]) {
        NSLog(@"%f", self.webView.estimatedProgress);
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        // 初始和终止状态
        if (self.progressView.progress == 0) {
            self.progressView.hidden = NO;
        } else if (self.progressView.progress == 1) {
            // 1秒后隐藏
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 再次判断，防止正在加载时隐藏
                if (self.progressView.progress == 1) {
                    self.progressView.progress = 0;
                    self.progressView.hidden = YES;
                }
            });
        }
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    //    document.documentElement.scrollHeight    获取高度
    //    document.documentElement.innerHTML       获取当前网页的html
    //    document.location.href                   当前URL
    //    document.documentElement.innerText       获取内容
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 100) {
        self.navigationItem.title = self.webView.title;
    }else{
        self.navigationItem.title = nil;
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
   
}

//-(void)NavigationLayout {
//    
//    NavigationBar = [[UIView alloc] init];
//    NavigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
//    NavigationBar.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:NavigationBar];
//}

//- (UIWebView *)webview {
//    if (_webview) {
//        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
//        _webview.delegate = self;
//        _webview.scrollView.delegate = self;
//    }
//    
//    return  _webview;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
