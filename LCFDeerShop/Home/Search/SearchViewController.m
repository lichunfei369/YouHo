//
//  SearchViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "SearchViewController.h"
#import "UIImage+SearchHeight.h"

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDBMigrationManager.h"
//#import "Migration.h"
//#import "MBProgressHUD+HH.h"
#import "SearchHistoryCell.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,SearchHistoryCellDelegate>
@property (nonatomic,strong) UIBarButtonItem *rightBarItem;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *searchHistoryNameArr;
@property (nonatomic,strong) FMDatabase *db;//数据库
@property (nonatomic,strong) UITableView *searchTableView;
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) NSMutableArray *nameArr;
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) UIButton *historyBt;
@property (nonatomic,assign) BOOL isSearchView;//判断searchView是否存在
@property (nonatomic,strong) UIView *blackView;
@property (nonatomic,assign) BOOL isBlackView;//判断blackView是否存在
@property (nonatomic,assign) BOOL isSearchTableView;//判断SearchTableView是否存在
@property (nonatomic,assign) BOOL isFirstBlackView;//判断当前视图是否是blackView
@property (nonatomic,assign) BOOL isFirstSearchTableView;//判断当前视图是否是SearchTableView
@property (nonatomic,strong) NSIndexPath *lastIndexPath;
@property (nonatomic,strong) UITapGestureRecognizer *tap;



@end

@implementation SearchViewController
-(NSMutableArray *)nameArr{
    if (!_nameArr) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}
-(NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}
-(NSMutableArray *)searchHistoryNameArr{
    if (!_searchHistoryNameArr) {
        _searchHistoryNameArr = [NSMutableArray array];
    }
    return _searchHistoryNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    /* 隐藏Navvigation返回按钮*/
    self.navigationItem.hidesBackButton = YES;
//    [self addDidloadItem];
//    [self addSearch];
  
    self.isSearchView = NO;
    self.isBlackView = NO;
    self.isSearchTableView = NO;
    self.isFirstSearchTableView = NO;
    self.isFirstBlackView = NO;
    [self layoutSearchBar];
    if (!self.isSearchView) {
        
        self.nameArr  = [NSMutableArray arrayWithObjects:@"邮政存储1月数据",@"贵金属业务月报表-总",@"1-保险月报表",@"4-国债月报表",@"12-代理金月报表",@"信用卡业务报表",@"存款结算组报表",@"实物金月报表",nil];
        [self FMDB];
        [self layoySearchView];
        self.isSearchView = YES;
    }
    
    
   

    
}


-(void)addDidloadItem{
    UIButton * rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.titleLabel.font = XNFont(14.);
    [rightBt setTitle:@"取消" forState:UIControlStateNormal];
    [rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightBt.bounds = CGRectMake(0, 0, 40, 30);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    
}
-(void)addSearch{
    
    UISearchBar * searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"棉衣";
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH - 80, 30);
    
    UIImage * searchBarBackground = [UIImage GetImageWithColor:YM_RGBA(238, 238, 238, 1) addHeight:30.];
    //为搜索框设置灰色背景
    [searchBar setSearchFieldBackgroundImage:searchBarBackground forState:UIControlStateNormal];
    self.navigationItem.titleView = searchBar;
    
}

#pragma mark- Event

-(void)rightBarButtonItemClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)layoutSearchBar{
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH - 80, 30)];//allocate titleView
//    UIColor *color =  self.navigationController.navigationBar.barTintColor;
//    [titleView setBackgroundColor:color];
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH - 80, 30);
    _searchBar.placeholder = @"  搜索";
    _searchBar.delegate = self;
