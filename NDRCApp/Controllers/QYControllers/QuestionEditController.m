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

#import "TZImagePickerController.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"
@interface QuestionEditController ()<UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{

    UIButton *ProjectLabelBtn;
    UIButton *CategoryLabelBtn;
    UIButton *SubdLabelBtn;
    
    BOOL isSelectGLJ;
    
    
    CGFloat _itemWH;
    CGFloat _margin;
    
    
    int uploadImageNum;
    
    int maxImageNum;
}

@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UITextView *textView;


@property(nonatomic,copy)NSString *encodedImageStr;
@property(nonatomic,copy)NSString *bigCategoryID;
@property(nonatomic,copy)NSString *gljID;

@property(nonatomic,strong)NSMutableArray *bigCategoryArray;
//@property(nonatomic,strong)NSMutableArray *littleCatrgoryAllDataArray;
@property(nonatomic,strong)NSMutableArray *littleCatrgoryDataArray;


@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@property(nonatomic,strong)NSMutableArray *selectedAssets;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

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
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
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
    
    
    maxImageNum=3;
    
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
    
    UIView *projectNameView=[self creatLabelWithName:@"项目名称"];
    projectNameView.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(90));
    ProjectLabelBtn=[self creaTLabelWithSuperView:projectNameView title:@"请选择项目"];
    [ProjectLabelBtn addTarget:self action:@selector(getGProjectNameListAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *QuestionCategoryView=[self creatLabelWithName:@"问题大类"];
    QuestionCategoryView.sd_layout.leftEqualToView(projectNameView).topSpaceToView(projectNameView, leftSpace).rightEqualToView(projectNameView).heightRatioToView(projectNameView, 1);
    
    CategoryLabelBtn=[self creaTLabelWithSuperView:QuestionCategoryView title:@"请选择问题大类"];
    [CategoryLabelBtn addTarget:self action:@selector(getBigCategoryNameListAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *QuestionSubdView=[self creatLabelWithName:@"问题小类"];
    QuestionSubdView.sd_layout.leftEqualToView(QuestionCategoryView).rightEqualToView(QuestionCategoryView).topSpaceToView(QuestionCategoryView, leftSpace).heightRatioToView(QuestionCategoryView, 1);
    
    SubdLabelBtn=[self creaTLabelWithSuperView:QuestionSubdView title:@"请选择问题小类"];
    [SubdLabelBtn addTarget:self action:@selector(getGLJNameListAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *QuestionMessageView=[self creatLongMessageViewWithMessage:@"请输入问题描述..." name:@"提报问题"];
    QuestionMessageView.sd_layout.leftEqualToView(QuestionCategoryView).rightEqualToView(QuestionCategoryView).topSpaceToView(QuestionSubdView, 0);
    
    
    UILabel *imageLabel=[[UILabel alloc] init];
    imageLabel.text=@"添加图片";
    imageLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    imageLabel.textColor=[UIColor blackColor];
    [self.backScroller addSubview:imageLabel];
    imageLabel.sd_layout.leftSpaceToView(self.backScroller,leftSpace+ widthOn(20)).rightEqualToView(QuestionCategoryView).topSpaceToView(QuestionMessageView, 0).heightIs(widthOn(90));

    
    
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (k_ScreenWidth-leftSpace*2 - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.layer.borderColor=appDarkLineColor.CGColor;
    _collectionView.layer.borderWidth=1;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = self.backScroller.backgroundColor;
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.backScroller addSubview:_collectionView];
    
    _collectionView.sd_layout.leftSpaceToView(self.backScroller, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(_itemWH+8).topSpaceToView(imageLabel, 0);
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    [self.backScroller setupAutoHeightWithBottomView:_collectionView bottomMargin:widthOn(50)];
    
}

-(UIView *)creatLabelWithName:(NSString *)name{
    
    UIView *viewQ=[[UIView alloc] init];
    viewQ.layer.borderColor=appDarkLineColor.CGColor;
    viewQ.layer.borderWidth=1;
    viewQ.backgroundColor=[UIColor whiteColor];
    [self.backScroller addSubview:viewQ];
    viewQ.sd_cornerRadius=@6.2;
    
    UILabel *leftLabel=[[UILabel alloc] init];
    leftLabel.text=name;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=[UIColor darkGrayColor];
    [viewQ addSubview:leftLabel];
    leftLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, widthOn(20), 0, 0));
    
   
    
    
    return viewQ;
    
}


-(UIButton *)creaTLabelWithSuperView:(UIView *)viewQ title:(NSString *)qtitle{

    UIButton *rightLabelBtn=[[UIButton alloc] init];
    [rightLabelBtn setTitle:qtitle forState:UIControlStateNormal];
//    rightLabelBtn.backgroundColor=[UIColor greenColor];
    [rightLabelBtn.titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
    [rightLabelBtn setTitleColor:ColorWithAlpha(0x000000, 1) forState:UIControlStateNormal];
    [viewQ addSubview:rightLabelBtn];
    rightLabelBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    rightLabelBtn.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, widthOn(180), 0, widthOn(20)));
    return rightLabelBtn;
}

-(UIView *)creatLongMessageViewWithMessage:(NSString *)message name:(NSString *)name{
    
    UIView *viewQ=[[UIView alloc] init];
    
    [self.backScroller addSubview:viewQ];
    
    
    UILabel *leftLabel=[[UILabel alloc] init];
    leftLabel.text=name;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=[UIColor blackColor];
    [viewQ addSubview:leftLabel];
    leftLabel.sd_layout.leftSpaceToView(viewQ, widthOn(20)).topSpaceToView(viewQ, 0).rightSpaceToView(viewQ, 0).heightIs(widthOn(90));
    [leftLabel updateLayout];
    
    UIView *backView=[[UIView alloc] init];
    backView.layer.borderColor=appDarkLineColor.CGColor;
    backView.layer.borderWidth=1;
    backView.backgroundColor=[UIColor whiteColor];
    backView.clipsToBounds=YES;
    [viewQ addSubview:backView];
    backView.sd_layout.leftSpaceToView(viewQ, 0).topSpaceToView(leftLabel, 0).rightSpaceToView(viewQ, 0);
    self.textView=[[UITextView alloc] init];
    self.textView.text=message;
    self.textView.font=leftLabel.font;
    self.textView.textColor=ColorWithAlpha(0x666666, 1);
    self.textView.delegate=self;
    [backView addSubview:self.textView];
    self.textView.textAlignment=NSTextAlignmentLeft;
    self.textView.sd_layout.leftEqualToView(leftLabel).rightSpaceToView(backView,widthOn(20)).topSpaceToView(backView, widthOn(15)).heightIs(widthOn(250));
    backView.sd_cornerRadius=@6.2;
    [backView setupAutoHeightWithBottomView:self.textView bottomMargin:widthOn(15)];
    
    [viewQ setupAutoHeightWithBottomView:backView bottomMargin:0];
    
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
            if (_selectedPhotos.count>0) {
                
                
                uploadImageNum=0;
                
                for (UIImage *image in _selectedPhotos) {
                    
                    //存储头像
                    NSData *data = nil;
                    data = UIImageJPEGRepresentation(image, 0.5);
                    
                    NSString * encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    
                    NSMutableDictionary *dicq=[NSMutableDictionary dictionaryWithObject:questionId forKey:@"questionID"];
                    [dicq setValue:encodedImageStr forKey:@"image"];
                    
                    
                    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Add_Image" parameters:dicq success:^(id response) {
                        NSLog(@"----返回%@",response);
                        
                        uploadImageNum++;
                        if (uploadImageNum==_selectedPhotos.count) {
                            [[ProgressHud shareHud] stopLoading];
                        }
//                        if ([response[@"STATE"][@"text"] isEqualToString:@"0"]) {
//                            

//                        }
                    } failure:^(NSError *error) {
                        
                        uploadImageNum++;
                        if (uploadImageNum==_selectedPhotos.count) {
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





#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count==maxImageNum) {
         return _selectedPhotos.count ;
    }
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count && _selectedPhotos.count!=maxImageNum) {
        cell.imageView.image = [UIImage imageNamed:@"添加图片有背景.png"];
        cell.deleteBtn.hidden = YES;
        
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
       
        cell.deleteBtn.hidden = NO;
    }

    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count && _selectedPhotos.count!=maxImageNum) {
     
        NSString *title1=@"拍照";
        NSString *title2=@"从手机相册选取";
        NSString *cancel=@"取消";
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:cancel destructiveButtonTitle:title1 otherButtonTitles:title2, nil];
     
        [actionSheet showInView:self.view];
        
//        [self pushImagePickerController];
        
      
    } else { // preview photos or video / 预览照片或者视频
       
       
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.maxImagesCount = maxImageNum;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.isSelectOriginalPhoto = NO;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        
        
    }
}





- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView reloadData];

}




#pragma mark  点击拍照或从相册取照片的协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    if (buttonIndex == 0) {
        [self takePhoto];
        
    }else if(buttonIndex == 1){

        [self pushImagePickerController];

        
    }
    
    
}
-(void)pushImagePickerController{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImageNum columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    
    imagePickerVc.selectedAssets = _selectedAssets;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"%@////////////%@",photos,assets);
        self.selectedPhotos=[NSMutableArray arrayWithArray:photos];
        self.selectedAssets=[NSMutableArray arrayWithArray:assets];
        [_collectionView reloadData];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushPhotoPickerController];
    }
}


// 调用相机
- (void)pushPhotoPickerController {

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        tzImagePickerVc.sortAscendingByModificationDate =YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
//                        if (self.allowCropSwitch.isOn) { // 允许裁剪,去裁剪
//                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
//                            }];
//                            imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
//                            imagePicker.circleCropRadius = 100;
//                            [self presentViewController:imagePicker animated:YES completion:nil];
//                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                        }
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 上传修改的个人信息


//****************************以上上传图片*******************************



- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入问题描述..."]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请输入问题描述...";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self.textView resignFirstResponder];
        return YES; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
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
