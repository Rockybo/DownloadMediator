#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FileInfoItem.h"
#import "FileOperationManager.h"
#import "FileOperationTask.h"
#import "FileOperationTool.h"
#import "NSString+string.h"

FOUNDATION_EXPORT double DownloadLibVersionNumber;
FOUNDATION_EXPORT const unsigned char DownloadLibVersionString[];

