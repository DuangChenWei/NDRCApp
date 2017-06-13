//
//  QYMessageModel.m
//  NDRCApp
//
//  Created by vp on 2017/5/17.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYMessageModel.h"

@implementation QYMessageModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(void)setMessageWithDictionary:(NSDictionary *)dic{

//    NSLog(@"%@",dic);
    self.qyId=[NSString stringWithFormat:@"%@",dic[@"ID"][@"text"]];
    self.qyName=[NSString stringWithFormat:@"%@",dic[@"PRONAME"][@"text"]];
    self.qyAddress=[NSString stringWithFormat:@"%@",dic[@"ADDRESS"][@"text"]];
    self.qyContact=[NSString stringWithFormat:@"%@",dic[@"ATTEN"][@"text"]];
    self.qyMessage=[NSString stringWithFormat:@"%@",dic[@"COMPANYPROFILE"][@"text"]];
    self.qyProgress=[NSString stringWithFormat:@"%@",dic[@"PROGRESS"][@"text"]];
    self.qyBuildMessage=[NSString stringWithFormat:@"%@",dic[@"CONTENT"][@"text"]];
    
    
}

@end
