//
//  ChangePasswordController.m
//  NDRCApp
//
//  Created by vp on 2017/5/23.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "ChangePasswordController.h"
#import "NetWorkManager.h"
@interface ChangePasswordController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UITextField *surePasswordTextField;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"修改密码"];
    self.menubtn.hidden=YES;
    
    
    CGFloat leftSpace=widthOn(34);
    
    UILabel *leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthOn(12), widthOn(80))];
    leftLabel.backgroundColor=[UIColor clearColor];
    
    
    self.passwordTextField=[[UITextField alloc] init];
    self.passwordTextField.font=[UIFont systemFontOfSize:widthOn(34)];
    self.passwordTextField.placeholder=@"输入新密码";
    self.passwordTextField.layer.borderColor=appLineColor.CGColor;
    self.passwordTextField.layer.borderWidth=1;
    self.passwordTextField.layer.cornerRadius=widthOn(12);
    self.passwordTextField.leftViewMode=UITextFieldViewModeAlways;
    self.passwordTextField.leftView=leftLabel;
    self.passwordTextField.delegate=self;
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.sd_layout.leftSpaceToView(self.view, leftSpace).topSpaceToView(self.view, appNavigationBarHeight+leftSpace).rightSpaceToView(self.view, leftSpace).heightIs(widthOn(80));
    
    
    UILabel *sureleftLabel=[[UILabel alloc] initWithFrame:leftLabel.frame];
    sureleftLabel.backgroundColor=[UIColor clearColor];
    
    self.surePasswordTextField=[[UITextField alloc] init];
    self.surePasswordTextField.font=self.passwordTextField.font;
    self.surePasswordTextField.placeholder=@"确认新密码";
    self.surePasswordTextField.layer.borderColor=appLineColor.CGColor;
    self.surePasswordTextField.layer.borderWidth=1;
    self.surePasswordTextField.layer.cornerRadius=self.passwordTextField.layer.cornerRadius;
    self.surePasswordTextField.leftViewMode=UITextFieldViewModeAlways;
    self.surePasswordTextField.leftView=sureleftLabel;
    self.surePasswordTextField.delegate=self;
    [self.view addSubview:self.surePasswordTextField];
    self.surePasswordTextField.sd_layout.leftEqualToView(self.passwordTextField).rightEqualToView(self.passwordTextField).topSpaceToView(self.passwordTextField, leftSpace).heightRatioToView(self.passwordTextField, 1);
    
    self.passwordTextField.secureTextEntry = YES;
    self.surePasswordTextField.secureTextEntry = YES;
    
    
    UIButton *sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font=[UIFont systemFontOfSize:widthOn(36)];
    sendBtn.layer.cornerRadius=widthOn(12);
    [sendBtn setBackgroundColor:appMainColor];
    [sendBtn addTarget:self action:@selector(sendPassworsAcrion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    sendBtn.sd_layout.centerXEqualToView(self.passwordTextField).topSpaceToView(self.surePasswordTextField, widthOn(90)).heightIs(widthOn(90)).widthIs(widthOn(500));
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}


-(void)sendPassworsAcrion{

    [self backKeyBoard];
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"清填写密码"];
        return;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.surePasswordTextField.text]) {
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"两次输入的密码不一致"];
        return;
    }
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSString  *telStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
    NSString  *passwordStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    [dic setValue:telStr forKey:@"loginName"];
    [dic setValue:passwordStr forKey:@"OldPwd"];
    [dic setValue:self.passwordTextField.text forKey:@"NewPwd"];
    
    
    NSLog(@"+++++%@",dic);
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Update_Password" parameters:dic success:^(id response) {
        NSLog(@"返回%@",response);
        [[ProgressHud shareHud] stopLoading];
        if ([response[@"State"][@"text"] isEqualToString:@"0"]) {
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"修改成功"];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
       
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"修改失败"];
            
        }
        
        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
    }];

    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
-(void)backKeyBoard{

    [self.passwordTextField resignFirstResponder];
    [self.surePasswordTextField resignFirstResponder];
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
