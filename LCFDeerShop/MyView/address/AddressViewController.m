//
//  AddressViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/4.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "AddTableViewController.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property   (nonatomic ,retain) UITableView * tableview;


@end

@implementation AddressViewController

static NSString *const addressCellIdentifier = @"addressCellIdentifier";

- (void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemBt {
 
    AddTableViewController * addtableview = [[AddTableViewController alloc] init];
    [self.navigationController pushViewController:addtableview animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:addressCellIdentifier];
    if (!cell) {
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressCellIdentifier];
    }
    
    
    return cell;
}

- (UITableView * )tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableview.rowHeight = 100;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    
    return  _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    self.navigationItem.title = @"地址管理";
    [self setUpBarButtonItem];
    

}

- (void)setUpBarButtonItem {
    
    /* 左边 */
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    /* 右边 */
    UIButton * rightItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemBt.frame = CGRectMake(0, 0, 20, 20);
    [rightItemBt addTarget:self action:@selector(rightItemBt) forControlEvents:UIControlEventTouchUpInside];
    [rightItemBt setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [rightItemBt setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemBt];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
