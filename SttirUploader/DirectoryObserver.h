//
//  DirectoryObserver.h
//  SttirUploader
//
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import <Foundation/Foundation.h>

#define projectUploadUrl = @""


@protocol DirectoryObserverDelegate <NSObject>
- (void)onDirectoryChanged:(id)sender directories:(NSArray *)directories;
@end

@interface DirectoryObserver : NSObject
- (id)initWithDirectoryPath:(NSString *)path;

- (void)startObserving;
- (void)stopObserving;

@property (weak, nonatomic) id<DirectoryObserverDelegate> delegate;
@end
