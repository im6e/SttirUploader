//
//  FileDetectHelper.m
//  SttirUploader
//
//  Created by A12192 on 1/27/14.
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "FileDetectHelper.h"

@implementation FileDetectHelper

- (id)init {
    self = [super init];
    if (self) {
        // initialize
    }
    return self;
}

#pragma mark -publc methods
- (NSMutableArray*)getSpecificExtensionFileByPath:(NSString*)path extensionName:(NSString*)name {
    NSMutableArray *fileList = [[NSMutableArray alloc] init];
    NSError *error;
    NSArray *allFileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    for (NSString *fileName in allFileList) {
        if ([fileName hasSuffix:name]) {
            [fileList addObject:fileName];
        }
    }
    return fileList;
}


#pragma mark -private methods

@end
