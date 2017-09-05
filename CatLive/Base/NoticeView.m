//
//  NoticeView.m
//  iStarLive
//
//  Created by 李亚浩 on 2016/11/24.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "NoticeView.h"


static BOOL isNoticeing;
@interface NoticeView (){
}
- (instancetype)initWithMsg:(NSString *)msg;
@end

@implementation NoticeView
- (instancetype)initWithMsg:(NSString *)msg{
    int labelWidth = kScreenWidth - 200;
    CGRect rect = [msg boundingRectWithSize:CGSizeMake(labelWidth, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
//    CGSize size = [msg sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
//    int width = (int)rect.size.width;
    int labelHeight = rect.size.height + 4;
    self = [super initWithFrame:CGRectMake(80, (kScreenHeight - labelHeight - 4) / 2, kScreenWidth - 160, labelHeight + 8)];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, kScreenWidth - 200, labelHeight)];
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = msg;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];
        self.backgroundColor = RGBA(0, 0, 0, 0.8);
        self.layer.cornerRadius = (labelHeight + 8) / 2;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}




+ (void)showWithMsg:(NSString *)msg{
    if (msg.length == 0) {
        return;
    }
    if (!isNoticeing) {
        isNoticeing = YES;
        NoticeView *notice = [[NoticeView alloc] initWithMsg:msg];
        [notice show];
    }
}



- (void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:2];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        isNoticeing = NO;
    }];
}



@end

