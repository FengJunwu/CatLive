//
//  Common.h
//  CatLive
//
//  Created by 平凡 on 17/8/12.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject




+ (Common *)getInstance;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;//16进制RGB

- (NSString *)getCacheSize;

@end
