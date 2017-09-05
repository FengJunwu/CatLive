//
//  HomeViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/12.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "HomeViewController.h"
#import <SDCycleScrollView.h>
#import "UserInfoViewController.h"
#import "AnchorInfo.h"
#import "MessageCenterViewController.h"
#import <EaseUI.h>

@interface CallCollectionViewCell : UICollectionViewCell{

    __weak IBOutlet UIImageView *_userIcon;
    __weak IBOutlet UILabel *_userNick;

    __weak IBOutlet UILabel *_userLocation;
    __weak IBOutlet NSLayoutConstraint *_userLocationWidth;
}
@property (nonatomic,strong) AnchorInfo *model;


@end
@implementation CallCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
}

//修改用户位置信息宽度
- (void)setModel:(AnchorInfo *)model{
    if (_model != model) {
        _model = model;
        [_userIcon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[UIImage imageNamed:@"userHeaderPlace"]];
        
        _userNick.text = _model.nickname;
        _userLocation.text = _model.province.length == 0? @"火星":_model.province;
        _userLocationWidth.constant = [_userLocation sizeThatFits:CGSizeMake(50, 21)].width;
    }
}

@end






@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>{
    
    __weak IBOutlet UIView *_adScrollView;
    
    __weak IBOutlet UICollectionView *_callCollectionView;
    UIBarButtonItem *_rightItem;
    NSMutableArray *_callUserArray;

}

@end

@implementation HomeViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"一对一";
    
EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
    
    
    [self initRightBarButtonItem];
    
    [self requestHotList];
    
    [LoginManager manager].homeVC = self;
    [CLChatManager manager].homeVC = self;
    [CLCallManager manager].homeVC = self;
    [[LoginManager manager] autoLogIn];//自动登录，会检测当前是否已登录

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userReceivedNewMessage:) name:NOTIReceivedNewMessage object:nil];
    
//    LogInViewController *logINvC = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
//    [self presentViewController:logINvC animated:YES completion:^{
//        
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
}

- (void)userReceivedNewMessage:(NSNotification *)noti {
    _rightItem.image = [UIImage imageNamed:@"messageCenterSel"];
}

- (void)initRightBarButtonItem{
    
    _rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"messageCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(enterMessageCenter:)];
    self.navigationItem.rightBarButtonItem = _rightItem;

}
- (void)enterMessageCenter:(UIBarButtonItem *)item{
    item.image = [UIImage imageNamed:@"messageCenter"];
    MessageCenterViewController *messageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageCenterViewController"];
    [self.navigationController pushViewController:messageVC animated:YES];
}


- (void)requestHotList{
    //请求视频通话的用户
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"20" forKey:@"pageSize"];

    
    [DataService GET:APIPopularPage params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        if ([resultDic[@"status"] integerValue] == 0) {
            if (!_callUserArray) {
                _callUserArray = [NSMutableArray array];
            }
            
            for (NSDictionary *dic in resultDic[@"data"][@"Items"]) {
                AnchorInfo *anchor = [[AnchorInfo alloc] initWithDictionary:dic];
                [_callUserArray addObject:anchor];
            }
            
            [_callCollectionView reloadData];
            
        } else {
        //请求出错
            
        }
        
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}








#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _callUserArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _callUserArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CallCollectionViewCell" forIndexPath:indexPath];
    cell.model = _callUserArray[indexPath.row];
    return cell;

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil ;
    
    if (kind == UICollectionElementKindSectionHeader ){
        
       UICollectionReusableView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        reusableview = header;
        
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 4) / 2.0, (kScreenWidth - 4) / 2.0 + 35 );
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//跳转用户主页
    UserInfoViewController *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
    userInfoVC.anchor = _callUserArray[indexPath.row];
    [self.navigationController pushViewController:userInfoVC animated:YES];
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



