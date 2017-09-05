//
//  MainTabBarViewController.m
//  iStarLive
//
//  Created by 平凡 on 16/10/26.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigationController.h"
@interface MainTabBarViewController ()<UITabBarControllerDelegate>{


}

@end

@implementation MainTabBarViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    for (int i = 0 ; i < self.tabBar.items.count; i++) {
        UITabBarItem *item =  self.tabBar.items[i];
//        item.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
        if (i == 1) {
            item.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);

        } else {
            item.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);

        }
    }

    
    
    self.delegate = self;
    

}


#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (viewController == self.viewControllers[1]) {
        [NoticeView showWithMsg:@"该功能暂未开放"];
        return NO;

    }
    return YES;


}


//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    [XMChatManager manager].tabBarSelectIndex = self.selectedIndex;
//    if (self.selectedIndex == 1) {
//        [self showDiscoverBadgeImgview:NO];
//    }
//    if (self.selectedIndex == 2) {
//        [self showMessageBadgeImgview:NO];
//    }
//}
//


@end




