//
//  ProjectUploader.h
//  SttirUploader
//
//  Created by 天野 勝太 on 2014/01/15.
//  Copyright (c) 2014年 Sttir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectUploader : NSOrderedSet
- (void)callUploadAPI:(NSString *)path;

@end
