//
//  Mediator.h
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mediator : NSObject

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
@end
