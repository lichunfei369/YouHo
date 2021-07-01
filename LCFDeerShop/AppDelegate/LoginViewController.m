//
//  LoginViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LoginViewController.h"
#import "LCFMyViewController.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "YYDeerShopRequest.h"
#import "RequestLoginParam.h"
#import "RegisterViewController.h"
#import "QuickViewController.h"
#import "OLImage.h"
#import "OLImageView.h"

/*
 UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
 
 //  毛玻璃view 视图
 
 UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
 
 //添加到要有毛玻璃特效的控件中
 
 effectView.frame = self.backgroundImage.bounds;
 
 [self.backgroundImage addSubview:effectView];
 
 //设置模糊透明度
 
 effectView.alpha = .8f;
 */


@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,retain)    UIImageView * backgroundImage; //背景图片
@property (nonatomic,retain)    UIView      * BG_view;
@property (nonatomic,retain)    UILabel     * title_label;
@property (nonatomic,retain)    UIButton    * login_bt;
@property (nonatomic,retain)   UITextField  * Account;
@property (nonatomic,retain)    UITextField * password;


@end

@implementation LoginViewController


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(UIImageView *)backgroundImage{
    
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        [_backgroundImage setImage:[UIImage imageNamed:@"01d70c585a579ca801219c775de526.jpg@900w_1l_2o_100sh"]];
    }
    _backgroundImage.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT);
    return _backgroundImage;
}

-(UIView *)BG_view{
    
    if (!_BG_view) {
        _BG_view = [[UIView alloc] init];
        _BG_view.alpha = .35;
        _BG_view.backgroundColor = [UIColor blackColor];
    }
    _BG_view.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT);
    return  _BG_view;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.backgroundImage];
    /*GIF背景动画设置*/
    OLImageView * animationImage = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"chalet_d.gif"]];
    [animationImage setFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
    
    [self.view addSubview:animationImage];
    
    [animationImage addSubview:self.BG_view];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    [self setUpDataLayoutSubView];

    
    RequestLoginParam * param = [RequestLoginParam param];
//    param.username = _accountLoginTextField.text;
//    param.password = [ZZAESUtil encryptAESData:_passwordLoginTextField.text app_key:kAESKey];
    param.method = @"chenggou.user.login";
    param.ip = [ZZGetIP getCurrentIP];
    param.sign = [ZZBaseParam encryptionSignWithParam:param secret:kSecret];
 
    [self setupLoginParseWithParam:param];
    
  
    
}


-(void)setupLoginParseWithParam:(ZZBaseParam *)param{
    
//    [YYDeerShopRequest registerWithDic:<#(NSDictionary *)#>]
    
}

