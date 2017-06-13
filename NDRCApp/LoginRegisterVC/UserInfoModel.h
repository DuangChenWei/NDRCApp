//
//  UserInfoModel.h
//  NDRCApp
//
//  Created by vp on 2017/6/1.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYMessageModel.h"
@interface UserInfoModel : NSObject
@property(nonatomic,copy)NSString *perID;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *Power;
@property(nonatomic,strong)QYMessageModel *qyMessageModel;

@property(nonatomic,copy)NSString *gljID;
@property(nonatomic,copy)NSString *gljName;

@end
