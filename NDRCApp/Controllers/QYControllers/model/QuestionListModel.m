//
//  QuestionListModel.m
//  NDRCApp
//
//  Created by vp on 2017/6/2.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionListModel.h"

@implementation QuestionListModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
}

-(void)setMessageWithDic:(NSDictionary *)dic{
    
    self.ZRRName=[NSString stringWithFormat:@"%@",(dic[@"FUNAME"][@"text"])?(dic[@"FUNAME"][@"text"]):@""];
    self.GLJName=[NSString stringWithFormat:@"%@",(dic[@"GLJNAME"][@"text"])?(dic[@"GLJNAME"][@"text"]):@""];
    self.GLJId=[NSString stringWithFormat:@"%@",(dic[@"GUANID"][@"text"])?(dic[@"GUANID"][@"text"]):@""];
    NSLog(@"tu::%@",dic[@"IMAGESOURCE"][@"text"]);
    self.iconURL=[NSString stringWithFormat:@"%@",(dic[@"IMAGESOURCE"][@"text"])?[NSString stringWithFormat:@"%@:6500%@",BeiDouServiceUrl,(dic[@"IMAGESOURCE"][@"text"])]:@""];
    self.TJRName=[NSString stringWithFormat:@"%@",(dic[@"LOGINNAME"][@"text"])?(dic[@"LOGINNAME"][@"text"]):@""];
    self.problemContent=[NSString stringWithFormat:@"%@",(dic[@"PROBLEMCONTENT"][@"text"])?(dic[@"PROBLEMCONTENT"][@"text"]):@""];
    self.QYName=[NSString stringWithFormat:@"%@",(dic[@"PRONAME"][@"text"])?(dic[@"PRONAME"][@"text"]):@""];
    self.QuestionID=[NSString stringWithFormat:@"%@",(dic[@"QUEID"][@"text"])?(dic[@"QUEID"][@"text"]):@""];
    self.state=[NSString stringWithFormat:@"%@",(dic[@"STATE"][@"text"])?(dic[@"STATE"][@"text"]):@""];
    self.timestamp=[NSString stringWithFormat:@"%@",(dic[@"TIME"][@"text"])?(dic[@"TIME"][@"text"]):@""];
    self.submitTime=[self timeWithTimeIntervalString:self.timestamp];
    
    
}
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
