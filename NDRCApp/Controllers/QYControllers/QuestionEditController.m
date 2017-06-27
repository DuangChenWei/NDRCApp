//
//  QuestionEditControllerViewController.m
//  NDRCApp
//
//  Created by vp on 2017/5/22.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionEditController.h"
#import "NetWorkManager.h"
#import <AVFoundation/AVFoundation.h>
#import "ChooseImageView.h"
#import "myGeneralEditView.h"
@interface QuestionEditController ()<UIScrollViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,ChooseImageViewDelegate>

{

    UIButton *ProjectLabelBtn;
    UIButton *CategoryLabelBtn;
    UIButton *SubdLabelBtn;
    
    BOOL isSelectGLJ;

    int uploadImageNum;
    
  
}

@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UITextView *textView;


@property(nonatomic,copy)NSString *encodedImageStr;
@property(nonatomic,copy)NSString *bigCategoryID;
@property(nonatomic,copy)NSString *gljID;

@property(nonatomic,strong)NSMutableArray *bigCategoryArray;
//@property(nonatomic,strong)NSMutableArray *littleCatrgoryAllDataArray;
@property(nonatomic,strong)NSMutableArray *littleCatrgoryDataArray;

@property(nonatomic,strong)ChooseImageView *chooseImageView;

@end

@implementation QuestionEditController
-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *dataArray = [NSArray array];
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectMake(0, 0, k_ScreenWidth-20, 0) target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        
    }];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [CommonMenuView clearMenu];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"提报问题"];
    [self.menubtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.menubtn setTitle:@"提交" forState:UIControlStateNormal];
    CGRect rect=self.menubtn.frame;
    rect.origin.x=CGRectGetMinX(self.menubtn.frame)-widthOn(30);
    self.menubtn.frame=rect;
    [self.menubtn addTarget:self action:@selector(sendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    
    
 
    
    self.bigCategoryArray=[NSMutableArray array];
//    self.littleCatrgoryAllDataArray=[NSMutableArray array];
    
    [self addAllViews];
    // Do any additional setup after loading the view.
}


-(void)backKerBoard{

    [self.textView resignFirstResponder];
}



-(void)addAllViews{
    
    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.delegate=self;
    self.backScroller.backgroundColor=ColorWithAlpha(0xf9f9f9, 1);
    [self.view addSubview:self.backScroller];
    self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKerBoard)];
//    [self.backScroller addGestureRecognizer:tap];
    
    
    CGFloat leftSpace=widthOn(35);
    
    myGeneralEditView *projectNameView=[self creatLabelWithName:@"项目名称" rightTitle:@"请选择项目"];
    projectNameView.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(90));
    ProjectLabelBtn=projectNameView.chooseButton;
    [ProjectLabelBtn addTarget:self action:@selector(getGProjectNameListAction) forControlEvents:UIControlEventTouchUpInside];
    
    myGeneralEditView *QuestionCategoryView=[self creatLabelWithName:@"问题大类" rightTitle:@"请选择问题大类"];
    QuestionCategoryView.sd_layout.leftEqualToView(projectNameView).topSpaceToView(projectNameView, leftSpace).rightEqualToView(projectNameView).heightRatioToView(projectNameView, 1);
    
    CategoryLabelBtn=QuestionCategoryView.chooseButton;
    [CategoryLabelBtn addTarget:self action:@selector(getBigCategoryNameListAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    myGeneralEditView *QuestionSubdView=[self creatLabelWithName:@"问题小类" rightTitle:@"请选择问题小类"];
    QuestionSubdView.sd_layout.leftEqualToView(QuestionCategoryView).rightEqualToView(QuestionCategoryView).topSpaceToView(QuestionCategoryView, leftSpace).heightRatioToView(QuestionCategoryView, 1);
    
    SubdLabelBtn=QuestionSubdView.chooseButton;
    [SubdLabelBtn addTarget:self action:@selector(getGLJNameListAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *QuestionMessageView=[self creatLongMessageViewWithMessage:@"请输入问题描述..." name:@"提报问题"];
    QuestionMessageView.sd_layout.leftEqualToView(QuestionCategoryView).rightEqualToView(QuestionCategoryView).topSpaceToView(QuestionSubdView, 0);
    
    
    self.chooseImageView=[[ChooseImageView alloc] init];
    self.chooseImageView.delegate=self;
    [self.backScroller addSubview:self.chooseImageView];
    self.chooseImageView.sd_layout.leftSpaceToView(self.backScroller, 0).rightSpaceToView(self.backScroller, 0).topSpaceToView(QuestionMessageView, 0).heightIs(widthOn(500));

    
    [self.backScroller setupAutoHeightWithBottomView:self.chooseImageView bottomMargin:widthOn(50)];
    
}

-(myGeneralEditView *)creatLabelWithName:(NSString *)name rightTitle:(NSString *)rightTitle{
    
    myGeneralEditView *viewQ=[[myGeneralEditView alloc] initChooseButtonWithText:rightTitle leftViewWidth:widthOn(300) leftText:name];
    [self.backScroller addSubview:viewQ];
   
    
    
    return viewQ;
    
}

-(UIView *)creatLongMessageViewWithMessage:(NSString *)message name:(NSString *)name{
    
    myGeneralEditView *viewQ=[[myGeneralEditView alloc] initEditTextViewMessageWithContentText:message topText:name];
    [self.backScroller addSubview:viewQ];
    self.textView=viewQ.textView;

    
    return viewQ;
    
    
}


-(void)sendMessageAction{

    
    
    
    
    [self backKerBoard];
//    if ([self.proID isEqualToString:@""]||self.proID==nil) {
//        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清选择提报项目"];
//        return;
//    }
    if ([self.bigCategoryID isEqualToString:@""]||self.bigCategoryID==nil) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清选择问题大类"];
        return;
    }
    if ([self.gljID isEqualToString:@""]||self.gljID==nil) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清选择问题小类"];
        return;
    }
    if ([self.textView.text isEqualToString:@"请输入问题描述..."]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写问题描述"];
        return;
    }
   
    
    
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NetWorkManager sharedInstance].userInfoModel.perID forKey:@"loginPerID"];
    [dic setValue:self.bigCategoryID forKey:@"bigCategoryID"];
    [dic setValue:@"65" forKey:@"fuZePerID"];
    [dic setValue:@"654" forKey:@"proID"];
    [dic setValue:@"654" forKey:@"problem"];

    NSLog(@"穿的参数：：%@",dic);
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Add_Problem" parameters:dic success:^(id response) {
        NSLog(@"返回%@",response);