//    _searchBar.frame = titleView.frame;
//    _searchBar.backgroundColor = color;
//    _searchBar.layer.cornerRadius = 5;
//    _searchBar.layer.masksToBounds = YES;
//    [_searchBar.layer setBorderWidth:8];
//    
//    [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色

    _searchBar.tintColor = [UIColor whiteColor];
    [_searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView *searchBarSub = _searchBar.subviews[0];
    // 去除UISearchbar视图里的UISearchBarBackground之后，UISearchbar的背景也就透明了，同时也可以自定义颜色等 遍历所有searchbar中的view ios 7.1以上  和7.0一下是连个方法 需要判断一下版本方法
    
    for (UIView * subview in searchBarSub.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subview setBackgroundColor:YM_RGBA(247., 247., 270, 1.)];
            
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
//       [titleView addSubview:_searchBar];
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = _searchBar;
//    [_searchBar setImage:[UIImage imageNamed:@"searchBar"] forSearchBarIcon:(UISearchBarIconSearch) state:(UIControlStateNormal)];
    //    添加右按钮
    self.rightBarItem = [[UIBarButtonItem alloc]
                         initWithTitle:@"取消"
                         style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(searchBarCancelButtonClicked:)];
    //      RightButton.tintColor = [UIColor blackColor];
    //    RightButton.title= [UIFont fontWithName:@"Marion-Italic" size:12];
    
    [_rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName : @"Helvetica" size : 12.0], NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName , nil ] forState : UIControlStateNormal ];
    [self.navigationItem setRightBarButtonItem:_rightBarItem];
    //设置假的左item 别让搜索框太大
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                         initWithTitle:@""
                         style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(nothing)];
          leftItem.tintColor = [UIColor blackColor];
//     NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Marion-Italic" size:12],NSFontAttributeName,nil];
//    [leftItem.title drawAtPoint:CGPointMake(0, 0) withAttributes:dic1];
    
    [leftItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName : @"Helvetica" size : 12.0], NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName , nil ] forState : UIControlStateNormal ];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}
