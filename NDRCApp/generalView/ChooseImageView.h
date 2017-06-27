//
//  ChooseImageView.h
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "TZImagePickerController.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"

@protocol ChooseImageViewDelegate <NSObject>

-(void)pushPhotoPickerControllerAction:(UIImagePickerController *)imagePickerVc;
-(void)pushImagePickerControllerAction:(TZImagePickerController *)imagePickerVc;
-(void)ShowImagePickerControllerAction:(TZImagePickerController *)imagePickerVc;
@end


@interface ChooseImageView : UIView<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{

    CGFloat _itemWH;
 
//    int uploadImageNum;
    
    ;
}
@property(nonatomic,assign)id<ChooseImageViewDelegate> delegate;
@property(nonatomic,assign)CGFloat margin;
@property(nonatomic,assign)int maxImageNum;
@property(nonatomic,assign)CGFloat itemWH;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@property(nonatomic,strong)NSMutableArray *selectedAssets;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end
