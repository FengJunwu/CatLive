//
//  NSDictionary+SafeModel.h
//  FilmSpread
//
//  Created by 吴启凡 on 16/3/17.
//  Copyright © 2016年 For. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeModel)

- (id)safeObjectForKey:(id)aKey;

- (NSNumber *)safeNumberForKey:(id)aKey;

- (NSInteger)safeIntegerForKey:(id)aKey;

- (BOOL)safeBoolForKey:(id)aKey;

- (NSString *)safeStringForKey:(id)aKey;

- (long long)safeLonglongForKey:(id)akey;

- (int)safeIntForkey:(id)aKey;

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data;


@end
