//
//  XBHomeViewController.m
//  QQPie2.0
//
//  Created by bos on 15-6-27.
//  Copyright (c) 2015年 axiba. All rights reserved.
//

#import "XBHomeViewController.h"

@interface XBHomeViewController ()

@end

@implementation XBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"消息",@"联系人",nil];
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    seg.selectedSegmentIndex = 0;
    seg.width = 60;

    self.navigationItem.titleView = seg;
    
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
