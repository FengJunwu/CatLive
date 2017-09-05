//
//  DataService.m
//  iStarLive
//
//  Created by 平凡 on 16/10/26.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "DataService.h"

@implementation DataService


+ (NSURLSessionDataTask *)GET:(NSString *)url params:(NSMutableDictionary *)params process:(Progress)process finishBlock:(FinshBlock)finishBlock FailuerBlock:(FailuerBlock)failuerBlock{
    
    //创建请求的管理对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manger GET:[NSString stringWithFormat:@"%@%@",URL_DOMAIN,url]  parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (process) {
            process(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (finishBlock) {
            //请求成功执行Block块内容
            finishBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failuerBlock) {
            //请求失败
            failuerBlock(task,error);
            [NoticeView showWithMsg:NSLocalizedString(@"网络错误", nil)];
        }
    }];
    return task;
}


+ (NSURLSessionDataTask *)POST:(NSString *)url params:(NSMutableDictionary *)params process:(Progress)process finishBlock:(FinshBlock)finishBlock FailuerBlock:(FailuerBlock)failuerBlock{
    
    //创建请求的管理对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = nil;
    task = [manger POST:[NSString stringWithFormat:@"%@%@",URL_DOMAIN,url] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (process) {
            process(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (finishBlock) {
            //请求成功执行Block块内容
            finishBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failuerBlock) {
            //请求失败
            failuerBlock(task,error);
            [NoticeView showWithMsg:NSLocalizedString(@"网络错误", nil)];

        }
    }];
    return task;
}



@end


