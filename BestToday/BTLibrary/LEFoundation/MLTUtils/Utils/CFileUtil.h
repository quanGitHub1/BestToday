//
//  CFileUtil.h
//  CCommon
//
//  Created by yi_mark on 14/11/28.
//  Copyright (c) 2014年 yi_mark. All rights reserved.
//
/**
 *  工具类_File

    手动保存的文件在documents文件里
    Nsuserdefaults保存的文件在tmp文件夹里
 */


#import <Foundation/Foundation.h>

///工具类_File
@interface CFileUtil : NSObject {
    
}


/**************************************************
 *  通用类方法
 **************************************************/
///获取document路径
+ (NSString *)getIOSDocumentPath;

///获取tmp路径
+ (NSString *)getIOSTmpPath;

///获取Caches路径
+ (NSString *)getIOSCachesPath;



/**************************************************
 *  具体类方法
 **************************************************/
///获取"xxxxx.bundle"资源文件路径
+(NSString *)getPathOfBundleName:(NSString *)pBundle;

/// 获取"xxxxx.bundle/xxxxx.xml"文件路径
+ (NSString *)getPathOfBundleXML:(NSString *)pName;

///获取"xxxxx.bundle/yyyyy.xml"文件路径
+ (NSString *)getPathOfBundleName:(NSString *)pBundle OfXmlName:(NSString *)pXml;



/**************************************************
 *  循环遍历获取制定文件夹下的文件
 **************************************************/
///遍历某文件下面的"pSuffix"后缀的所有文件
+ (NSArray *)getFilesAtPath:(NSString *)pFolderPath OfFileSuffix:(NSString *)pSuffix;

///遍历某文件下面的"pSuffix"后缀的所有文件(绝对路径)
+ (NSArray *)getFilesPathAtPath:(NSString *)pFolderPath OfFileSuffix:(NSString *)pSuffix;



/**************************************************
 *  获取文件/文件夹大小
 **************************************************/
///单个文件的大小
+ (long long)getFileSizeAtPath:(NSString*)pFilePath;

///遍历文件夹获得文件夹大小，返回多少b
+ (long long)getFolderSizeAtPath:(NSString*)pFolderPath;



/**************************************************
 *  删除文件/文件夹
 **************************************************/
///删除文件
+ (BOOL)deleteFileAtPath:(NSString *)pFilePath;

///删除文件夹（每次执行删除，都返回被删除的文件大小）
+ (void)deleteFolderFileSizeAtPath:(NSString*)pFolderPath;

@end