//        [[ProgressHud shareHud] stopLoading];
        if ([response[@"STATE"][@"text"] isEqualToString:@"0"]) {
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"提交成功"];
            
            NSString *questionId=response[@"QuestionID"][@"text"];
            if (self.chooseImageView.selectedPhotos.count>0) {
                
                
                uploadImageNum=0;
                
                for (UIImage *image in self.chooseImageView.selectedPhotos) {
                    
                    //存储头像
                    NSData *data = nil;
                    data = UIImageJPEGRepresentation(image, 0.5);
                    
                    NSString * encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    
                    NSMutableDictionary *dicq=[NSMutableDictionary dictionaryWithObject:questionId forKey:@"questionID"];
                    [dicq setValue:encodedImageStr forKey:@"image"];
                    
                    
                    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Add_Image" parameters:dicq success:^(id response) {
                        NSLog(@"----返回%@",response);
                        
                        uploadImageNum++;
                        if (uploadImageNum==self.chooseImageView.selectedPhotos.count) {
                            [[ProgressHud shareHud] stopLoading];
                        }
//                        if ([response[@"STATE"][@"text"] isEqualToString:@"0"]) {
//                            

//                        }
                    } failure:^(NSError *error) {
                        
                        uploadImageNum++;
                        if (uploadImageNum==self.chooseImageView.selectedPhotos.count) {
                            [[ProgressHud shareHud] stopLoading];
                        }
                        
                    }];
                    
                    
                    
                }

            }else{
            
                [[ProgressHud shareHud] stopLoading];
            }
            
 
            
            
//            [self.delegate refreshMessage];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
    }];
}

