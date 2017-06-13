//
//  ProgressHud.m
//  Utf8
//
//  Created by cw on 15/6/30.
//  Copyright (c) 2015年 com.com. All rights reserved.
//

#import "ProgressHud.h"
#import "AppDelegate.h"
static ProgressHud *hudDate=nil;
@implementation ProgressHud
+(ProgressHud *)shareHud{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudDate = [[ProgressHud alloc] init];
        
    });
    return hudDate;
   
}

-(void)startLoadingWithShowView:(UIView *)aView text:(NSString *)text{

    if (self.HUD) {
        self.HUD=nil;
    }
    
    self.HUD=[[MBProgressHUD alloc] initWithView:aView];
    [aView addSubview:self.HUD];
 
//    self.HUD.dimBackground=YES;
    if (text) {
        self.HUD.detailsLabelText=text;
    }
    
//    self.HUD.detailsLabelText=@"啥玩意";
    self.HUD.color=[UIColor darkGrayColor];
//    self.HUD.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.2];
//    self.HUD.activityIndicatorColor=[UIColor colorWithRed:0.3 green:0.3  blue:0.3  alpha:0.8];
//    self.HUD.alpha=0.5;
//    self.HUD.cornerRadius=30;
     [self.HUD show:YES];
    
    if (self.t) {
        [self.t invalidate];
        self.t=nil;
    }
    self.t = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(stopLoading) userInfo:nil repeats:NO];
    
    
}
-(void)stopLoading{

    [self.t invalidate];
    self.t=nil;
    
    if (self.HUD) {

    [self.HUD hide:YES];
    [self.HUD removeFromSuperview];
    self.HUD=nil;
    }
}

@end
