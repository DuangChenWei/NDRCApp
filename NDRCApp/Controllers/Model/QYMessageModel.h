//
//  QYMessageModel.h
//  NDRCApp
//
//  Created by vp on 2017/5/17.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYMessageModel : NSObject
@property(nonatomic,copy)NSString *qyName;
@property(nonatomic,copy)NSString *qyId;
@property(nonatomic,copy)NSString *qyAddress;
@property(nonatomic,copy)NSString *qyProgress;
@property(nonatomic,copy)NSString *qyContact;
@property(nonatomic,copy)NSString *qyMessage;
@property(nonatomic,copy)NSString *qyBuildMessage;

-(void)setMessageWithDictionary:(NSDictionary *)dic;

@end