-(void)setUpDataLayoutSubView{
    //欢迎 title
//    UILabel * title = [[UILabel alloc] init];
//    title.frame = CGRectMake(LCF_SCREEN_WIDTH / 2.5 , 150, 100, 25);
//    title.text = @"登陆";
//    title.textAlignment = NSTextAlignmentCenter;
//    title.textColor = [UIColor whiteColor];
//     title.font = [UIFont AmericanTypewriterBoldFontSize:15.];
//    title.font = XNFont(24);
//    [self.BG_view addSubview:title];
//    self.title_label = title;
    
    OLImageView * title = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"type-warp-animation.gif"]];
    [title setFrame:CGRectMake(LCF_SCREEN_WIDTH / 2.5 , 150, LCF_SCREEN_WIDTH / 3.75, 80)];
    
    [self.BG_view addSubview:title];
    
    
    UITextField * Account = [[UITextField alloc]init];
    Account.placeholder = @" 手机号/邮箱";
    
    Account.font = XNFont(12);
    Account.backgroundColor = [UIColor whiteColor];
    Account.borderStyle = UITextBorderStyleRoundedRect;
    Account.layer.cornerRadius = 15;
    [self.view addSubview:Account];
    [Account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(40);
        make.centerX.equalTo(title);
        make.width.equalTo(@(LCF_SCREEN_WIDTH / 1.5));
        make.height.equalTo(@(35));
    }];
    self.Account = Account;
    
    UITextField * password = [[UITextField alloc]init];
    password.placeholder = @" 密码";
    password.font = XNFont(12);
    password.backgroundColor = [UIColor whiteColor];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.layer.cornerRadius = 15;
    password.secureTextEntry = YES;
    
    [self.view addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Account.mas_bottom).offset(15);
        make.centerX.equalTo(title);
        make.width.equalTo(@(LCF_SCREEN_WIDTH / 1.5));
        make.height.equalTo(@(35));
    }];
    
    UIImageView * image_eyes = [[UIImageView alloc] init];
    [image_eyes setImage:[UIImage imageNamed:@"password_eyes01"]];
    [password addSubview:image_eyes];
    [image_eyes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(password).offset(-5);
        make.centerY.equalTo(password);
        make.width.height.mas_equalTo(@20);
        
    }];
    NSArray * image_icon = @[@"login_0",@"login_1",@"login_2",@"login_3"];

    for (int i = 0; i < 4; i++) {
       UIButton * login_bt = [UIButton buttonWithType:UIButtonTypeCustom];
//        login_bt.backgroundColor = [UIColor whiteColor];
        [login_bt setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", image_icon[i]]] forState:UIControlStateNormal];
        login_bt.tag = 100 +i;
        [login_bt addTarget:self action:@selector(actionClicedLogin:) forControlEvents:UIControlEventTouchUpInside];
        login_bt.frame = CGRectMake( LCF_SCREEN_WIDTH / 4.5 +  i * 60 ,LCF_SCREEN_HEIGHT - 315, 40,40 );


//    NSArray * image_icon = @[@"login_0",@"login_1",@"login_2",@"login_3"];
//
//    for (int i = 0; i < 4; i++) {
//       UIButton * login_bt = [UIButton buttonWithType:UIButtonTypeCustom];
////        login_bt.backgroundColor = [UIColor whiteColor];
//        [login_bt setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", image_icon[i]]] forState:UIControlStateNormal];
//        login_bt.tag = 100 +i;
//        [login_bt addTarget:self action:@selector(actionClicedLogin:) forControlEvents:UIControlEventTouchUpInside];
//        login_bt.frame = CGRectMake( LCF_SCREEN_WIDTH / 4.5 +  i * 60 ,LCF_SCREEN_HEIGHT - 315, 40,40 );

//     NSArray * image_icon = @[@"login_0",@"login_1",@"login_2",@"login_3"];
//    
//    for (int i = 0; i < 4; i++) {
//       UIButton * login_bt = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [login_bt setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", image_icon[i]]] forState:UIControlStateNormal];
//        login_bt.tag = 100 +i;
//        [login_bt addTarget:self action:@selector(actionClicedLogin:) forControlEvents:UIControlEventTouchUpInside];
//        login_bt.frame = CGRectMake( LCF_SCREEN_WIDTH / 4.5 +  i * 60 ,LCF_SCREEN_WIDTH - 15, 40,40 );
//
//>>>>>>> 278e528c380113738cebbcbb081410c27308d986
        [self.view addSubview:login_bt];
        self.login_bt = login_bt;
    }
    
    UIButton * loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBt.alpha = .85;
    loginBt.layer.cornerRadius = 30;
    loginBt.backgroundColor = [UIColor blackColor];
    [loginBt addTarget:self action:@selector(actionClicedLoginBt:) forControlEvents:UIControlEventTouchUpInside];
    loginBt.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:loginBt];
    
    [loginBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.login_bt.mas_bottom).offset(30);
        make.centerX.equalTo(Account);
        make.width.equalTo(@(LCF_SCREEN_WIDTH / 1.5));
        make.height.equalTo(@(60));
        
    }];
    
    
    
    UILabel * label_Bt = [[UILabel alloc]init];
    label_Bt.text = @"登  陆";
    label_Bt.textAlignment = NSTextAlignmentCenter;
    label_Bt.textColor = [UIColor whiteColor];
    [loginBt addSubview:label_Bt];
    [label_Bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loginBt);
        make.centerY.equalTo(loginBt);

    }];
    
    UIButton * Register = [UIButton buttonWithType:UIButtonTypeCustom];
    [Register setTitle:@"手机快速注册" forState:UIControlStateNormal];
    [Register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Register.titleLabel.font = XNFont(12);
    [Register addTarget:self action:@selector(ClickRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Register];
    [Register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(loginBt).offset(0);
        make.top.equalTo(loginBt.mas_bottom).offset(10);
    }];
    
    UIButton * WPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [WPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [WPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    WPassword.titleLabel.font = XNFont(12);
    [WPassword addTarget:self action:@selector(ClickWPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WPassword];
    [WPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Register);
        make.trailing.equalTo(loginBt).offset(-20);
    }];
    
    
    UIImageView * Register_left_icon = [[UIImageView  alloc] init];
    [Register_left_icon setImage:[UIImage imageNamed:@"register_left_icon_01"]];
    [self.view addSubview:Register_left_icon];
    [Register_left_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.leading.equalTo(self.view).offset(LCF_SCREEN_WIDTH - 250);
        make.width.height.equalTo(@(16));
    }];
    
    UIButton * Registerbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [Registerbt setTitle:@"注册DeerShop" forState:UIControlStateNormal];
    Registerbt.titleLabel.font = XNFont(12);
    Registerbt.titleLabel.textAlignment = NSTextAlignmentLeft;
    [Registerbt addTarget:self action:@selector(ClickRegisterbt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Registerbt];
    [Registerbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.leading.equalTo(self.view).offset(LCF_SCREEN_WIDTH - 200);
        make.width.equalTo(@100);
        make.height.equalTo(@16);
    }];
    
   
}
//登陆按钮
-(void)actionClicedLoginBt:(UIButton *)sender{
    
    
    /* 判断如果电话号码不正确提示一下错误不让跳转界面 否则是对的就直接跳转下一个界面*/
    
    if (![self.Account.text  isValidPhoneNum]) {
        [MBManager showBriefAlert:@"请输入正确电话号码"];
        return;
    }else if (! [self.password.text  isEqualToString:@""]  && !(self.password.text.length < 6)){
        
        [MBManager showBriefAlert:@"请输入密码"];
        
    }else{
        WEAKSELF(weakSelf)
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //显示导航栏状态
            weakSelf.navigationController.navigationBar.hidden = NO;
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    }
}

//第三方登陆
-(void)actionClicedLogin:(UIButton *)sender{
    
   
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
       [self.view endEditing:YES];
    }
    return YES;
}

/* 点击收回键盘 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

/* 快速注册 */
- (void)ClickRegister:(UIButton *)sender {
 
    QuickViewController  * quick = [QuickViewController new];
    [self.navigationController pushViewController:quick animated:YES];
   
}

/* 忘记密码 */
- (void)ClickWPassword:(UIButton *)sender {
    
    
}

/* 注册 */
- (void)ClickRegisterbt:(UIButton *)sender {
    
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
