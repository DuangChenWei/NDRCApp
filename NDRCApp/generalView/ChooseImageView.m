//
//  ChooseImageView.m
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "ChooseImageView.h"

@implementation ChooseImageView
- (instancetype)init
{
    self = [super init];
    if (self) {
         CGFloat leftSpace=widthOn(35);
        UILabel *imageLabel=[[UILabel alloc] init];
        imageLabel.text=@"添加图片";
        imageLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        imageLabel.textColor=[UIColor blackColor];
        [self addSubview:imageLabel];
        imageLabel.sd_layout.leftSpaceToView(self, leftSpace+widthOn(20)).rightSpaceToView(self, leftSpace+widthOn(20)).topSpaceToView(self, 0).heightIs(widthOn(90));
        
       
        _maxImageNum=3;
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
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self addSubview:_collectionView];
        
        _collectionView.sd_layout.leftSpaceToView(self, leftSpace).rightSpaceToView(self, leftSpace).heightIs(_itemWH+8).topSpaceToView(imageLabel, 0);
        
        [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];

    }
    return self;
}


- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = [UIColor darkGrayColor];
        _imagePickerVc.navigationBar.tintColor = [UIColor darkGrayColor];
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


//*************************上传图片**********************************





#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count==_maxImageNum) {
        return _selectedPhotos.count ;
    }
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count && _selectedPhotos.count!=_maxImageNum) {
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
    if (indexPath.row == _selectedPhotos.count && _selectedPhotos.count!=_maxImageNum) {
        
        NSString *title1=@"拍照";
        NSString *title2=@"从手机相册选取";
        NSString *cancel=@"取消";
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:cancel destructiveButtonTitle:title1 otherButtonTitles:title2, nil];
        
        [actionSheet showInView:self];
        
        //        [self pushImagePickerController];
        
        
    } else { // preview photos or video / 预览照片或者视频
        
        
        
        if (self.delegate) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectedPhotos index:indexPath.row];
            imagePickerVc.maxImagesCount = self.maxImageNum;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.isSelectOriginalPhoto = NO;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
                self.selectedAssets = [NSMutableArray arrayWithArray:assets];
                [self.collectionView reloadData];
                self.collectionView.contentSize = CGSizeMake(0, ((self.selectedPhotos.count + 2) / 3 ) * (self.margin + self.itemWH));
            }];
            
            [self.delegate ShowImagePickerControllerAction:imagePickerVc];
        }
        
        
        
        
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
    
    if (self.delegate) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageNum columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
        
        imagePickerVc.selectedAssets = self.selectedAssets;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            NSLog(@"%@////////////%@",photos,assets);
            self.selectedPhotos=[NSMutableArray arrayWithArray:photos];
            self.selectedAssets=[NSMutableArray arrayWithArray:assets];
            [self.collectionView reloadData];
        }];
        
        [self.delegate pushImagePickerControllerAction:imagePickerVc];
    }
    
    
    
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
    
    if (self.delegate) {
        
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                self.imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self.delegate pushPhotoPickerControllerAction:self.imagePickerVc];
           
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }

        
        
        
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
    if (_selectedAssets==nil) {
        _selectedAssets=[NSMutableArray array];
    }
    if (_selectedPhotos==nil) {
        _selectedPhotos=[NSMutableArray array];
    }
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






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
