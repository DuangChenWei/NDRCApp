//
//  MainViewController.m
//  RainStationApp
//
//  Created by vp on 2017/4/27.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "MainViewController.h"
#import "NetWorkManager.h"

#import <ArcGIS/ArcGIS.h>
#import "QYMessageModel.h"
#import "QYMainSearchView.h"
#import "QYMessageController.h"
#import "QYPointModel.h"
#import "QuestionListController.h"
#import "ChangePasswordController.h"
#import "QYItemQuestionListController.h"
@interface MainViewController ()<AGSMapViewLayerDelegate,AGSQueryTaskDelegate,AGSMapViewTouchDelegate,AGSQueryTaskDelegate,QYSearchViewDelegate>
{
    
    BOOL isLoadMap;
    BOOL isLoadQueryTask;
    BOOL isSelectSearchMenu;
    
}
@property(nonatomic,strong)AGSMapView *mapView;
@property(nonatomic,strong)NSMutableArray *mapArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,strong)AGSQueryTask *queryTask;
@property(nonatomic,strong)AGSQuery *query;
@property(nonatomic,strong)AGSGraphicsLayer *graphicsLayer;
@property(nonatomic,strong)AGSGraphic *searchResultGraphic;
@property(nonatomic,strong)QYMainSearchView *searchView;
@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *dataArray = [NSArray array];
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectZero target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        
    }];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [CommonMenuView clearMenu];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.setPopGestureRecognizerOn=NO;
    [self initMainTitleBar:@"问题分布"];
    if ([NetWorkManager sharedInstance].powerStatus==Administrator) {
        self.backBtn.hidden=YES;
    }
    [self.menubtn addTarget:self action:@selector(onClickOpenMenu) forControlEvents:UIControlEventTouchUpInside];

    self.mapArray=[NSMutableArray array];
    self.valueArray=[NSMutableArray array];
    
    
    self.mapView=[[AGSMapView alloc] initWithFrame:CGRectMake(0, appNavigationBarHeight, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-appNavigationBarHeight)];
  
    self.mapView.backgroundColor=[UIColor whiteColor];
    self.mapView.touchDelegate=self;
    self.mapView.layerDelegate=self;
    [self.view addSubview:self.mapView];
    
    
    
    [self LoadMap];
 
    
    [self addSearchView];
    
   
}
-(void)onClickOpenMenu{
    
    NSArray *nameArr=@[@"问题汇总",@"企业列表",@"企业评价",@"修改密码"];
    NSMutableArray *arrValue=[NSMutableArray array];
    for (NSString *str in nameArr) {
        NSDictionary *dict1 = @{@"imageName" : @"",
                                @"itemName" : str
                                };
        [arrValue addObject:dict1];
    }
    
    
    
    NSArray *dataArray =[NSArray arrayWithArray:arrValue];
    [CommonMenuView updateMenuItemsWith:dataArray];

    [self popMenu:CGPointMake(self.navigationController.view.width - 20, 50)];
}
- (void)popMenu:(CGPoint)point{
//    NSLog(@"点击了  展示");000
    [CommonMenuView showMenuAtPoint:point];
    
}
#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    [CommonMenuView hidden];
    if (isSelectSearchMenu) {
        [self.searchView updateSelectSearchTypeWithTag:tag];
        isSelectSearchMenu=NO;
    }else{
        
        if (tag==2) {
           
            QYItemQuestionListController *qv=[[QYItemQuestionListController alloc] init];
            [self.navigationController pushViewController:qv animated:YES];
            
        }else if(tag==4){
            ChangePasswordController *qv=[[ChangePasswordController alloc] init];
            
            [self.navigationController pushViewController:qv animated:YES];
            
        }
        
        
    }
   
   
}


- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics{
    
//    NSLog(@"%@",mappoint);
    
    if (self.searchResultGraphic) {
        [self.graphicsLayer removeGraphic:self.searchResultGraphic];
        self.searchResultGraphic=nil;
    }
    
    NSArray *ValueArr=[graphics allValues];
    for (NSArray *arr in ValueArr) {
        
        AGSGraphic *graphic=arr[0];
        NSLog(@"点击了点击了%@,,",[graphic allAttributes][@"XH"]);
        [self getOneCompanyMessageWithId:[graphic allAttributes][@"XH"] name:[graphic allAttributes][@"XMMC"]];
        
    }

}



