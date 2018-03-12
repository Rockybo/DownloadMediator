//
//  FileOperationTool.h
//  FileOperationDownload
//
//  Created by bolin on 2018/3/8.
//  Copyright © 2018年 bolin. All rights reserved.
//  文件操作的工具类

#import <Foundation/Foundation.h>

@interface FileOperationTool : NSObject

// 文件是否存在
+ (BOOL)fileIsExist:(NSString *)filePath;
// 删除文件
+ (void)fileRemove:(NSString *)filePath;
// 文件大小
+ (long long)fileSize:(NSString *)filePath;
// 移动文件
+ (void)fileMove:(NSString *)formPath to:(NSString *)toPath;

@end
