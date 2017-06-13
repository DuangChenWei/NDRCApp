//
//  QuestionListModel.h
//  NDRCApp
//
//  Created by vp on 2017/6/2.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionListModel : NSObject
@property(nonatomic,copy)NSString *ZRRName;
@property(nonatomic,copy)NSString *GLJName;
@property(nonatomic,copy)NSString *GLJId;
@property(nonatomic,copy)NSString *iconURL;
@property(nonatomic,copy)NSString *TJRName;
@property(nonatomic,copy)NSString *problemContent;
@property(nonatomic,copy)NSString *QYName;
@property(nonatomic,copy)NSString *QuestionID;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *submitTime;
@property(nonatomic,copy)NSString *timestamp;
-(void)setMessageWithDic:(NSDictionary *)dic;
@end
