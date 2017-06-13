//
//  ProgressHud.h
//  Utf8
//
//  Created by cw on 15/6/30.
//  Copyright (c) 2015年 com.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface ProgressHud : NSObject

@property(nonatomic,strong)MBProgressHUD *HUD;
@property(nonatomic,strong)NSTimer *t;

+(ProgressHud *)shareHud;
-(void)startLoadingWithShowView:(UIView *)aView text:(NSString *)text;
-(void)stopLoading;
@end