-(void)LoadMap
{
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@"正在加载地图"];
 
    
    NSURL *urlBengzhan= [NSURL URLWithString:MapViewUrl];
    AGSDynamicMapServiceLayer *  layerBengzhan111 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:urlBengzhan];

   
    layerBengzhan111.name = @"dynamicLayer";

    //    [self reFreshMapLayer];
    [self.mapView addMapLayer:layerBengzhan111 withName:@"BengzhanLayer"];
    
    self.graphicsLayer=[AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:self.graphicsLayer withName:@"grapLayer"];
    
    
    self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/0",MapViewUrl]]];
    
    self.queryTask.delegate = self;
                      //return all fields in query
    
    self.query = [AGSQuery query];
    
    self.query.outFields = [NSArray arrayWithObjects:@"*",nil];
    
    self.query.returnGeometry = YES;
    
    self.query.whereClause=@"1=1";
    
    [self.queryTask executeWithQuery:self.query];
    
    

    
}

-(void) mapViewDidLoad:(AGSMapView *)mapView{
    AGSEnvelope *fullEnv = [[AGSEnvelope alloc] initWithXmin:41495934.756668 ymin:4652074.288154 xmax:41534826.144140 ymax:4591367.094690 spatialReference:[[AGSSpatialReference alloc] initWithWKID:2365 WKT:nil]];//
    
   [self.mapView zoomToEnvelope:fullEnv animated:YES];
    
    
  
    isLoadMap=YES;
    if (isLoadQueryTask) {
        [[ProgressHud shareHud] stopLoading];
//        [self getRainMessage];
        [self addRainLayers];
    }else{
    
        
    }
    
}




-(void)queryTask: (AGSQueryTask*) queryTask operation:(NSOperation*) op didExecuteWithFeatureSetResult:(AGSFeatureSet*) featureSet{
    
     NSLog(@"成功");
    isLoadQueryTask=YES;
    //get feature, and load in to table
    if(featureSet.features.count>0)
    {
        for (AGSGraphic *graphic in featureSet.features) {
            
//            NSLog(@"成功了成功了,,%@",graphic.geometry.envelope);
            
            QYPointModel *model=[[QYPointModel alloc] init];
            model.qyName=[NSString stringWithFormat:@"%@",[graphic allAttributes][@"XMMC"]];
            model.qyId=[NSString stringWithFormat:@"%@",[graphic allAttributes][@"XH"]];
            model.graphic=graphic;
            
            [self.mapArray addObject:model];
 
            
            
        }
      
        if (isLoadMap) {
            [[ProgressHud shareHud] stopLoading];
//            [self getRainMessage];
            [self addRainLayers];
        }
        
        
        
    }

}
//if there’s an error with the query display it to the uesr 在Query失败后响应，弹出错误提示框
-(void)queryTask: (AGSQueryTask*)queryTask operation:(NSOperation*)op didFailWithError:(NSError*)error{

    NSLog(@"querytask查询失败");
    [[ProgressHud shareHud] stopLoading];
    
}
-(void)addRainLayers{

    [self.graphicsLayer removeAllGraphics];
    
    for (QYPointModel *model in self.mapArray) {
     
        AGSGraphic *graphic=model.graphic;
        //定义多边形要素的渲染样式
        AGSPictureMarkerSymbol* myPictureSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:[UIImage imageNamed:@"companyIcon_red.png"]];
        graphic.symbol = myPictureSymbol;
        [self.graphicsLayer addGraphic:graphic];
        
        [self.graphicsLayer refresh];
        
        
    }
}
-(void)getRainMessage{
    
    
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@"正在加载"];
    
    
    
    NSString *urlStr=@"Get_RealTimeRainfall_List";
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:urlStr parameters:nil success:^(NSDictionary *response) {
        //        [self.columnJiangYU stopLoading];
        [[ProgressHud shareHud] stopLoading];
        //        NSLog(@"%@",response);
        
        [self showColumnViewWithDic:response];
        
        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"获取雨量信息失败，请检查网络后重试"];
        
    }];
    
}

-(void)getOneCompanyMessageWithId:(NSString *)r_id name:(NSString *)r_name{

    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@"正在加载..."];
   
    NSString *urlStr=@"Check_ProjectBrief";
    NSMutableDictionary *bodyDic=[NSMutableDictionary dictionaryWithObject:r_id forKey:@"ProID"];
//    [bodyDic setValue:r_name forKey:@"ProName"];
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:urlStr parameters:bodyDic success:^(NSDictionary *response) {
      
        [[ProgressHud shareHud] stopLoading];
          NSLog(@"+++%@",response);
        id respon=response
        [@"ProjectBrief"];
        if ([respon isKindOfClass:[NSDictionary class]]) {
            QYMessageModel *model=[[QYMessageModel alloc] init];
            [model setMessageWithDictionary:respon];
            
            QYMessageController *mv=[[QYMessageController alloc] init];
            mv.model=model;
            [self.navigationController pushViewController:mv animated:YES];
            
        }
       
        

        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"获取企业信息失败，请检查网络后重试"];
        
    }];
}

-(void)showColumnViewWithDic:(NSDictionary *)response{
    
    id respon=response
    [@"RainFall"];
    
    [self.valueArray removeAllObjects];
  
    if ([respon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in respon) {
            
            
        }
    }else if ([respon isKindOfClass:[NSDictionary class]]){
       
    }else{
        
    }
    
    [self addRainLayers];
    
}

