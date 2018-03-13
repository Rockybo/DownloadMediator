//
//  Mediator+extension.m
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "Mediator+extension.h"

@implementation Mediator (extension)

- (void)downLoader:(NSURL *)url downloadInfo:(FileDownloadInfoBlock)downloadInfoBlock progress:(FileDownloadProgressBlock)progressBlock state:(FileDownloadStateBlock)stateBlock success:(FileDownloadSuccessBlock)successBlock failed:(FileDownloadFailedBlock)failedBlock {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if (url) {
        paramDict[@"url"] = url;
    }
    if (downloadInfoBlock) {
        paramDict[@"infoBlock"] = downloadInfoBlock;
    }
    if (progressBlock) {
        paramDict[@"progressBlock"] = progressBlock;
    }
    if (stateBlock) {
        paramDict[@"stateBlock"] = stateBlock;
    }
    if (successBlock) {
        paramDict[@"successBlock"] = successBlock;
    }
    if (failedBlock) {
        paramDict[@"failedBlock"] = failedBlock;
    }
    [self performTarget:@"FileOperationManager" action:@"downLoader:" params:paramDict shouldCacheTarget:NO];
}

// 暂停下载
- (void)pauseDownloadWithURL:(NSURL *)url {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if (url) {
        paramDict[@"url"] = url;
    }
    [self performTarget:@"FileOperationManager" action:@"pauseDownloadWithURL:" params:paramDict shouldCacheTarget:NO];

}
@end
