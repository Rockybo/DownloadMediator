//
//  Mediator.m
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "Mediator.h"

@implementation Mediator

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget {
    Class targetClass;
    NSObject *target;
    if (targetName != nil) {
        targetClass = NSClassFromString(targetName);
        target = [[targetClass alloc] init];
    }
    SEL action = NSSelectorFromString(actionName);
    
    if ([target respondsToSelector:action]) {
        
    }
    return nil;

}
@end