-(void)nothing{
   
}
#pragma mark - searchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
     if( self.isBlackView ){
        [self.view bringSubviewToFront:self.blackView];
        
    }else {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self.view addSubview:_blackView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapblackView:)];
        self.tap = tap;
        // 设置属性
        // 轻拍次数
        tap.numberOfTapsRequired = 1;
        // 手指个数
        tap.numberOfTouchesRequired = 1;
        // 添加到视图上
        [_blackView addGestureRecognizer:tap];
        self.isBlackView = YES;
    }
}
- (void)tapblackView:(UITapGestureRecognizer *)sender{
    if(self.isFirstBlackView){
            self.searchBar.text = nil;
            //    [self.searchHistoryNameArr removeAllObjects];
            [self.searchBar resignFirstResponder];
            self.isSearchView = NO;
            [self.searchTableView removeFromSuperview];
            [self.blackView removeFromSuperview];
            self.isSearchTableView = NO;
            self.isBlackView = NO;
            self.isFirstBlackView = YES;
            self.isFirstSearchTableView = NO;
        self.tabBarController.tabBar.hidden = NO;
    }
    if (self.isFirstSearchTableView) {
        [self.view bringSubviewToFront:self.searchTableView];
        [self.searchBar resignFirstResponder];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];    
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)layoySearchView{
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
    self.searchView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.searchView];
    UILabel * tags = [UILabel  new];
    tags.text = @"热门搜索";
    tags.font = [UIFont systemFontOfSize:14];//设置文字类型与大小
    tags.frame = CGRectMake(20, 0 + 10, 100, 100);
    [self.searchView addSubview:tags];
    WEAKSELF(ws);
    [tags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.searchView).with.offset(0 + 20);
        make.left.equalTo(ws.searchView).with.offset(20);
    }];
    
    //储存button数组
    
    //button边框颜色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){0.81, 0.81, 0.81, 0.81});
    int x = 0;
    for (int i = 0; i < _nameArr.count; i++) {
        CGFloat longs = 0;
        if (x < _nameArr.count) {
            for (int j = x; j < _nameArr.count; j++) {
                
                CGRect rect = [_nameArr[j] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-36, 1000000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
                if (longs + 15 + rect.size.width + 15 + 15 < [UIScreen mainScreen].bounds.size.width) {
                    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
                    bt.tag = 101 + j;
                    //设置button frame
                    bt.frame = CGRectMake(15 + longs, (tags.frame.origin.y +40 ) +33 * i, rect.size.width  +30, 25);
                    [bt setTitle:_nameArr[j] forState:(UIControlStateNormal)];
                    [bt setTitleColor:[UIColor colorWithRed:80 / 255.0 green:80 / 255.0  blue:80 / 255.0  alpha:1] forState:(UIControlStateNormal)];
                    [bt addTarget:self action:@selector(hotSearchAction:) forControlEvents:(UIControlEventTouchUpInside)];
                    bt.titleLabel.font = [UIFont systemFontOfSize:13];
                    //设置边框
                    bt.layer.borderWidth = 1.0;  //边框宽度
                    bt.layer.cornerRadius = 4.5; //设置圆角
                    bt.layer.borderColor = borderColorRef; //边框颜色
                    bt.backgroundColor = [UIColor whiteColor];
                    [self.searchView addSubview:bt];
                    
                    longs += bt.frame.size.width +15;
                    
                    x = j + 1;
                    [self.buttonArr addObject:bt];
                }
                else
                {
                    break;
                }
                
            }
            
        }
        else
        {
            break;
        }
        
    }
    
    UILabel * History = [UILabel  new];
    History.text = @"历史搜索";
    History.font = [UIFont fontWithName:@"Arial" size:15];//设置文字类型与大小
    [self.searchView addSubview:History];
    UIButton *bt = self.buttonArr.lastObject;
    [History mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bt.mas_bottom).with.offset(20);
        make.left.equalTo(ws.searchView).with.offset(20);
        make.size.equalTo(tags);
    }];
    UIButton *histoyBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.historyBt = histoyBt;
    [_historyBt setTitle:@"" forState:(UIControlStateNormal)];
    [_historyBt setImage:[UIImage imageNamed:@"42.png"] forState:(UIControlStateNormal)];
    [_historyBt setTintColor:[UIColor blackColor]];
    [_historyBt addTarget:self action:@selector(_historyBtAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchView addSubview:_historyBt];
    
    [_historyBt mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerY.mas_equalTo(History.centerY).offset(15);
        make.centerY.equalTo(History);
        make.right.equalTo(ws.searchView).with.offset(-40);
        //        make.height.equalTo(History);
        //        make.width.equalTo(_historyBt.mas_height);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, LCF_SCREEN_WIDTH, 10) style:(UITableViewStylePlain)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tag = 5001;
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.searchView addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(History.mas_bottom).offset(20);
        make.left.right.equalTo(ws.searchView);
        make.bottom.equalTo(ws.searchView).offset(-49);
    }];
    self.isFirstSearchTableView = NO;
    self.isFirstBlackView = YES;
    
}
-(void)FMDB{
    self.db = [FMDBDataBase sharedManager];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([_db open])
    {
        //4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE  if not exists SearchHistory (id integer primary key autoincrement,  searchName text, searchHistory text);"];
        if (result)
        {
            NSLog(@"创建表成功");
        }
    }
    
    FMResultSet *resultSet = [self.db executeQuery:@"select * from SearchHistory "];
    while ([resultSet  next])
        
    {
        //            int idNum = [resultSet intForColumn:@"id"];
        
        NSString *name = [resultSet objectForColumnName:@"searchName"];
        [self.searchHistoryNameArr addObject:name];
        //        NSLog(@"%d,%@,%d",idNum,name,age);
        
    }
    [self.db close];
    
}
#pragma mark - searchBarDelegate
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    if (self.isSearchTableView) {
        [self.view bringSubviewToFront:self.searchTableView];
        
    }else{
        self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:(UITableViewStylePlain)];
        
        self.searchTableView.dataSource = self;
        self.searchTableView.delegate = self;
        self.searchTableView.tag = 5000;
        [self.view addSubview:self.searchTableView];
        self.isSearchTableView = YES;
        
    }
    BOOL isinsert = YES;
    for (NSString *name in self.searchHistoryNameArr) {
        if ([searchBar.text isEqualToString:name]) {
            isinsert = NO;
        }
    }
    if (isinsert) {
        //插入
        [self.db open];
        NSString *searchHistory = @"history";
        [self.db executeUpdateWithFormat:@"insert into searchHistory (searchName ,searchHistory) values (%@,%@);",searchBar.text,searchHistory];
        [self.searchHistoryNameArr addObject:searchBar.text];
        [self.myTableView reloadData];
        //        [self.searchTableView reloadData];
        [self.db close];
    }
    
    self.isFirstBlackView = NO;
    self.isFirstSearchTableView = YES;
    self.searchBar.text = nil;
}
-(void)hotSearchAction:(UIButton *)button{
    BOOL isinsert = YES;
    for (NSString *name in self.searchHistoryNameArr) {
        if ([button.titleLabel.text isEqualToString:name]) {
            isinsert = NO;
        }
    }
    if (isinsert) {
        [self.db open];
        //插入
        NSString *searchHistory = @"history";
        [self.db executeUpdateWithFormat:@"insert into searchHistory (searchName ,searchHistory) values (%@,%@);",button.titleLabel.text,searchHistory];
        [self.searchHistoryNameArr addObject:button.titleLabel.text];
        [self.myTableView reloadData];
        [self.db close];
        _lastIndexPath = nil;

    }
//    MultipleSetsOfDataVC *busimessVC = [MultipleSetsOfDataVC new];
//    busimessVC.navigationItem.title = button.titleLabel.text;
    [self.searchBar resignFirstResponder];
//    [self.navigationController pushViewController:busimessVC animated:YES];
    
    
}
-(void)_historyBtAction{
    if(self.searchHistoryNameArr.count == 0){
//        [MBProgressHUD showError:@"无历史记录" toView:self.view];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否删除历史记录" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            
        }];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.db open];
            //删除
            [self.db executeUpdateWithFormat:@"delete from SearchHistory where searchHistory = %@;",@"history"];
            [self.searchHistoryNameArr removeAllObjects];
            [self.myTableView reloadData];