-(void)getGProjectNameListAction{

    [self backKerBoard];
    
}
-(void)getBigCategoryNameListAction{
     [self backKerBoard];
    if (self.bigCategoryArray.count>0) {
        
        [self showBigCategoryNameView];
        
        
    }else{
        [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:@"" forKey:@"id"];
        [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_ZhiNengOneINFO" parameters:dic success:^(id response) {
            [[ProgressHud shareHud] stopLoading];
            NSLog(@"--%@",response);
            id resPon=response[@"ZHINENGONE"];
            if ([resPon isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dic in resPon) {
                    NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                    [tempDic setValue:dic[@"ID"][@"text"] forKey:@"id"];
                    [tempDic setValue:dic[@"ZHINENGONENAME"][@"text"] forKey:@"itemName"];
                    [tempDic setValue:@"" forKey:@"imageName"];
                    [self.bigCategoryArray addObject:tempDic];
                }
                
            }else if ([resPon isKindOfClass:[NSMutableDictionary class]]){
                NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                [tempDic setValue:resPon[@"ID"][@"text"] forKey:@"id"];
                [tempDic setValue:resPon[@"ZHINENGONENAME"][@"text"] forKey:@"itemName"];
                [tempDic setValue:@"" forKey:@"imageName"];
                [self.bigCategoryArray addObject:tempDic];
                
            }else{
                
            }
            
            [self showBigCategoryNameView];
            
        } failure:^(NSError *error) {
            [[ProgressHud shareHud] stopLoading];
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
        }];
    }
    

    
}
-(void)showBigCategoryNameView{

    isSelectGLJ=NO;
    [CommonMenuView updateMenuItemsWith:self.bigCategoryArray];
    
    [self popMenu:CGPointMake(CGRectGetMaxX(CategoryLabelBtn.frame), widthOn(200)+appNavigationBarHeight)];

}
-(void)getGLJNameListAction{
    [self backKerBoard];

    if ([self.bigCategoryID isEqualToString:@""]||self.bigCategoryID==nil) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请先选择问题大类"];
        return;
    }
    
    
        [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:self.bigCategoryID forKey:@"ZHINENGONEID"];
        [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_ZhiNengTwoINFO" parameters:dic success:^(id response) {
            [[ProgressHud shareHud] stopLoading];
            NSLog(@"+++++%@",response);
            id resPon=response[@"ZHINENGTWO"];
            
            if (self.littleCatrgoryDataArray) {
                [self.littleCatrgoryDataArray removeAllObjects];
            }else{
                
                self.littleCatrgoryDataArray=[NSMutableArray array];
            }
            
            if ([resPon isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dic in resPon) {
                    NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                   
                        [tempDic setValue:dic[@"GLJID"][@"text"] forKey:@"id"];
                        [tempDic setValue:dic[@"ZHINENGTWONAME"][@"text"] forKey:@"itemName"];
                        [tempDic setValue:@"" forKey:@"imageName"];
                        [tempDic setValue:dic[@"ZHINENGONEID"][@"text"] forKey:@"bigCategoryID"];
                        [self.littleCatrgoryDataArray addObject:tempDic];
                    
                    
                }
                
            }else if ([resPon isKindOfClass:[NSMutableDictionary class]]){
                NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                
                    [tempDic setValue:resPon[@"ID"][@"text"] forKey:@"id"];
                    [tempDic setValue:resPon[@"Name"][@"text"] forKey:@"itemName"];
                    [tempDic setValue:@"" forKey:@"imageName"];
                    [tempDic setValue:resPon[@"ZHINENGONEID"][@"text"] forKey:@"bigCategoryID"];
                    [self.littleCatrgoryDataArray addObject:tempDic];
                
                
            }else{
                
            }
            
            [self showGLJView];
            
        } failure:^(NSError *error) {
            [[ProgressHud shareHud] stopLoading];
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
        }];
    

    
}

-(void)showGLJView{
    isSelectGLJ=YES;
    

    if (self.littleCatrgoryDataArray.count>0) {
        [CommonMenuView updateMenuItemsWith:self.littleCatrgoryDataArray];
        
        [self popMenu:CGPointMake(CGRectGetMaxX(SubdLabelBtn.frame), widthOn(330)+appNavigationBarHeight)];
 
    }else{
    
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"该问题大类暂无问题小类"];
    }
    
    
}
- (void)popMenu:(CGPoint)point{
    //    NSLog(@"点击了  展示");000
    [CommonMenuView showMenuAtPoint:point];
     [self backKerBoard];
    
}
#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    [CommonMenuView hidden];
 
    if (isSelectGLJ) {
        [SubdLabelBtn setTitle:str forState:UIControlStateNormal];
        self.gljID=self.littleCatrgoryDataArray[tag-1][@"id"];
    }else{
        self.bigCategoryID=self.bigCategoryArray[tag-1][@"id"];
        [SubdLabelBtn setTitle:@"请选择问题小类" forState:UIControlStateNormal];
        self.gljID=@"";
        [CategoryLabelBtn setTitle:str forState:UIControlStateNormal];
    }
    
}
//*************************上传图片**********************************



-(void)pushPhotoPickerControllerAction:(UIImagePickerController *)imagePickerVc{
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}
-(void)pushImagePickerControllerAction:(TZImagePickerController *)imagePickerVc{
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)ShowImagePickerControllerAction:(TZImagePickerController *)imagePickerVc{
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}




//****************************以上上传图片*******************************


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.backScroller.sd_closeAutoLayout = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.backScroller.sd_closeAutoLayout = NO;
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
