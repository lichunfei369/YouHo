//
//  AddTableViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/5.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "AddTableViewController.h"
#import "AddTableViewCell.h"

@interface AddTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property   (nonatomic ,retain) UITableView * tableview;
@end

@implementation AddTableViewController
static NSString *const addressCellIdentifier = @"addressCellIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    /* 左边 */
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    
    self.navigationItem.title = @"地址编辑";
    [self.view addSubview:self.tableview];
    
}

- (void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:addressCellIdentifier];
    if (!cell) {
        cell = [[AddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressCellIdentifier];
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
