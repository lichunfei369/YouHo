//
//  SettingViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/19.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingFooterView.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property   (nonatomic ,retain) UITableView     * tableview;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = YM_RGBA(240., 240., 240, 1.);
    self.navigationController.navigationBar.hidden = NO;

    [self.view addSubview:self.tableview];



    
    
}
-(void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableView *)tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 44;
    }
    
    return _tableview;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(section == 0)   return 3;
    if(section == 1)   return 4;
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
    }
    cell.textLabel.font = [UIFont AmericanTypewriterBoldFontSize:12.];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.selectionStyle = UITableviewCellSelectionStyleNoe
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"消息推送";
            
        }
        if (indexPath.row == 1){
            cell.textLabel.text = @"2G/3G网络显示原图";
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }if (indexPath.row == 2) {
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = @"0.40M";
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"给我们评论";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"关于我们";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"推荐好友";
        }if (indexPath.row == 3) {
            cell.textLabel.text = @"交易进度";
        }
        
    }else if (indexPath.section == 2){
        
        cell.textLabel.text = @"退出登陆";
    }
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
       
        }
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
   
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
