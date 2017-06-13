//
//  RegisterViewController.m
//  RainStationApp
//
//  Created by vp on 2017/5/9.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetWorkManager.h"
@interface RegisterViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{

    CGFloat viewHeight;
    
    NSInteger selectPowerID;
    
    NSInteger selectMenuType;
    
    
}

@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *telTextField;
@property(nonatomic,strong)UITextField *passWordTextField;
@property(nonatomic,strong)UITextField *surePassWordField;
@property(nonatomic,strong)UITextField *powerTextField;
@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UITextField *groupTextField;

@property(nonatomic,strong)NSMutableArray *guanlijuArray;
@property(nonatomic,strong)NSMutableArray *qiyeArray;

@property(nonatomic,copy)NSString *guanlijuID;
@property(nonatomic,copy)NSString *qiyeID;

@end

@implementation RegisterViewController
-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *dataArray = [NSArray array];
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectMake(0, 0, k_ScreenWidth-15, 0) target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        
    }];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [CommonMenuView clearMenu];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initMainTitleBar:@"注册"];
    self.menubtn.hidden=YES;
    self.baseLineView.hidden=YES;
    
    self.qiyeArray=[NSMutableArray array];
    self.guanlijuArray=[NSMutableArray array];
    
    
    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.backgroundColor=[UIColor whiteColor];
    self.backScroller.delegate=self;
    [self.view addSubview:self.backScroller];
    self.backScroller.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, appNavigationBarHeight).bottomSpaceToView(self.view, 0);

    
    
    viewHeight=widthOn(90);
    CGFloat topY=widthOn(30);
    self.nameTextField=[self creatTextfieldWithTitle:@"企业全称" placeHoder:@"请输入企业全称" viewY:topY];

    self.telTextField=[self creatTextfieldWithTitle:@"手机号码" placeHoder:@"请输入手机号码" viewY:topY+viewHeight*1];
    self.telTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.passWordTextField=[self creatTextfieldWithTitle:@"输入密码" placeHoder:@"请输入密码" viewY:topY+viewHeight*2];
    self.passWordTextField.secureTextEntry = YES;
    self.surePassWordField=[self creatTextfieldWithTitle:@"确认密码" placeHoder:@"请再次输入密码" viewY:topY+viewHeight*3];
    self.surePassWordField.secureTextEntry = YES;
    
//    self.powerTextField=[self creatTextfieldWithTitle:@"所属权限" placeHoder:@"请输入权限" viewY:topY+viewHeight*4];
    
//    UIButton *powerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [powerBtn addTarget:self action:@selector(choosePowerNameAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.powerTextField addSubview:powerBtn];
//    powerBtn.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
//    
//    self.groupTextField=[self creatTextfieldWithTitle:@"" placeHoder:@"" viewY:topY+viewHeight*5];
//    
//    UIButton *groupBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [groupBtn addTarget:self action:@selector(chooseGroupAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.groupTextField addSubview:groupBtn];
//    groupBtn.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
//    
//    self.groupTextField.hidden=YES;
    
    self.nameTextField.delegate=self;
    self.telTextField.delegate=self;
    self.passWordTextField.delegate=self;
    self.surePassWordField.delegate=self;
    
    UIButton *registerBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font=[UIFont boldSystemFontOfSize:widthOn(36)];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:appMainColor];
    [registerBtn addTarget:self action:@selector(regisbtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backScroller addSubview:registerBtn];
    registerBtn.sd_layout.topSpaceToView(self.surePassWordField, widthOn(50)).centerXEqualToView(self.backScroller).widthIs(widthOn(400)).heightIs(widthOn(80));
    registerBtn.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(40)];
    
    
    UIButton *agreeMentBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    NSString *messageStr=@"• 注册代表同意《开发区降雨监测用户协议》";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSRange strRange = [messageStr rangeOfString:@"《"];
    if (strRange.location<[messageStr length]&&strRange.location>0) {
        NSRange colorRange=NSMakeRange(strRange.location, [messageStr length]-strRange.location);
        
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:colorRange];
        [str addAttribute:NSForegroundColorAttributeName
         
                    value:[UIColor darkGrayColor]
         
                    range:NSMakeRange(0, colorRange.location)];
        [str addAttribute:NSForegroundColorAttributeName
         
                    value:appMainColor
         
                    range:colorRange];
        [agreeMentBtn setAttributedTitle:str forState:UIControlStateNormal];
    }else{
        
        [agreeMentBtn setTitle:messageStr forState:UIControlStateNormal];
    }

    agreeMentBtn.titleLabel.font=[UIFont systemFontOfSize:widthOn(26)];
    agreeMentBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:agreeMentBtn];
    agreeMentBtn.sd_layout.topSpaceToView(registerBtn, widthOn(20)).centerXEqualToView(registerBtn).widthRatioToView(registerBtn, 1.5).heightIs(widthOn(60));
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}
-(UITextField *)creatTextfieldWithTitle:(NSString *)title placeHoder:(NSString *)hoder viewY:(CGFloat)viewY{

    UITextField *textField=[[UITextField alloc] init];
    textField.placeholder=hoder;
    textField.font=[UIFont systemFontOfSize:widthOn(34)];
    [self.backScroller addSubview:textField];
    textField.sd_layout.leftSpaceToView(self.backScroller, widthOn(50)).topSpaceToView(self.backScroller, viewY).rightSpaceToView(self.backScroller, widthOn(50)).heightIs(widthOn(80));
    textField.leftViewMode=UITextFieldViewModeUnlessEditing;
    UILabel *leftLabel=[[UILabel alloc] init];
    leftLabel.frame=CGRectMake(0, 0, widthOn(180), widthOn(80));
    leftLabel.text=title;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=ColorWithAlpha(0x999999, 1);
    textField.leftView=leftLabel;
    
    UIView *view=[[UIView alloc] init];
    
    view.backgroundColor=appLineColor;
    
    [textField addSubview:view];
    view.sd_layout.leftSpaceToView(textField, 0).bottomSpaceToView(textField, 0).widthRatioToView(textField, 1).heightIs(1);
    
    

    
    return textField;
    
    
}

