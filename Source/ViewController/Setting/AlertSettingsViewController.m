//
//  AlertSettingsViewController.m
//  BlueToothBracelet
//
//  Created by huang dengpin on 15/8/22.
//  Copyright (c) 2015年 dachen. All rights reserved.
//

#import "AlertSettingsViewController.h"

@interface AlertSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation AlertSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"闹钟";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setTableFooterView:[UIView new]];
    
    self.dataArray = @[@"闹钟",@"时间",@"提醒间隔",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)return 0.1;
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section != 3) return 1;
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if(indexPath.section == 0)
    {
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = self.dataArray[indexPath.row+1];
    }
    else if(indexPath.section == 2)
    {
        cell.textLabel.text = self.dataArray[indexPath.row+2];
    }else if(indexPath.section == 3)
    {
        cell.textLabel.text = self.dataArray[indexPath.row+3];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
