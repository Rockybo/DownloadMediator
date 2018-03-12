//
//  FileOperationManager.m
//  FileOperationDownload
//
//  Created by bolin on 2018/3/8.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "FileOperationManager.h"
#import "FileOperationTask.h"
#import "NSString+string.h"

static FileOperationManager *intance;

@interface FileOperationManager ()

@property (nonatomic, strong) NSMutableDictionary *downLoadInfo;

@end

@implementation FileOperationManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (intance == nil) {
            intance = [super allocWithZone:zone];
        }
    });
    return intance;
}

+ (instancetype)sharedIntance {
    return [[self alloc] init];
}

- (NSMutableDictionary *)downLoadInfo {
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}
- (void)downLoader:(NSURL *)url downloadInfo:(FileDownloadInfoBlock)downloadInfoBlock progress:(FileDownloadProgressBlock)progressBlock state:(FileDownloadStateBlock)stateBlock success:(FileDownloadSuccessBlock)successBlock failed:(FileDownloadFailedBlock)failedBlock {
 
    NSString *urlMD5 = [url.absoluteString md5];
    
    FileOperationTask *downLoader = self.downLoadInfo[urlMD5];
    if (downLoader == nil) {
        downLoader = [[FileOperationTask alloc] init];
        self.downLoadInfo[urlMD5] = downLoader;
    }
    
    __weak typeof(self) weakSelf = self;
    [downLoader downLoader:url downloadInfo:downloadInfoBlock progress:progressBlock state:stateBlock success:^(NSString *filePath) {
        [weakSelf.downLoadInfo removeObjectForKey:urlMD5];
        // 拦截block
        successBlock(filePath);
        
    } failed:failedBlock];
    
}

// 开始下载
- (void)resumeDownloadWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    FileOperationTask *downLoader = self.downLoadInfo[urlMD5];
    [downLoader resumeCurrenDownloadTask];
}

// 暂停下载
- (void)pauseDownloadWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    FileOperationTask *downLoader = self.downLoadInfo[urlMD5];
    [downLoader pauseCurrentDownloadTask];
}

// 取消下载
- (void)cancelDownloadWithURL:(NSURL *)url {
    
}

// 暂停全部
- (void)pauseAllDownload {
    
}

// 开始全部
- (void)resumeAllDownload {
    
}

// 开始上传
- (void)startUploadWithURL:(NSURL *)url {
    
}

// 暂停上传
- (void)pauseUploadWithURL:(NSURL *)url {
    
}

@end
