//
//  AttentionViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/16.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "AttentionViewController.h"

@interface AttentionTableViewCell : UITableViewCell{

    __weak IBOutlet UIImageView *_userImage;
    
    __weak IBOutlet UILabel *_userNickLabel;
    
    __weak IBOutlet UILabel *_userLocation;
    
    __weak IBOutlet UIButton *_attentionBtn;
    
    __weak IBOutlet UIView *_locationView;
    
    __weak IBOutlet UILabel *_fansValueLabel;
    
    

}

@end
@implementation AttentionTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    _attentionBtn.layer.masksToBounds = YES;
    _attentionBtn.layer.cornerRadius = 15.0;
    _attentionBtn.layer.borderWidth = 1.0;
    
    
//    //未关注状态
//    _attentionBtn.selected = NO;
//    _attentionBtn.backgroundColor = [UIColor whiteColor];
//    _attentionBtn.layer.borderColor = [Common colorWithHexString:@"#646464C" alpha:1.0].CGColor;
    
//    //关注状态
//    _attentionBtn.selected = YES;
//    _attentionBtn.backgroundColor = [Common colorWithHexString:@"#D6D7DC" alpha:1.0];
//    _attentionBtn.layer.borderColor = [Common colorWithHexString:@"#D6D7DC" alpha:1.0].CGColor;


    
    
    
}


- (IBAction)attetntionAction:(UIButton *)sender {
}

@end



@interface AttentionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __weak IBOutlet UITableView *_tableView;

    NSMutableArray *_dataArr;
}

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.tableFooterView = [[UIView alloc] init];
    [self requestData];
    
    
}

- (void)requestData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"20" forKey:@"pageSize"];
    [params setObject:@([LoginManager manager].userInfo.userId) forKey:@"userId"];

    
    [DataService GET:APIUserAttention params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        if ([resultDic[@"status"] integerValue] == 0) {
            
        } else {
            //请求出错
            
        }
        
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionTableViewCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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