//-(void)choosePowerNameAction{
//
//    [self backKeyBoard];
//    NSDictionary *dict1 = @{@"imageName" : @"",
//                            @"itemName" : @"领导"
//                            };
//    NSDictionary *dict2 = @{@"imageName" : @"",
//                            @"itemName" : @"管理局"
//                            };
//    NSDictionary *dict3 = @{@"imageName" : @"",
//                            @"itemName" : @"企业用户"
//                            };
//    
//    NSArray *dataArray = @[dict1,dict2,dict3];
//    selectMenuType=11;
//    [CommonMenuView updateMenuItemsWith:dataArray];
//    
//    [self popMenu:CGPointMake(CGRectGetMinX(self.powerTextField.frame)+widthOn(80), CGRectGetMaxY(self.powerTextField.frame)-widthOn(30)+appNavigationBarHeight)];
//}


//-(void)chooseGroupAction{
//
//    if (selectPowerID==1) {
//        [self showGuanlijuPicker];
//    }else if (selectPowerID==2) {
//        [self showQiYePicker];
//    }
//    
//}

- (void)popMenu:(CGPoint)point{
    //    NSLog(@"点击了  展示");000
    [CommonMenuView showMenuAtPoint:point];
    
}
#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    [CommonMenuView hidden];
    if (selectMenuType==12) {
        self.groupTextField.text=str;
        self.guanlijuID=self.guanlijuArray[tag-1][@"id"];
    }else if (selectMenuType==13){
    
        self.groupTextField.text=str;
        self.qiyeID=self.qiyeArray[tag-1][@"id"];
    }else{
        selectPowerID=tag-1;
        self.powerTextField.text=str;
        
        if (tag==2) {
            self.groupTextField.text=@"";
            self.groupTextField.placeholder=@"请选择管理局";
            
            self.groupTextField.hidden=NO;
        }else if (tag==3) {
            self.groupTextField.text=@"";
            self.groupTextField.placeholder=@"请选择企业";
            self.groupTextField.hidden=NO;
        }
        else{
            
            self.groupTextField.hidden=YES;
        }

    }
    
    
   
}

-(void)regisbtnAction{

     [self backKeyBoard];
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写企业名称"];
        return;
    }
    if ([self.telTextField.text isEqualToString:@""]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写手机号"];
        return;
    }
    if ([self.passWordTextField.text isEqualToString:@""]) {
       [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写密码"];
        return;
    }
    
    if (![self.passWordTextField.text isEqualToString:self.surePassWordField.text]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"两次输入的密码不一致"];
        return;
    }
//    if ([self.powerTextField.text isEqualToString:@""]) {
//        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请选择权限"];
//        return;
//    }
//    if ([self.groupTextField.text isEqualToString:@""]&&selectPowerID!=0) {
//        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请选择所属企业项目或管理局"];
//        return;
//    }
   
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    
    NSMutableDictionary *BodyDic=[NSMutableDictionary dictionary];
    [BodyDic setValue:self.telTextField.text forKey:@"loginName"];
    [BodyDic setValue:self.passWordTextField.text forKey:@"loginPwd"];
    [BodyDic setValue:self.nameTextField.text forKey:@"companyName"];
