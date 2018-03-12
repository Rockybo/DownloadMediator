//
//  Mediator+extension.h
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "Mediator.h"

typedef void (^FileDownloadInfoBlock) (id fileInfoItem);
typedef void (^FileDownloadProgressBlock)(CGFloat progress);
typedef void (^FileDownloadStateBlock) (NSUInteger state);
typedef void (^FileDownloadSuccessBlock) (NSString *filePath);
typedef void (^FileDownloadFailedBlock) (void);


@interface Mediator (extension)

- (void)downLoader:(NSURL *)url downloadInfo:(FileDownloadInfoBlock)downloadInfoBlock progress:(FileDownloadProgressBlock)progressBlock state:(FileDownloadStateBlock)stateBlock success:(FileDownloadSuccessBlock)successBlock failed:(FileDownloadFailedBlock)failedBlock;

// 暂停下载
- (void)pauseDownloadWithURL:(NSURL *)url;
@end
