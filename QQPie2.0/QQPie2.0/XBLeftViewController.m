//
//  XBLeftViewController.m
//  QQPie2.0
//
//  Created by bos on 15-6-28.
//  Copyright (c) 2015年 axiba. All rights reserved.
//

#import "XBLeftViewController.h"

@interface XBLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *dic;
}

@end

@implementation XBLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dic = @{@"0":@"开通会员",@"1":@"QQ钱包", @"2":@"网上营业厅",@"3":@"个性装扮", @"4":@"我的收藏", @"5":@"我的相册", @"6":@"我的文件"};
    _LeftTableView.delegate = self;
    _LeftTableView.dataSource = self;
    _LeftTableView.backgroundColor = [UIColor clearColor];
    
    if ([Utility getScreenHeight] < 500)
    {
        //[self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
        
        //[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:<#(id)#> attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>]];
        //self.view.height = [Utility getScreenHeight] * (568 - 221)/568;
    }
    else
    {
        //self.view.height = 347;
    }
    self.view.frame = CGRectMake(0, 0, 320 * 0.78, [Utility getScreenHeight]);
    
}

#pragma  mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dic count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftViewCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [dic valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    return cell;
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
