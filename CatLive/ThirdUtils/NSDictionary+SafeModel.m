//
//  NSDictionary+SafeModel.m
//  FilmSpread
//
//  Created by 吴启凡 on 16/3/17.
//  Copyright © 2016年 For. All rights reserved.
//

#import "NSDictionary+SafeModel.h"

@implementation NSDictionary (SafeModel)

- (id)safeObjectForKey:(id)aKey {
    
    id unsafe = [self objectForKey:aKey];
    
    if ([unsafe isEqual:[NSNull null]]) {
        return nil;
    }
    return unsafe;
}


- (NSNumber *)safeNumberForKey:(id)aKey {
    return [self safeObjectForKey:aKey];
}


- (NSInteger)safeIntegerForKey:(id)aKey {
    return [[self safeObjectForKey:aKey] integerValue];
}

- (int)safeIntForkey:(id)aKey{
    return [[self safeObjectForKey:aKey] intValue];
}

- (BOOL)safeBoolForKey:(id)aKey {
    
    return [[self safeObjectForKey:aKey] boolValue];
}

- (long long)safeLonglongForKey:(id)akey{
    return [[self safeObjectForKey:akey] longLongValue];
}


- (NSString *)safeStringForKey:(id)aKey {
    NSString *resultString = [self safeObjectForKey:aKey];
    if (resultString) {
        return resultString;
    }
    return @"";
}

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data {
    
    CFPropertyListRef list = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)data, kCFPropertyListImmutable, NULL);
    
    if(list == nil) return nil;
    
    if ([(__bridge id)list isKindOfClass:[NSDictionary class]]) {
        
        return (__bridge NSDictionary *)list;
        
    }
    else {
        
        CFRelease(list);
        
        return nil;
        
    }
}

@end
