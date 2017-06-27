//
//  QYEvaluateListController.m
//  NDRCApp
//
//  Created by vp on 2017/6/27.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYEvaluateListController.h"
#import "QuestionListCell.h"
#import "QuestionMessageController.h"
@interface QYEvaluateListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation QYEvaluateListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"待评价问题"];
    self.menubtn.hidden=YES;
    self.tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QuestionListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[QuestionListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    //    QuestionListModel *model=self.dataArray[indexPath.row];
    //    if (self.tempArray.count!=0) {
    //
    //        model=self.tempArray[indexPath.row];
    //    }
    //
    //    cell.qyNameLabel.text=model.QYName;
    //    cell.questionTypeLabel.text=model.state;
    //    cell.qyContactLabel.text=model.TJRName;
    //    cell.timeLabel.text=model.submitTime;
    //    if ([model.state isEqualToString:@"2"]) {
    //        cell.questionTypeLabel.textColor=ColorWithAlpha(0x3183fd, 1);
    //        cell.questionTypeLabel.text=@"已驳回";
    //    }else if ([model.state isEqualToString:@"1"]) {
    //        cell.questionTypeLabel.textColor=ColorWithAlpha(0x999999, 1);
    //        cell.questionTypeLabel.text=@"已处理";
    //    }else{
    //        cell.questionTypeLabel.textColor=[UIColor redColor];
    //        cell.questionTypeLabel.text=@"未处理";
    //    }
    
    
    cell.qyNameLabel.text=@"沈阳沈阳";
    cell.questionTypeLabel.text=@"已处理";
    cell.qyContactLabel.text=@"李明子";
    cell.timeLabel.text=@"2017.05.16 20:20:20";
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuestionMessageController *mv=[[QuestionMessageController alloc] init];
    
    
    [self.navigationController pushViewController:mv animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return widthOn(170);
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