//    [BodyDic setValue:[NSString stringWithFormat:@"%ld",selectPowerID] forKey:@"power"];
//    if (selectPowerID==1) {
//        [BodyDic setValue:self.guanlijuID forKey:@"gljID"];
//    }else if (selectPowerID==2) {
//        [BodyDic setValue:self.qiyeID forKey:@"proID"];
//    }
    
    
   
 
    NSLog(@"传的注册参数：%@",BodyDic);
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Add_LoginUser" parameters:BodyDic success:^(id response) {
        [[ProgressHud shareHud] stopLoading];
        NSLog(@"注册返回值%@",response);
        NSString *returnStr=response[@"State"][@"text"];
        if ([returnStr isEqualToString:@"0"]) {
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([returnStr isEqualToString:@"1"]){
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"注册失败，请联系管理员"];
        }else if ([returnStr isEqualToString:@"2"]){
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"注册失败，账号已存在"];
        }else if ([returnStr isEqualToString:@"3"]){
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"注册失败，请联系管理员"];
        }else{
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"注册失败，未知错误，请联系管理员"];
        }
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"注册失败，请检查网络后重试"];
    }];

    
}



-(void)showGuanlijuPicker{
    
    
    if (self.guanlijuArray.count>0) {
        
        [self showGuanlijuView];
        
        
    }else{
        [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
        [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_GUANLIJUINFO" parameters:nil success:^(id response) {
            [[ProgressHud shareHud] stopLoading];
                        NSLog(@"--%@",response);
            id resPon=response[@"GUANLIJU"];
            if ([resPon isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dic in resPon) {
                    NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                    [tempDic setValue:dic[@"ID"][@"text"] forKey:@"id"];
                    [tempDic setValue:dic[@"GLJNAME"][@"text"] forKey:@"itemName"];
                    [tempDic setValue:@"" forKey:@"imageName"];
                    [self.guanlijuArray addObject:tempDic];
                }
                
            }else if ([resPon isKindOfClass:[NSMutableDictionary class]]){
                NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                [tempDic setValue:resPon[@"ID"][@"text"] forKey:@"id"];
                [tempDic setValue:resPon[@"PRONAME"][@"text"] forKey:@"itemName"];
                [tempDic setValue:@"" forKey:@"imageName"];
                [self.guanlijuArray addObject:tempDic];
                
            }else{
                
            }
            
            [self showGuanlijuView];
            
        } failure:^(NSError *error) {
            [[ProgressHud shareHud] stopLoading];
        }];
    }

    
    
}
-(void)showQiYePicker{

    if (self.qiyeArray.count>0) {
    
        [self showQiYeView];
       

    }else{
        [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
        [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_BRIEFINFO" parameters:nil success:^(id response) {
            [[ProgressHud shareHud] stopLoading];
//            NSLog(@"--%@",response[@"BRIEF"]);
            id resPon=response[@"BRIEF"];
            if ([resPon isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dic in resPon) {
                    NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                    [tempDic setValue:dic[@"ID"][@"text"] forKey:@"id"];
                    [tempDic setValue:dic[@"PRONAME"][@"text"] forKey:@"itemName"];
                    [tempDic setValue:@"" forKey:@"imageName"];
                    [self.qiyeArray addObject:tempDic];
                }
                
            }else if ([resPon isKindOfClass:[NSMutableDictionary class]]){
                NSMutableDictionary *tempDic=[NSMutableDictionary dictionary];
                [tempDic setValue:resPon[@"ID"][@"text"] forKey:@"id"];
                [tempDic setValue:resPon[@"PRONAME"][@"text"] forKey:@"itemName"];
                [tempDic setValue:@"" forKey:@"imageName"];
                [self.qiyeArray addObject:tempDic];

            }else{
            
            }
            
            [self showQiYeView];
            
        } failure:^(NSError *error) {
             [[ProgressHud shareHud] stopLoading];
        }];
    }
   
}



-(void)showQiYeView{

  
    selectMenuType=13;
    
    [CommonMenuView updateMenuItemsWith:self.qiyeArray];
    
    [self popMenu:CGPointMake(CGRectGetMaxX(self.groupTextField.frame)-widthOn(80), CGRectGetMinY(self.groupTextField.frame)+appNavigationBarHeight)];
}
-(void)showGuanlijuView{

    selectMenuType=12;
    
    [CommonMenuView updateMenuItemsWith:self.guanlijuArray];
    
    [self popMenu:CGPointMake(CGRectGetMaxX(self.groupTextField.frame)-widthOn(80), CGRectGetMinY(self.groupTextField.frame)+appNavigationBarHeight)];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
-(void)backKeyBoard{

    
    [self.nameTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    [self.surePassWordField resignFirstResponder];
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
