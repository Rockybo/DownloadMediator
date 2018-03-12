//
//  Mediator.m
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "Mediator.h"

@interface Mediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget; // 缓存target

@end

static Mediator *instance;

@implementation Mediator

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

+ (id)sharedInstance {
    return [[self alloc] init];
}

#pragma mark 私有方法
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget {
    
    Class targetClass;
    // 先从缓存中获取
    NSObject *target = self.cachedTarget[targetName];
    if (target == nil) {
        targetClass = NSClassFromString(targetName);
        target = [[targetClass alloc] init];
    }
    
    SEL action = NSSelectorFromString(actionName);
    
    // 是否缓存targe
    if (shouldCacheTarget) {
        self.cachedTarget[targetName] = target;
    }
    
    // 判断方法
    if ([target respondsToSelector:action]) {
        return [target performSelector:action withObject:params];
    }
    return nil;

}

#pragma mark set/get
- (NSMutableDictionary *)cachedTarget {
    if(_cachedTarget == nil) {
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    return _cachedTarget;
}
@end
