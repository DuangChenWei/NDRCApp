//
//  ViewController.m
//  RainStationApp
//
//  Created by vp on 2017/4/27.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "ViewController.h"
#import "ZLGetUUID.h"
@interface ViewController ()
{

    NSTimer *timer;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    
 
    UIImageView *imv=[[UIImageView alloc] init];
    imv.image=[UIImage imageNamed:@"1s广告.png"];
    [self.view addSubview:imv];
    imv.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    
    UIButton *nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [nextBtn setTitle:@"跳 过" forState:UIControlStateNormal];
//    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
//    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    nextBtn.layer.borderWidth=1;
//    nextBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [nextBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.rightSpaceToView(self.view, widthOn(30)).topSpaceToView(self.view, 20+widthOn(15)).widthIs(widthOn(130)).heightIs(widthOn(60));
    nextBtn.sd_cornerRadius=@4;
    


    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(pushAction) userInfo:nil repeats:NO];
    
    
    
    
}

-(void)pushAction{

    [timer invalidate];
    timer=nil;
    
    [self performSegueWithIdentifier:@"pushLogin" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
