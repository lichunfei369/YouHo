//
//  CategoryListingController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/27.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CategoryListingController.h"
#import "GridListCollectionViewCell.h"
#import "NSObject+Property.h"
#import "GridListModel.h"
#import "ShopDetailsViewController.h"
@interface CategoryListingController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
    UIButton * NavigaBt;
    BOOL _isGrid;
}

@property   (nonatomic ,retain) UICollectionView    * collectionView;

@property   (nonatomic ,retain) NSMutableArray      * dataArr;



@end

@implementation CategoryListingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品列表";
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    
    NavigaBt = [UIButton buttonWithType:UIButtonTypeCustom];
    NavigaBt.frame = CGRectMake(0, 0, 40, 40);
    [NavigaBt addTarget:self action:@selector(ClickNavigabt:) forControlEvents:UIControlEventTouchUpInside];
    [NavigaBt setImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:NavigaBt];
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    
    // 默认列表视图
    _isGrid = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    [self.view addSubview:self.collectionView];
    
    NSArray *products = dict[@"wareInfo"];
    for (id obj in products) {
        [self.dataArr addObject:[GridListModel objectWithDictionary:obj]];
    }

    
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc] init];
        [flowlayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
        flowlayout.minimumInteritemSpacing = 2;
        flowlayout.minimumLineSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2, 2, self.view.bounds.size.width - 4, self.view.bounds.size.height - 4) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        
        [_collectionView registerClass:[GridListCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell];
    }
    return  _collectionView;
}


-(void)actionlefItemBt {

    [self.navigationController popViewControllerAnimated:YES];
}


//导航栏切换按钮
- (void)ClickNavigabt:(UIButton *)sender {
    
    _isGrid = !_isGrid;
    [self.collectionView reloadData];
    
    if (_isGrid) {
        [NavigaBt setImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:0];
    } else {
        [NavigaBt setImage:[UIImage imageNamed:@"product_list_list_btn"] forState:0];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell forIndexPath:indexPath];
    cell.isGrid = _isGrid;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGrid) {
        return CGSizeMake((LCF_SCREEN_WIDTH - 6) / 2, (LCF_SCREEN_WIDTH - 6) / 2 + 40);
    } else {
        return CGSizeMake(LCF_SCREEN_WIDTH - 4, (LCF_SCREEN_WIDTH - 6) / 4 + 20);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopDetailsViewController * shopDetails  = [[ShopDetailsViewController alloc] init];
    [self.navigationController pushViewController:shopDetails animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
