//
//  FileOperationTask.m
//  FileOperationDownload
//
//  Created by bolin on 2018/3/8.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "FileOperationTask.h"
#import "FileOperationTool.h"
#import "FileInfoItem.h"

// 把一些常用路径, 抽取成一个宏
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmpPath NSTemporaryDirectory()

@interface FileOperationTask () <NSURLSessionDataDelegate>
// 临时文件大小
@property (nonatomic, assign) long long tmpSize;
// 总文件大小
@property (nonatomic, assign) long long totalSize;
// 文件信息
@property (nonatomic, strong) FileInfoItem *fileInfoItem;
/** 下载会话 */
@property (nonatomic, strong) NSURLSession *session;
/** 当前下载任务 */
@property (nonatomic, weak) NSURLSessionDataTask *dataTask;
/** 下载完成路径 */
@property (nonatomic, copy) NSString *downLoadedPath;
/** 下载临时路径 */
@property (nonatomic, copy) NSString *downLoadingPath;
/** 文件输出流 */
@property (nonatomic, strong) NSOutputStream *outputStream;

@end

@implementation FileOperationTask

// 懒加载会话层
- (NSURLSession *)session {
    if (_session == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

#pragma mark 私有方法
- (void)downloadWithURL:(NSURL *)url offset:(long long)offset {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    // 通过控制range, 控制请求资源字节区间
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-", offset] forHTTPHeaderField:@"Range"];
    // session 分配的task, 默认情况, 挂起状态
    self.dataTask = [self.session dataTaskWithRequest:request];
    [self resumeCurrenDownloadTask];
}

// 初始化
- (void)downLoader:(NSURL *)url downloadInfo:(FileDownloadInfoBlock)downloadInfoBlock progress:(FileDownloadProgressBlock)progressBlock state:(FileDownloadStateBlock)stateBlock success:(FileDownloadSuccessBlock)successBlock failed:(FileDownloadFailedBlock)failedBlock {
    
    self.downloadInfoBlock = downloadInfoBlock;
    self.progressBlock = progressBlock;
    self.stateBlock = stateBlock;
    self.successBlock = successBlock;
    self.failedBlock = failedBlock;
    
    FileInfoItem *fileInfoItem = [[FileInfoItem alloc] init];
    self.fileInfoItem = fileInfoItem;
    
    // 开始下载
    [self startDownloadFile:url];
    
}

// 开始下载
- (void)startDownloadFile:(NSURL *)url {
    // 根据URL地址下载资源, 如果任务已经存在, 则执行继续动作
    [self dowloadWithURL:url];
    
    // 当前任务不存，先取消当前任务
    [self cancelCurrenDownloadTask];
    
    // 开始任务执行
    [self downloadTasking:url];
}

#pragma mark 开始下载的业务逻辑
// 根据URL地址下载资源, 如果任务已经存在, 则执行继续动作
- (void)dowloadWithURL:(NSURL *)url {
    // 根据URL地址下载资源, 如果任务已经存在, 则执行继续动作
    if ([url isEqual:self.dataTask.originalRequest.URL]) {
        // 当前状态暂停
        if (self.downloadState == FileDownloadTaskStatusPause) {
            // 继续下载
            [self resumeCurrenDownloadTask];
            return;
        }
    }
}
// 开始任务执行
- (void)downloadTasking:(NSURL *)url {
    
    // 存放路径
    NSString *fileName = url.lastPathComponent;
    self.downLoadedPath = [kCachePath stringByAppendingPathComponent:fileName];
    self.downLoadingPath = [kTmpPath stringByAppendingPathComponent:fileName];
    self.fileInfoItem.fileName = fileName;
    self.fileInfoItem.filePath = self.downLoadedPath;
    // 判断文件是否存在
    if ([FileOperationTool fileIsExist:self.downLoadedPath]) {
        self.downloadState = FileDownloadTaskStatusSuccess;
        return;
    }

    // 临时文件不存在
    if (![FileOperationTool fileIsExist:self.downLoadingPath]) {
        [self downloadWithURL:url offset:0];
        return ;
    }
    
    self.tmpSize = [FileOperationTool fileSize:self.downLoadingPath];
    [self downloadWithURL:url offset:self.tmpSize];
    
}

// 开始任务
- (void)resumeCurrenDownloadTask {
    
    // 有任务并且任务的状态是暂停
    if (self.dataTask && self.downloadState == FileDownloadTaskStatusPause) {
        [self.dataTask resume];
        self.downloadState = FileDownloadTaskStatusLoading;
    }
}

// 暂停任务
- (void)pauseCurrentDownloadTask {
    if (self.downloadState == FileDownloadTaskStatusLoading) {
        self.downloadState = FileDownloadTaskStatusPause;
        [self.dataTask suspend];
    }
    
}

// 取消任务
- (void)cancelCurrenDownloadTask {
    self.downloadState = FileDownloadTaskStatusPause;
    [self.session invalidateAndCancel];
    self.session = nil;
}

// 取消并清理资源
- (void)cancelAndCleanDownloadTask {
    [self cancelCurrenDownloadTask];
    [FileOperationTool fileRemove:self.downLoadingPath];
}
- (void)removeFileWithPath:(NSString *)pathFile {
    [FileOperationTool fileRemove:pathFile];
}

// 开始上传
- (void)startUploadFile:(NSURL *)url {
    
}

// 暂停上传
- (void)pauseUploadFile {
    
}

#pragma mark NSURLSessionDataDelegate
// 第一次接受到相应的时候调用(响应头，并没有具体的资源内容)
// 可以控制，继续请求，还是取消本次请求
- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    self.totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    NSString *contentRange = response.allHeaderFields[@"Content-Range"];
    if (contentRange.length != 0) {
        self.totalSize = [[contentRange componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    self.fileInfoItem.fileSize  = self.totalSize;
    if (self.downloadInfoBlock != nil) {
        self.downloadInfoBlock(self.fileInfoItem);
    }
    
    // 大小判断
    if (self.tmpSize == self.totalSize) {
        [FileOperationTool fileMove:self.downLoadingPath to:self.downLoadedPath];
        completionHandler(NSURLSessionResponseCancel);
        self.downloadState = FileDownloadTaskStatusSuccess;
        return;
    }
    
    if (self.tmpSize > self.totalSize) {
        [FileOperationTool fileRemove:self.downLoadingPath];
        completionHandler(NSURLSessionResponseCancel);
        // 重新下载
        [self downloadTasking:response.URL];
        return;
    }
    
    self.downloadState = FileDownloadTaskStatusLoading;
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.downLoadingPath append:YES];
    [self.outputStream open];
    completionHandler(NSURLSessionResponseAllow);
    
    
}

// 当用户确定，继续接受数据的时候调用
- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nonnull NSData *)data {
    
    self.tmpSize += data.length;
    
    self.progress = 1.0 * self.tmpSize / self.totalSize;
    
    // 写入数据
    [self.outputStream write:data.bytes maxLength:data.length];
}

// 请求完成的时候调用（请求成功/失败）
- (void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    if (error == nil) {
        [FileOperationTool fileMove:self.downLoadingPath to:self.downLoadedPath];
        self.downloadState = FileDownloadTaskStatusSuccess;
    } else {
        if (-999 == error.code) {
            self.downloadState = FileDownloadTaskStatusPause;
        }else {
            self.downloadState = FileDownloadTaskStatusFaild;
        }
    }
    [self.outputStream close];
}

#pragma mark 数据传递
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (self.progressBlock) {
        self.progressBlock(_progress);
    }
}

- (void)setDownloadState:(FileDownloadTaskStatus)downloadState {
    if (_downloadState == downloadState) {
        return;
    }
    _downloadState = downloadState;
    
    if (self.stateBlock) {
        self.stateBlock(downloadState);
    }
    
    if (_downloadState == FileDownloadTaskStatusSuccess && self.successBlock) {
        self.successBlock(self.downLoadedPath);
    }
    
    if (_downloadState == FileDownloadTaskStatusFaild && self.failedBlock) {
        self.failedBlock();
    }
}

@end
