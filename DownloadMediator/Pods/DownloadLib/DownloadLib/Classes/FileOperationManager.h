//
//  FileOperationManager.h
//  FileOperationDownload
//
//  Created by bolin on 2018/3/8.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileOperationTask.h"

@interface FileOperationManager : NSObject

+ (instancetype)sharedIntance;

- (void)downLoader:(NSURL *)url downloadInfo:(FileDownloadInfoBlock)downloadInfoBlock progress:(FileDownloadProgressBlock)progressBlock state:(FileDownloadStateBlock)stateBlock success:(FileDownloadSuccessBlock)successBlock failed:(FileDownloadFailedBlock)failedBlock;

// 开始下载
- (void)resumeDownloadWithURL:(NSURL *)url;
// 暂停下载
- (void)pauseDownloadWithURL:(NSURL *)url;
// 取消下载
- (void)cancelDownloadWithURL:(NSURL *)url;
// 暂停全部
- (void)pauseAllDownload;
// 开始全部
- (void)resumeAllDownload;
// 开始上传
- (void)startUploadWithURL:(NSURL *)url;

// 暂停上传
- (void)pauseUploadWithURL:(NSURL *)url;

@end
