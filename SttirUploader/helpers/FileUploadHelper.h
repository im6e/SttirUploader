//
//  FileUploadHelper.h
//  SttirUploader
//
//  Created by A12192 on 1/28/14.
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUploadHelper : NSObject

- (void)uploadFileDataByName:(NSString*)fullPath filename:(NSString*)name;

@end