-(UIColor *)getColorWithName:(NSString *)name{

    return nil;
    
    
    
    
}

-(void)addSearchView{

    CGFloat leftSpace=widthOn(20);
    UIButton *searchBackBtn=[[UIButton alloc] initWithFrame:CGRectMake(leftSpace, appNavigationBarHeight+leftSpace, k_ScreenWidth-leftSpace*2, widthOn(80))];
    searchBackBtn.backgroundColor=[UIColor whiteColor];
    searchBackBtn.layer.borderColor=appLineColor.CGColor;
    searchBackBtn.layer.borderWidth=1;
    searchBackBtn.layer.cornerRadius=widthOn(10);
    [self.view addSubview:searchBackBtn];
    [searchBackBtn addTarget:self action:@selector(showSearchViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iconImv=[[UIImageView alloc] initWithFrame:CGRectMake(widthOn(20), CGRectGetHeight(searchBackBtn.frame)*0.5-widthOn(13.5), widthOn(27), widthOn(27))];
    iconImv.image=[UIImage imageNamed:@"searchBlue.png"];
    [searchBackBtn addSubview:iconImv];
    
    UILabel *searLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImv.frame)+CGRectGetMinX(iconImv.frame), 0, CGRectGetWidth(searchBackBtn.frame)-CGRectGetMaxX(iconImv.frame)-CGRectGetMinX(iconImv.frame), CGRectGetHeight(searchBackBtn.frame))];
    searLabel.text=@"请输入搜索内容";
    searLabel.textColor=appDarkLabelColor;
    searLabel.font=[UIFont systemFontOfSize:widthOn(30)];
    [searchBackBtn addSubview:searLabel];
    
}
-(void)searchViewBackAction{

    [self.searchView closeSearchView];
}
-(void)selectSearchTypeAction{

    isSelectSearchMenu=YES;
    
    NSDictionary *dict1 = @{@"imageName" : @"",
                            @"itemName" : @"搜索企业名称"
                            };
    NSDictionary *dict2 = @{@"imageName" : @"",
                            @"itemName" : @"搜索企业代码"
                            };
    
    NSArray *dataArray = @[dict1,dict2];
     [CommonMenuView updateMenuItemsWith:dataArray];
     [CommonMenuView showMenuAtPoint:CGPointMake(widthOn(60), CGRectGetMaxY(self.searchView.topSearchBackView.frame)-widthOn(30))];
}
-(void)showOneCompanyWithGraphic:(AGSGraphic *)graphic{

    AGSEnvelope *fullEnv = [[AGSEnvelope alloc] initWithXmin:graphic.geometry.envelope.xmin-1000 ymin:graphic.geometry.envelope.ymin+1500 xmax:graphic.geometry.envelope.xmax+1000 ymax:graphic.geometry.envelope.ymax-1500 spatialReference:[[AGSSpatialReference alloc] initWithWKID:2365 WKT:nil]];//
    [self.mapView zoomToEnvelope:fullEnv animated:YES];

    
    AGSTextSymbol* txtSymbol = [AGSTextSymbol textSymbolWithText:@"11" color:[UIColor blackColor]];
    txtSymbol.fontSize = 10;
    txtSymbol.fontFamily = @"Heiti SC";
    NSString * timeStampString = [graphic allAttributes][@"XMMC"];
    txtSymbol.text=timeStampString;
    txtSymbol.offset=CGPointMake(0, -15);
   
    if (self.searchResultGraphic) {
        [self.graphicsLayer removeGraphic:self.searchResultGraphic];
        self.searchResultGraphic=nil;
    }
    self.searchResultGraphic=[[AGSGraphic alloc] initWithGeometry:graphic.geometry symbol:txtSymbol attributes:[graphic allAttributes]];

    [self.graphicsLayer addGraphic:self.searchResultGraphic];

    [self.graphicsLayer refresh];

    
}
-(void)showSearchViewAction{

    if (self.mapArray.count>0) {
        if (self.searchView) {
            self.searchView.allDateArray=self.mapArray;
            [self.searchView showSearchView];
        }else{
            self.searchView=[[QYMainSearchView alloc] initWithFrame:CGRectMake(0, 0, k_ScreenWidth, k_ScreenHeight)];
            self.searchView.delegate=self;
            [self.searchView.backBtn addTarget:self action:@selector(searchViewBackAction) forControlEvents:UIControlEventTouchUpInside];
            [self.searchView.selectTypeBtn addTarget:self action:@selector(selectSearchTypeAction) forControlEvents:UIControlEventTouchUpInside];
            self.searchView.allDateArray=self.mapArray;
            [self.view addSubview:self.searchView];
            [self.searchView showSearchView];
        }
    }
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
