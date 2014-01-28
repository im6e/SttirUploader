//
//  ProjectUploader.m
//  SttirUploader
//
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "ProjectUploader.h"
#import "helpers/FileDetectHelper.h"
#import "helpers/FileUploadHelper.h"

@interface ProjectUploader()

@end

@implementation ProjectUploader

// TODO: 適切な拡張子に変更
NSString * const kExtensionName = @"jpg";

- (void)callUploadAPI:(NSString *)path
{
    FileDetectHelper *detector = [[FileDetectHelper alloc] init];
    FileUploadHelper *uploader = [[FileUploadHelper alloc] init];

    // -------------------- finding file name -------------------
    NSArray *fileList = [detector getSpecificExtensionFileByPath:path extensionName:kExtensionName];
    for (NSString *file in fileList) {
        // upload a file
        [uploader uploadFileDataByName:file filename:file];
    }
    // -------------------- finding file name -------------------
}

@end
