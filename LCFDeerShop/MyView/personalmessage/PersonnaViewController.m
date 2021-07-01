//
//  PersonnaViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/23.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "PersonnaViewController.h"
#import "ActionSheetPicker.h"
#import "AbstractActionSheetPicker+Interface.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AJImageheadData.h"
#import "AddressViewController.h"

@protocol PersonnaViewControllerDelegate <NSObject>

@optional
- (void)heardWithSharMagerImage:(UIImageView *)image;


@end

@interface PersonnaViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,ABPeoplePickerNavigationControllerDelegate>
@property   (nonatomic ,retain) UITableView     * tableview;


@end

@implementation PersonnaViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"个人信息设置";


  
}
-(void)actionlefItemBt1 {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (UITableView *)tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        _tableview.rowHeight = 44;
    }
    
    return _tableview;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4 ;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 6;
    }
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if (indexPath.section == 0) {
        return 64;
    }
    return 44;
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
            cell.detailTextLabel.text = @"我的头像";
            cell.imageView.image = [UIImage imageNamed:@"011e07585a579ea801219c77d12349.jpg@900w_1l_2o_100sh"];
            
            
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"昵称:";
            cell.detailTextLabel.text =@"会喷水的大象";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"性别:";
            cell.detailTextLabel.text = @"男";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"年龄";
            cell.detailTextLabel.text = @"25";
        }if (indexPath.row == 3) {
            cell.textLabel.text = @"生日";
        }if (indexPath.row == 4) {
            cell.textLabel.text = @"二维码";
        }if (indexPath.row == 5) {
            cell.textLabel.text = @"通讯录";
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"身高";
        }if (indexPath.row == 1) {
            cell.textLabel.text = @"体重";
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"地址管理";
        }if (indexPath.row == 1) {
            cell.textLabel.text = @"账号绑定";
        }
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        //头像
        if (indexPath.row == 0) {
            WEAKSELF(weakSelf)
            [[AJImageheadData  shareInstance] showActionSheetInView:self.view fromController:self completion:^(UIImage *image, NSData *iamgeData) {
                cell.imageView.image  = image;
                if ([weakSelf.delegate respondsToSelector:@selector(heardWithSharMagerImage:)]) {
                    
                    [weakSelf.delegate performSelector:@selector(heardWithSharMagerImage:) withObject:cell.imageView];
                    
                }
                
                
                
            } cancelBlock:^{
                
            }];
        }

        
    }else if (indexPath.section == 1){
        if (indexPath.row == 5) {
            WEAKSELF(weakSelf)
            [YMUtils CheckAddressBookAuthorization:^(bool isAuthorized) {
                if (isAuthorized) {
                    ABPeoplePickerNavigationController * abpeoplePick = [[ABPeoplePickerNavigationController alloc]init];
                    abpeoplePick.peoplePickerDelegate = weakSelf;
                    //    [self.navigationController presentModalViewController:abpeoplePick animated:YES];
                    [weakSelf.navigationController presentViewController:abpeoplePick animated:YES completion:^{
                        
                    }];
                }else{
                    [MBManager showBriefAlert:@"请到设置>隐私>通讯录打开本应用的权限设置"];
                }
            }];
            
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            NSMutableArray *dataArr = [[NSMutableArray alloc] initWithObjects:@"140",@"150",@"160",@"170",@"180", nil];
            
            ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"身高" rows:dataArr initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //*********一组点击确认按钮做处理************
                
                cell.detailTextLabel.text = selectedValue;
                NSLog(@"身高---------%@",selectedValue);
                
                
            } cancelBlock:^(ActionSheetStringPicker *picker) {
                
            } origin:self.view];
            [actionPicker customizeInterface];
            [actionPicker showActionSheetPicker];
        }
        
    }else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
            AddressViewController * address = [AddressViewController new];
            [self.navigationController pushViewController:address animated:YES];
        }
    }
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    
    
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int k = 0; k<ABMultiValueGetCount(phone); k++)
    {
        //获取电话Label
        NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
        //获取該Label下的电话值
        NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
        
        //通过数据model赋值给自己的电话.
        
//        self.addressModel.phoneNumber = personPhone;
        
//        NewAddressTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//        cell.textField.text = personPhone;
        
        NSLog(@"%@~~~~~~%@",personPhoneLabel,personPhone);
    }
    NSLog(@"%@",person);
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
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
