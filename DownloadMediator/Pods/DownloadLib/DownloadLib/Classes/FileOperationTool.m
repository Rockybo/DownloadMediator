//
//  FileOperationTool.m
//  FileOperationDownload
//
//  Created by bolin on 2018/3/8.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "FileOperationTool.h"

@implementation FileOperationTool

// 文件是否存在
+ (BOOL)fileIsExist:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}
// 删除文件
+ (void)fileRemove:(NSString *)filePath {
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
// 文件大小
+ (long long)fileSize:(NSString *)filePath {
    if ([self fileIsExist:filePath]) {
        NSDictionary *info = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        return [info[NSFileSize] longLongValue];
    }
    return 0;
}
// 移动文件
+ (void)fileMove:(NSString *)formPath to:(NSString *)toPath {
    if (![self fileSize:formPath]) {
        return;
    }
    [[NSFileManager defaultManager] moveItemAtPath:formPath toPath:toPath error:nil];
}

@end
