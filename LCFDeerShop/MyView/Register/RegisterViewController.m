//
//  RegisterViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/13.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "RegisterViewController.h"
#import "LCFMyViewController.h"
#import "OLImage.h"
#import "OLImageView.h"
@interface RegisterViewController ()
@property (nonatomic,retain)    UIImageView * backgroundImage; //背景图片
@property (nonatomic,retain)    UIView      * BG_view;  //背景view
@property (nonatomic,retain)    UIButton    * leftnaviga; //返回按钮
@property (nonatomic,retain)    UITextField * AccountTextield;//账号
@property (nonatomic,retain)    UITextField * PasswordTextield;//密码

@end

@implementation RegisterViewController

-(UIImageView *)backgroundImage{
    
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        [_backgroundImage setImage:[UIImage imageNamed:@"011e07585a579ea801219c77d12349.jpg@900w_1l_2o_100sh"]];
    }
    _backgroundImage.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT);
    return _backgroundImage;
}
//-(UIView *)BG_view{
//    
//    if (!_BG_view) {
//        _BG_view = [[UIView alloc] init];
//        _BG_view.alpha = .35;
//        _BG_view.backgroundColor = [UIColor blackColor];
//    }
//    _BG_view.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT);
//    return  _BG_view;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"注册";
//    [self.view addSubview:self.backgroundImage];
    /*创建GIF动画背景图片*/
    OLImageView * animationImage = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"kick_push_dribbble.gif"]];
    [animationImage setFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
    [self.view addSubview:animationImage];
    [animationImage addSubview:self.BG_view];
    
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(ClickPop:) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    
    UILabel * accountTextield = [[UILabel alloc] init];
    accountTextield.text = @"账号:";
    accountTextield.frame = CGRectMake(accountTextield.left+ 50, accountTextield.top + 100, 40, 20);
    accountTextield.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:accountTextield];
    
    UITextField * AccountTextield = [[UITextField alloc]init];
    
    AccountTextield.frame = CGRectMake(accountTextield.right+ 20, AccountTextield.top + 100, 200, 30);
    [self.view addSubview:AccountTextield];
   
    self.AccountTextield = AccountTextield;

}



//pop

-(void)ClickPop:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//返回我的账号主页
-(void)ClickPopRight:(UIButton *)sender {
   
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
