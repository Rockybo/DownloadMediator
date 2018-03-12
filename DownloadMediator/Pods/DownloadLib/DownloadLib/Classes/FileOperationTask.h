//
//  FileOperationTask.h
//  FileOperationDownload
//
//  Created by bolin on 2018/3/8.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FileInfoItem;

typedef NS_ENUM(NSUInteger, FileDownloadTaskStatus) {
    FileDownloadTaskStatusPause,
    FileDownloadTaskStatusLoading,
    FileDownloadTaskStatusSuccess,
    FileDownloadTaskStatusFaild,
};

typedef NS_ENUM(NSUInteger, FileOperationTaskUploadStatus) {
    FileOperationTaskUploadStatusPause,
    FileOperationTaskUploadStatusStart,
};


// 文件下载成功block
typedef void (^FileDownloadSuccessBlock) (NSString *filePath);
// 文件下载失败block
typedef void (^FileDownloadFailedBlock) (void);
// 文件下载信息
typedef void (^FileDownloadInfoBlock) (FileInfoItem *fileInfoItem);
// 文件下载进度
typedef void (^FileDownloadProgressBlock)(CGFloat progress);
// 文件下载状态
typedef void (^FileDownloadStateBlock) (FileDownloadTaskStatus state);


@interface FileOperationTask : NSObject

// 文件下载状态
@property (nonatomic, assign) FileDownloadTaskStatus downloadState;
// 文件下载进度
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, copy) FileDownloadSuccessBlock successBlock;
@property (nonatomic, copy) FileDownloadFailedBlock failedBlock;
@property (nonatomic, copy) FileDownloadInfoBlock downloadInfoBlock;
@property (nonatomic, copy) FileDownloadProgressBlock progressBlock;
@property (nonatomic, copy) FileDownloadStateBlock stateBlock;

// 初始化
- (void)downLoader:(NSURL *)url downloadInfo:(FileDownloadInfoBlock)downloadInfoBlock progress:(FileDownloadProgressBlock)progressBlock state:(FileDownloadStateBlock)stateBlock success:(FileDownloadSuccessBlock)successBlock failed:(FileDownloadFailedBlock)failedBlock;

// 开始下载
- (void)startDownloadFile:(NSURL *)url;
// 开始任务
- (void)resumeCurrenDownloadTask;
// 暂停任务
- (void)pauseCurrentDownloadTask;
// 取消任务
- (void)cancelCurrenDownloadTask;
// 取消并清理资源
- (void)cancelAndCleanDownloadTask;
// 开始上传
- (void)startUploadFile:(NSURL *)url;
// 暂停上传
- (void)pauseUploadFile;

@end
