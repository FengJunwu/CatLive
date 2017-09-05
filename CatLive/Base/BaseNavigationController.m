//
//  BaseNavigationController.m
//  iStarLive
//
//  Created by 平凡 on 16/10/26.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>{
    
}

@end

@implementation BaseNavigationController


- (void)viewDidLoad{
    [super viewDidLoad];
//    self.delegate = self;
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0]};
    [UINavigationBar appearance].barTintColor = CommonColor;
    
    
    
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"navBackImg"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navBackImg"]];

}

//#pragma mark-UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (navigationController.viewControllers.count > 1) {
//        [navigationController.tabBarController.tabBar setHidden:YES] ;
//    } else {
//        navigationController.tabBarController.tabBar.hidden = NO;
//
//    }
//}
@end

