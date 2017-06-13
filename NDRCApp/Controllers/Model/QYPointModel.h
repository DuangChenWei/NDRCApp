//
//  QYPointModel.h
//  NDRCApp
//
//  Created by vp on 2017/5/19.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
@interface QYPointModel : NSObject
@property(nonatomic,copy)NSString *qyName;
@property(nonatomic,copy)NSString *qyId;
@property(nonatomic,strong)AGSGraphic *graphic;
@end
