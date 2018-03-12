//
//  Mediator+extension.m
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "Mediator+extension.h"

@implementation Mediator (extension)

- (void)resumeDownloadWithURL:(NSURL *)url {
    NSDictionary *param = @{@"url":url};
    [self performTarget:@"FileOperationManager" action:@"resumeDownloadWithURL:" params:param shouldCacheTarget:NO];
}
@end
