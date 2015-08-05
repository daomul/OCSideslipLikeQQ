//
//  Utility.m
//  QQPie2.0
//
//  Created by bos on 15-6-27.
//  Copyright (c) 2015年 axiba. All rights reserved.
//

#import "Utility.h"

@implementation Utility


/*获取屏幕分辨率Bounds*/
+ (CGRect)getScreenBounds{
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect;
    
}
/*获取屏幕分辨率宽度*/
+ (CGFloat )getScreenWidth{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return size.width;
    
}
/*获取屏幕分辨率宽度*/
+ (CGFloat )getScreenHeight{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return size.height;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
