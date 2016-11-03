//
//  ViewController.m
//  WYZ3DView
//
//  Created by wyz on 2016/11/1.
//  Copyright © 2016年 wyz. All rights reserved.
//

#import "ViewController.h"
#import "WYZ3DView.h"

@interface ViewController ()

@end

@implementation ViewController{
    WYZ3DView *containerView;
    NSNumber *isHide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isHide = @NO;
    containerView = [[WYZ3DView alloc]initWithFrame:CGRectMake(100, 250, 200, 200)];
    containerView.partCountx = 4;
    containerView.partCounty = 1;
    containerView.storeyCount = 5;
    containerView.blockBorder = 50;
    containerView.blockFont = 10;
    containerView.dataArr = @[@[@[@44,@(-128),@MAXFLOAT,@12.3],@[@14.3,@15.3,@19.3,@21.3],@[@23.3,@27.3,@31.3,@32.3],@[@35.3,@37.3,@2.3,@5.3,@14.3]],@[@[@12.3,@14.3,@12.3,@14.3],@[@12.3,@14.3,@12.3,@14.3],@[@12.3,@14.3,@12.3],@[@14.3,@12.3,@14.3,@12.3,@14.3]],@[@[@12.3,@14.3,@12.3,@14.3,@12.3],@[@14.3,@12.3,@134,@14.3],@[@12.3,@14.3,@12.3,@14.3],@[@12.3,@14.3,@12.3,@14.3]],@[@[@12.3,@14.3,@12.3,@14.3,@12.3],@[@14.3,@12.3,@14.3,@12.3,@14.3],@[@12.3,@14.3,@12.3,@14.3]]];
    
    [self.view addSubview:containerView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 150, 30)];
    [btn1 setTitle:@"第一层隐藏或显示按钮" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(storeyIsHiden) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)storeyIsHiden{
    isHide = @(!isHide.boolValue);
    containerView.storeyIsHiddenArr = @[isHide];
}

@end
