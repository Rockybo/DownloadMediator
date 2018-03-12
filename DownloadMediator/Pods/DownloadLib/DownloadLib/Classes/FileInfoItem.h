//
//  FileInfoItem.h
//  FileOperationDownload
//
//  Created by bolin on 2018/3/9.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileInfoItem : NSObject
// 文件名称
@property (nonatomic, copy) NSString *fileName;
// 文件路径
@property (nonatomic, copy) NSString *filePath;
// 文件下载中的路径
@property (nonatomic, copy) NSString *fileDownloadingPath;
// 文件大小
@property (nonatomic, assign) long long fileSize;
@end
