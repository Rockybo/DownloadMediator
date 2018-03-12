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
    NSDictionary *param = @{
                           @"url":url,
                           @"infoBlock":downloadInfoBlock,
                           @"progressBlock":progressBlock,
                           @"stateBlock":stateBlock,
                           @"successBlock":successBlock,
                           @"failedBlock":failedBlock
                           };
    [self performTarget:@"FileOperationManager" action:@"downLoader:" params:param shouldCacheTarget:NO];
}

// 暂停下载
- (void)pauseDownloadWithURL:(NSURL *)url {
    NSDictionary *param = @{
                            @"url":url
                            };
    [self performTarget:@"FileOperationManager" action:@"pauseDownloadWithURL:" params:param shouldCacheTarget:NO];

}
@end
