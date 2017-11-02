//
//  CFileUtil.m
//  CCommon
//
//  Created by yi_mark on 14/11/28.
//  Copyright (c) 2014年 yi_mark. All rights reserved.
//


#import "CFileUtil.h"


@interface CFileUtil()

@end


@implementation CFileUtil

/**************************************************
 *  通用类方法
 **************************************************/
///获取document路径
+ (NSString *)getIOSDocumentPath {
    NSArray *tPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tPath = [tPaths objectAtIndex:0];
    return tPath;
}

///获取tmp路径
+ (NSString *)getIOSTmpPath {
    NSString *tPath = NSTemporaryDirectory();
    return tPath;
}

///获取Caches路径
+ (NSString *)getIOSCachesPath {
    NSArray *tPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *tPath = [tPaths objectAtIndex:0];
    return tPath;
}



/**************************************************
 *  具体类方法
 **************************************************/
///获取"xxxxx.bundle"资源文件路径
+(NSString *)getPathOfBundleName:(NSString *)pBundle {
    NSString *tPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", pBundle]];
    return tPath;
}

///获取"xxxxx.bundle/xxxxx.xml"文件路径
+ (NSString *)getPathOfBundleXML:(NSString *)pName {
    NSString *tPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle/%@.xml", pName,pName]];
    return tPath;
}

///获取"xxxxx.bundle/yyyyy.xml"文件路径
+ (NSString *)getPathOfBundleName:(NSString *)pBundle OfXmlName:(NSString *)pXml {
    NSString *tPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle/%@.xml", pBundle,pXml]];
    return tPath;
}



/**************************************************
 *  循环遍历获取制定文件夹下的文件
 **************************************************/
///遍历某文件下面的"pSuffix"后缀的所有文件
+ (NSArray *)getFilesAtPath:(NSString *)pFolderPath OfFileSuffix:(NSString *)pSuffix {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:pFolderPath]) {
        return nil;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:pFolderPath] objectEnumerator];
    NSString *tFileName;
    
    NSMutableArray *tFiles = [[NSMutableArray alloc] init];
    while ((tFileName = [childFilesEnumerator nextObject])){
        if ([[tFileName pathExtension] isEqualToString:pSuffix]) {
            [tFiles addObject:tFileName];
        }
    }
    return tFiles;
}

///遍历某文件下面的"pSuffix"后缀的所有文件(绝对路径)
+ (NSArray *)getFilesPathAtPath:(NSString *)pFolderPath OfFileSuffix:(NSString *)pSuffix {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:pFolderPath]) {
        return nil;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:pFolderPath] objectEnumerator];
    NSString *tFileName;
    
    NSMutableArray *tFilesPath = [[NSMutableArray alloc] init];
    while ((tFileName = [childFilesEnumerator nextObject])){
        if ([[tFileName pathExtension] isEqualToString:pSuffix]) {
            NSString *fileAbsolutePath = [pFolderPath stringByAppendingPathComponent:tFileName];
            [tFilesPath addObject:fileAbsolutePath];
        }
    }
    return tFilesPath;
}


/**************************************************
 *  获取文件/文件夹大小
 **************************************************/
///计算单个文件的大小
+ (long long)getFileSizeAtPath:(NSString*)pFilePath {
    NSFileManager *tManager = [NSFileManager defaultManager];
    if ([tManager fileExistsAtPath:pFilePath]){
        return [[tManager attributesOfItemAtPath:pFilePath error:nil] fileSize];
    }
    return 0;
}

///遍历文件夹获得文件夹大小，返回多少b(大小单位)
+ (long long)getFolderSizeAtPath:(NSString*)pFolderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:pFolderPath]) {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:pFolderPath] objectEnumerator];
    NSString *tFileName;
    
    long long folderSize = 0;
    
    while ((tFileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [pFolderPath stringByAppendingPathComponent:tFileName];
        folderSize += [CFileUtil getFileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize;
}



/**************************************************
 *  删除文件/文件夹
 **************************************************/
///删除文件
+ (BOOL)deleteFileAtPath:(NSString *)pFilePath {
    NSFileManager *tManager = [NSFileManager defaultManager];
    if ([tManager fileExistsAtPath:pFilePath]){
        NSError *tError;
        BOOL tDeleted = [tManager removeItemAtPath:pFilePath error:&tError];
        if (!tDeleted) {
            NSLog(@"删除文件失败(%@)", tError);
        }
        return tDeleted;
    }
    return NO;
}

///删除文件夹（每次执行删除，都返回被删除的文件大小）
+ (void)deleteFolderFileSizeAtPath:(NSString*)pFolderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:pFolderPath]) {
        return;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:pFolderPath] objectEnumerator];
    NSString *tFileName;
    
    while ((tFileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [pFolderPath stringByAppendingPathComponent:tFileName];
        [CFileUtil deleteFileAtPath:fileAbsolutePath];
    }
}

@end