//            [MBProgressHUD showSuccess:@"删除成功"];
            NSLog(@"删除");
            [self.db close];
        }];
        [alertController addAction:deleteAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 5000) {
        return self.nameArr.count;
    }else{
        return self.searchHistoryNameArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdtifier = @"cell";
    SearchHistoryCell *cell;
    if (cell == nil) {
        cell = [[SearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdtifier];
    }
    if (tableView.tag == 5000) {
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.nameArr[indexPath.row];
    }else {
        [cell setDelegate:self];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.searchHistoryNameArr[indexPath.row];
        [cell.deleteBt addTarget:self action:@selector(deleteBtAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar resignFirstResponder];
//    PersionalViewController *persionalVC = [PersionalViewController new];
    if (tableView.tag == 5000) {
//        persionalVC.navigationItem.title = self.nameArr[indexPath.row];
    }else{
//        persionalVC.navigationItem.title = self.searchHistoryNameArr[indexPath.row];
    }
//    [self.navigationController pushViewController:persionalVC animated:YES];
    [self.myTableView reloadData];
    self.searchBar.text = nil;
}
//显示菜单
- (void)showMenu:(SearchHistoryCell *)cell
{
    cell.deleteBt.hidden = NO;
    //删除上一个deleteBt
    SearchHistoryCell *lastCell = [self.myTableView cellForRowAtIndexPath:_lastIndexPath];
    lastCell.deleteBt.hidden = YES;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    if (self.lastIndexPath == indexPath) {
        cell.deleteBt.hidden = NO;
    }
    self.lastIndexPath = indexPath;
}
-(void)deleteBtAction:(UIButton *)button {
    SearchHistoryCell *cell = (SearchHistoryCell *)button.superview;
    [self.db open];
    [self.db executeUpdateWithFormat:@"delete from SearchHistory where searchName = %@;",cell.textLabel.text];
    [self.searchHistoryNameArr removeObject:cell.textLabel.text];
    [self.myTableView reloadData];
//    [MBProgressHUD showSuccess:@"删除成功"];
    [self.db close];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
