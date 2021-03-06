//
//  PersonalCtrl.m
//  BlueToothBracelet
//
//  Created by huang dengpin on 15/7/2.
//  Copyright (c) 2015年 dachen. All rights reserved.
//

#import "PersonalCtrl.h"
#import "DeviceManagerViewController.h"
#import "HistoryDataViewController.h"
#import "SexViewController.h"
#import "UtilityFunc.h"
#import "GTMBase64.h"
#import "AlarmClockViewController.h"
#import "AlertSettingsViewController.h"

@interface PersonalCtrl ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSArray *dataArray;
    NSArray *imageArray;
    
    UIActionSheet *_imageActionSheet;
    UIImagePickerController *imagePicker;
}

@property (strong, nonatomic) UITableView *personalTable;

@end

@implementation PersonalCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人";
    self.view.backgroundColor = kThemeGrayColor;
    
    imageArray = @[@"data",@"target",@"bell",@"clock",@"setup",@"i",@"datacenter"];
    dataArray = [[NSArray alloc] initWithObjects:@"我的资料",@"训练目标",@"提醒设置",@"智能闹钟",@"设备管理",@"关于我们",@"数据中心", nil];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    headerView.backgroundColor = [UtilityUI stringTOColor:@"#06bd90"];
    [self.view addSubview:headerView];
    
    UITapGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [headerView addGestureRecognizer:recognizer];
    
    UIImageView *headerImageBg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 80)/2, 10, 80, 80)];
    headerImageBg.image = [UIImage imageNamed:@"portrait2"];
    [self.view addSubview:headerImageBg];
    
    UILabel *lblUserName = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, ScreenWidth - 30, 26)];
    lblUserName.text = @"赵大虎";
    lblUserName.font = [UIFont boldSystemFontOfSize:20];
    lblUserName.textAlignment = NSTextAlignmentCenter;
    lblUserName.textColor = [UIColor whiteColor];
    [headerView addSubview:lblUserName];
    
    
    self.personalTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, ScreenHeight - 150 -68) style:UITableViewStylePlain];
    self.personalTable.dataSource = self;
    self.personalTable.delegate = self;
    self.personalTable.backgroundColor = [UIColor clearColor];
    [self.personalTable setTableFooterView:[UIView new]];
    [self.view addSubview:self.personalTable];
    
    _imageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机",nil];
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier =@"PersonalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    for (UIView *subview in cell.contentView.subviews)
    {
        [subview removeFromSuperview];
    }
    
    cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            SexViewController *VC = [[SexViewController alloc] init];
            VC.isJump = YES;
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:
        {}
            break;
        case 2:
        {
            AlertSettingsViewController *VC = [[AlertSettingsViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:
        {
            AlarmClockViewController *VC = [[AlarmClockViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:
        {
            DeviceManagerViewController *VC = [[DeviceManagerViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 5:
        {}
            break;
        case 6:
        {
            HistoryDataViewController *VC = [[HistoryDataViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)handleTapFrom:(UITapGestureRecognizer*)recognizer {
    // 触发手勢事件后，在这里作些事情
    
    [_imageActionSheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //设置默认状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if (buttonIndex == 0)
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    image = [UtilityFunc compressImage:image];
    
    NSString *imgContent = [[NSString alloc] initWithData:[GTMBase64 encodeData:UIImageJPEGRepresentation(image, 0.8)] encoding:NSUTF8StringEncoding];
    
    
    
    //设置白色状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        //设置白色状态栏
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        //设置默认状态栏
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
