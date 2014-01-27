//
//  FileDetectHelper.h
//  SttirUploader
//
//  Created by A12192 on 1/27/14.
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDetectHelper : NSObject

- (NSMutableArray*)getSpecificExtensionFileByPath:(NSString*)path extensionName:(NSString*)name;

@end
