//
//  LoginViewController.m
//  RainStationApp
//
//  Created by vp on 2017/5/9.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "LoginViewController.h"
#import "NetWorkManager.h"
#import "RegisterViewController.h"
#import "JPUSHService.h"
#import "QYQurstionListController.h"
#import "QYItemController.h"
#import "MainViewController.h"
@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.setPopGestureRecognizerOn=YES;

    
    
    
    [self addAllViews];
    
    
    [self initMainTitleBar:@"登录"];
    self.backBtn.hidden=YES;
    self.menubtn.hidden=YES;
    self.baseLineView.hidden=YES;
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyBoard)];
    [self.backScroller addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

-(void)backKeyBoard{

    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

-(void)addAllViews{
    
    
    
    
    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.backgroundColor=[UIColor whiteColor];
    self.backScroller.delegate=self;
    [self.view addSubview:self.backScroller];
    self.backScroller.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
    
    
    CGFloat textfieldY=appNavigationBarHeight;
    
    self.nameTextField=[self creatLogintextFieldViewWithIcon:@"手机号码" placehoder:@"请输入手机号码" frameY:textfieldY];
    self.nameTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.passwordTextField=[self creatLogintextFieldViewWithIcon:@"密码" placehoder:@"请输入密码" frameY:textfieldY+widthOn(100)];
    self.passwordTextField.secureTextEntry = YES;
    
    self.nameTextField.delegate=self;
    self.passwordTextField.delegate=self;

    NSString  *telStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
    NSString  *passwordStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

    if (telStr) {
        self.nameTextField.text=telStr;
    }
    if (passwordStr) {
        self.passwordTextField.text=passwordStr;
    }
    
    
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont boldSystemFontOfSize:widthOn(36)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor=appMainColor;
    
    [self.backScroller addSubview:loginBtn];
    loginBtn.sd_layout.widthIs(widthOn(400)).centerXEqualToView(self.backScroller).topSpaceToView(self.passwordTextField, widthOn(100)).heightIs(widthOn(80));
    loginBtn.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(40)];
    
    
    UIButton *registerBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [registerBtn setTitle:@"没有账号立即注册?" forState:UIControlStateNormal];
    [registerBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:widthOn(32)];
    [self.backScroller addSubview:registerBtn];
    registerBtn.sd_layout.topSpaceToView(loginBtn, 5).widthRatioToView(loginBtn, 1).centerXEqualToView(loginBtn).heightRatioToView(loginBtn, 1);
    
    
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn addTarget:self action:@selector(regisBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(UITextField *)creatLogintextFieldViewWithIcon:(NSString *)titleStr placehoder:(NSString *)hoder frameY:( CGFloat )floatY{

    
    
    
    

    UITextField *textField=[[UITextField alloc] init];
    textField.placeholder=hoder;
    textField.font=[UIFont systemFontOfSize:widthOn(34)];
    [self.backScroller addSubview:textField];
    textField.sd_layout.leftSpaceToView(self.backScroller, widthOn(30)).topSpaceToView(self.backScroller, floatY).rightSpaceToView(self.backScroller, widthOn(30)).heightIs(widthOn(80));
    
    textField.leftViewMode=UITextFieldViewModeAlways;
    UILabel *leftLabel=[[UILabel alloc] init];
    leftLabel.frame=CGRectMake(0, 0, widthOn(180), widthOn(80));
    leftLabel.text=titleStr;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=ColorWithAlpha(0x999999, 1);
    textField.leftView=leftLabel;
    
    
    UIView *view=[[UIView alloc] init];
    
    view.backgroundColor=appLineColor;

    [textField addSubview:view];
    view.sd_layout.leftSpaceToView(textField, 0).bottomSpaceToView(textField, 0).widthRatioToView(textField, 1).heightIs(1);

    
    return textField;
    
    
    
}

-(void)loginAction{

    [self backKeyBoard];
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写账号"];
        return;
    }
    
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写密码"];
        return;
    }
    
    if (self.nameTextField.text) {
        [self testPushViewControllerWithText:self.nameTextField.text];
        return;
    }
    
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    
    
    NSMutableDictionary *BodyDic=[NSMutableDictionary dictionary];
    [BodyDic setValue:self.nameTextField.text forKey:@"loginName"];
    [BodyDic setValue:self.passwordTextField.text forKey:@"loginPwd"];

    
    NSLog(@"传的登录参数：%@",BodyDic);
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Get_Login" parameters:BodyDic success:^(id response) {
        [[ProgressHud shareHud] stopLoading];
        NSLog(@"登录返回值%@",response);
        NSString *returnStr=response[@"State"][@"text"];
        if ([returnStr isEqualToString:@"0"]) {
//            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"登录成功"];
            [[NSUserDefaults standardUserDefaults] setObject:self.nameTextField.text forKey:@"tel"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [JPUSHService setAlias:self.nameTextField.text callbackSelector:nil object:nil];
            
            
            [[NetWorkManager sharedInstance] setUserInfoMessageWithDic:response];
            
            if ([NetWorkManager sharedInstance].powerStatus==QYUser) {
//                QYItemController *qv=[[QYItemController alloc] init];
                QYQurstionListController *qv=[[QYQurstionListController alloc] init];
                [self.navigationController pushViewController:qv animated:YES];
            }else{
                [self performSegueWithIdentifier:@"pushToMain" sender:self];
            }

            
           
            
        }else if ([returnStr isEqualToString:@"2"]){
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"登录失败，账号名或密码错误"];
        }else{
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"登录失败，未知错误，请联系管理员"];
        }
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"登录失败，请检查网络后重试"];
    }];
    

    
}

-(void)testPushViewControllerWithText:(NSString *)str{
    [[NSUserDefaults standardUserDefaults] setObject:self.nameTextField.text forKey:@"tel"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([str isEqualToString:@"1"]) {
        [NetWorkManager sharedInstance].powerStatus=Boss;
        [self performSegueWithIdentifier:@"pushToMain" sender:self];
    }else if ([str isEqualToString:@"2"]){
        [NetWorkManager sharedInstance].powerStatus=Administrator;
        MainViewController *qv=[[MainViewController alloc] init];
       
        [self.navigationController pushViewController:qv animated:YES];
    }else if ([str isEqualToString:@"3"]){
        [NetWorkManager sharedInstance].powerStatus=QYAdmin;
        QYItemController *qv=[[QYItemController alloc] init];
        [self.navigationController pushViewController:qv animated:YES];
    }else if ([str isEqualToString:@"4"]){
        [NetWorkManager sharedInstance].powerStatus=QYUser;
        QYQurstionListController *qv=[[QYQurstionListController alloc] init];
        [self.navigationController pushViewController:qv animated:YES];
    }
}

-(void)regisBtnAction{

    RegisterViewController *vc=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
