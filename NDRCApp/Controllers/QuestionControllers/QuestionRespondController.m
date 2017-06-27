//
//  QuestionRespondController.m
//  NDRCApp
//
//  Created by vp on 2017/6/14.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionRespondController.h"
#import "NetWorkManager.h"
#import "QuestionRespondView.h"
@interface QuestionRespondController ()<ChooseImageViewDelegate>
@property(nonatomic,strong)QuestionRespondView *myView;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@end

@implementation QuestionRespondController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"问题处理"];
    self.menubtn.hidden=YES;
    
   
    self.myView=[[QuestionRespondView alloc] init];

    self.myView.chooseImageView.delegate=self;
    [self.view addSubview:self.myView];

    self.myView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
    // Do any additional setup after loading the view.
}
-(void)pushPhotoPickerControllerAction:(UIImagePickerController *)imagePickerVc{
 
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}
-(void)pushImagePickerControllerAction:(TZImagePickerController *)imagePickerVc{
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)ShowImagePickerControllerAction:(TZImagePickerController *)imagePickerVc{
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];

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
