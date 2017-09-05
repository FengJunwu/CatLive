//
//  MessageCenterViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/13.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "MessageCenterViewController.h"



@interface MessageCenterTableCell : UITableViewCell{
    
    __weak IBOutlet UIImageView *_userImageView;
    
    __weak IBOutlet UILabel *_userNick;
    __weak IBOutlet UILabel *_messageContent;
    
    __weak IBOutlet UILabel *_messageTime;

}

@end
@implementation MessageCenterTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end

@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __weak IBOutlet UITableView *_tableView;
}

@property (nonatomic,strong) NSMutableArray *messageList;
@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [[UIView alloc] init];
    
    NSArray *array = [[CLChatManager manager] getAllConversation];
    
    [self requestMessageList];
}

- (void)requestMessageList{
    /*
     api/msg/getMsgList?fromId={fromId}&userId={userId}&page={page}&pageSize={pageSize}
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"userId"];
    
    [DataService GET:APIMessageUnRead params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        if ([resultDic[@"status"] integerValue] == 0) {
            
        } else {
            //请求出错
            
        }
        
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}




#pragma mark - UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCenterTableCell"];
    return cell;
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

