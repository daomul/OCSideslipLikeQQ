//
//  ViewController.m
//  QQPie2.0
//
//  Created by bos on 15-6-27.
//  Copyright (c) 2015年 axiba. All rights reserved.
//

#define FullDistance 0.78
#define Proportion 0.77

#import "ViewController.h"

@interface ViewController ()
{
    CGFloat distance;
    XBHomeViewController *homeVC;
    XBLeftViewController *leftVC;
    XBmainTabBarController *mainTabBarVC;
    UINavigationController *homenavVC;
    CGPoint centerOfLeftViewAtBeginning;
    UIView *backCover;
    UIView *mainView;// 构造主视图。实现 UINavigationController.view 和 HomeViewController.view 一起缩放。
    
    CGFloat proportionOfLeftView;
    CGFloat distanceOfLeftView;
    
    UITapGestureRecognizer *tap;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    distance = 0.0;
    proportionOfLeftView = 1;
    distanceOfLeftView = 50;
    
    // 1、主界面设置背景
    UIImage *image = [UIImage imageNamed:@"background"];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    imageV.frame = [Utility getScreenBounds];
    [self.view addSubview:imageV];
        
    /**
     *  2 增加左视图
     */
    
    //2.1、通过 StoryBoard 取出 leftViewController 的 view，放在背景视图上面
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    leftVC = (XBLeftViewController*)[sb instantiateViewControllerWithIdentifier:@"XBLeftViewController"];
    
    if ([Utility getScreenWidth] > 320)
    {
        proportionOfLeftView = [Utility getScreenWidth] / 320;
        distanceOfLeftView += ([Utility getScreenWidth] - 320) * FullDistance / 2;
    }
    
    leftVC.view.center = CGPointMake(leftVC.view.center.x - 50, leftVC.view.center.y);
    leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    
    centerOfLeftViewAtBeginning = leftVC.view.center;
    [self.view addSubview:leftVC.view];
    
    
    //2.2 增加黑色遮罩层，实现视差特效
    backCover.frame = CGRectOffset(self.view.frame, 0, 0);
    backCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backCover];
    
    /**
     *  3 将tabBar添加到main视图中
     */
    mainView = [[UIView alloc]initWithFrame:self.view.frame];
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"MainTabBarController" owner:self options:nil];
    mainTabBarVC = (XBmainTabBarController *)arr[0];
    
    UIView *tabBarView = mainTabBarVC.view;
    [mainView addSubview:tabBarView];
    
    /**
     *  4 添加到home视图
     */
    
    //3.1 通过 StoryBoard 取出 HomeViewController 的 view，放在背景视图上面
    homenavVC = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"XBHomeNavigationController"];
    homeVC = (XBHomeViewController *)homenavVC.viewControllers[0];
    [tabBarView addSubview:homeVC.navigationController.view];
    [tabBarView addSubview:homeVC.view];
    
    [tabBarView bringSubviewToFront:mainTabBarVC.tabBar];
    [self.view addSubview:mainView];
    
#warning barbutton 点击事件
    
    
    //5.手势控制 UIPanGestureRecognizer
    
    UIPanGestureRecognizer *pan = homeVC.panFlow;
    [pan addTarget:self action:@selector(Pan:)];
    [mainView addGestureRecognizer:pan];
    
     // 生成单击收起菜单手势
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showHome)];
    
    homeVC.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"qq"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
}


#pragma mark —— UIPanGestureRecognizer

-(void)Pan:(UIPanGestureRecognizer *)rec
{
    CGFloat x = [rec translationInView:self.view].x;
    CGFloat trueDistance = distance + x;//实时距离
    CGFloat trueProportion = trueDistance / ([Utility getScreenWidth]*FullDistance);
    
    // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
    if(rec.state == UIGestureRecognizerStateEnded)
    {
        if (trueDistance > [Utility getScreenWidth] * (Proportion / 3))
        {
            [self showLeft];
        }
        else if(trueDistance < [Utility getScreenWidth] * -(Proportion / 3))
        {
            [self showHome];
        }
        else
        {
            [self showHome];
        }
        return;
    }
    
    CGFloat newProportion = rec.view.frame.origin.x >= 0 ?-1 :1;
    newProportion *= trueDistance / [Utility getScreenWidth];
    newProportion *= 1 - Proportion;
    newProportion /= FullDistance + Proportion/2 - 0.5;
    newProportion += 1;
    
    if (newProportion <= Proportion)
    {
        //若比例已经达到最小，则不再继续动画
        return;
    }
    // 执行视差特效
    backCover.alpha = (newProportion - Proportion) / (1 - Proportion);
    
    
    // 执行平移和缩放动画
    rec.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, newProportion, newProportion);
    
    // 执行左视图动画
    CGFloat pro = 0.8 + (proportionOfLeftView - 0.8) * trueProportion;
    leftVC.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView * trueProportion, centerOfLeftViewAtBeginning.y - (proportionOfLeftView - 1) * leftVC.view.frame.size.height * trueProportion / 2 );
    leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
    
}

#pragma mark - show
-(void)showLeft
{
    [mainView addGestureRecognizer:tap];
    distance = self.view.center.x * (FullDistance*2 +  Proportion - 1);
    [self doTheAnimate:Proportion showWhat:@"left"];
    [homenavVC popToRootViewControllerAnimated:YES];
}
-(void)showright
{
    [mainView addGestureRecognizer:tap];
    distance = self.view.center.x * -(FullDistance*2 +  Proportion - 1);
    [self doTheAnimate:Proportion showWhat:@"right"];
}
-(void)showHome
{
    [mainView removeGestureRecognizer:tap];
    distance = 0;
    [self doTheAnimate:1 showWhat:@"home"];

}
-(void)doTheAnimate:(CGFloat)proportion showWhat:(NSString *)showWhat
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        mainView.center = CGPointMake(self.view.center.x + distance, self.view.center.y);
        mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        if ([showWhat isEqual: @"left"])
        {
            leftVC.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView, leftVC.view.center.y);
            leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportionOfLeftView, proportionOfLeftView);
        }
        backCover.alpha = [showWhat isEqual:@"home"] ? 1 : 0;
        leftVC.view.alpha = [showWhat isEqual:@"right"] ? 0 : 1;
        
    } completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











