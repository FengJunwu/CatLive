//
//  DataService.h
//  iStarLive
//
//  Created by 平凡 on 16/10/26.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
typedef  void(^Progress)(NSProgress *process);
typedef  void(^FinshBlock)(NSURLSessionDataTask *operation, id result);
typedef  void(^FailuerBlock)(NSURLSessionDataTask *operation,NSError *error);

@interface DataService : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)url params:(NSMutableDictionary *)params process:(Progress)process finishBlock:(FinshBlock)finishBlock FailuerBlock:(FailuerBlock)failuerBlock;

+ (NSURLSessionDataTask *)POST:(NSString *)url params:(NSMutableDictionary *)params process:(Progress)process finishBlock:(FinshBlock)finishBlock FailuerBlock:(FailuerBlock)failuerBlock;




@end
