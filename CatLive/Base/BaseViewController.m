//
//  BaseViewController.m
//  iStarLive
//
//  Created by 平凡 on 16/10/26.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
{
    UIScreenEdgePanGestureRecognizer *_screenEdgePan;
    UIView                           *_vipView;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
}

//-  (void) initBackBtn{
//
//    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBackImg"]
//                                                                          style:UIBarButtonItemStylePlain
//                                                                         target:self
//                                                                         action:@selector(backAction:) ];
//    leftBarButtomItem.tintColor = [UIColor blueColor];
//    self.navigationItem.leftBarButtonItem = leftBarButtomItem;
//    
//}
//
//- (void)showVIPNorticeView{
//    
//    if ([Common getInstance].userUseType == 2 && [LoginManager manager].userInfo.joinFlag != 1) {
//        
//        if (!_vipView) {
//            _vipView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-20-49,kScreenWidth , 20)];
//            _vipView .backgroundColor = [Common colorWithHexString:@"FFFBBD" alpha:0.5];
//            [self.view addSubview:_vipView];
//            UILabel *lab = [[UILabel alloc] init];
//            lab.text = @"游客模式";
//            lab.textColor = [Common colorWithHexString:@"FF6174" alpha:1.0];
//            lab.font = [UIFont systemFontOfSize:12];
//            [lab sizeToFit];
//            [_vipView addSubview:lab];
//            lab.centerX = kScreenWidth/2.0;
//            lab.centerY = _vipView.height/2.0;
//        }
//        else{
//            
//            [self.view bringSubviewToFront:_vipView];
//        }
//        
//        
//        
//    }
//}
//
//- (void)hiddenVIPView{
//    
//    
//    if (_vipView) {
//        [_vipView removeFromSuperview];
//        _vipView = nil;
//    }
//    
//}
//
//
//- (void)showEntranceView{
//    
//    if (![Common getInstance].hasRequestDebugVersion) {
//        return;
//    }
//    
//    if ([LoginManager manager].userInfo.joinFlag == 1) {
//        return;
//    }
//    
//    if([Common getInstance].userUseType == 2 || [Common getInstance].userUseType == 1){
//        
//        return;//
//        
//    }
//    
//    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_INFO];
//    if (dic != nil && ![LoginManager manager].isLogin){
//        
//        return;
//    }
//    [self noJudgeShowEntranceView];
//    
//}
//
////无判断条件直接显示入场券
//- (void)noJudgeShowEntranceView{
//    
//    if(_entranceView == nil){
//        _entranceView = [[NSBundle mainBundle] loadNibNamed:@"XMHomeEntranceView" owner:nil options:nil][0];
//        _entranceView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//        _entranceView.center = self.view.center;
//        _entranceView.delegate = self;
//        _entranceView.alpha    = 0.5;
//        [MobClick event:@"entranceNum"];
//        
//    }
//    
//    if (![LoginManager manager].isLogin) {
//        _entranceView.type = 1;
//    }
//    else if ([LoginManager manager].isLogin && [Common getInstance].isAuditing){
//        
//        _entranceView.type = 2;
//        
//    }
//    else{
//        _entranceView.type = 3;
//    }
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:_entranceView];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        _entranceView.alpha    = 1.0;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    for (UIView *view in [[UIApplication sharedApplication].keyWindow  subviews]) {
//        if ([view isKindOfClass:[XMHomeEntranceView class]]) {
//            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:view];
//            break;
//        }
//    }
//}
//
//- (void)removeEntranceView{
//    
//    if (_entranceView) {
//        [_entranceView removeFromSuperview];
//        _entranceView = nil;
//        [[NSNotificationCenter defaultCenter] postNotificationName:APP_HIDDENENTRANCEVIEW object:nil];
//    }
//}
//
//-(void)backAction:(id)sender{
//    
//    if (self.navigationController.viewControllers.count>1) {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}


@end
