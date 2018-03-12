//
//  Mediator.h
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mediator : NSObject

+ (id)sharedInstance;

// 本地调用
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
@end
