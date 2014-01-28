//
//  DirectoryObserver.m
//  SttirUploader
//
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import <CoreServices/CoreServices.h>
#import "ProjectUploader.h"
#import "DirectoryObserver.h"

@interface DirectoryObserver()
- (void)onDirectoryChanged:(NSArray *)directories;
@end

@implementation DirectoryObserver
{
    NSString *_path;
    FSEventStreamRef _stream;
    ;
}

- (id)initWithDirectoryPath:(NSString *)path
{
    if(self = [super init])
    {
        _path = path;
    }
    return self;
}

- (void)startObserving
{
    if(_stream) return;
    
    FSEventStreamContext context = {0};
    context.info = (__bridge void *)self;
    CFTimeInterval latency = 0.1;
    _stream = FSEventStreamCreate(kCFAllocatorDefault,
                                  fs_event_callback,
                                  &context,
                                  (__bridge CFArrayRef)@[_path],
                                  kFSEventStreamEventIdSinceNow,
                                  latency,
                                  kFSEventStreamCreateFlagNone);

    FSEventStreamScheduleWithRunLoop(_stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    FSEventStreamStart(_stream);

    NSLog(@"### start observing directory - %@", _path);
}

- (void)stopObserving
{
    if(_stream == NULL) return;

    FSEventStreamStop(_stream);
    FSEventStreamUnscheduleFromRunLoop(_stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    FSEventStreamRelease(_stream);
    _stream = NULL;

    NSLog(@"### stop observing directory - %@", _path);
}

- (void)onDirectoryChanged:(NSArray *)directories
{
    if(self.delegate) {
        [self.delegate onDirectoryChanged:self directories:directories];
    }
}

void fs_event_callback(ConstFSEventStreamRef streamRef, void *clientCallBackInfo, size_t numEvents,
                       void *eventPaths, const FSEventStreamEventFlags eventFlags[], const FSEventStreamEventId eventIds[])
{
    char **paths = eventPaths;
    NSMutableArray *directories = [NSMutableArray array];

    ProjectUploader *_projectUploader = [[ProjectUploader alloc]init];

    for (int i = 0 ; i < numEvents ; i++) {
        NSString *strPath = [NSString stringWithCString:paths[i] encoding:NSUTF8StringEncoding];
        [_projectUploader callUploadAPI:strPath];
        [directories addObject:strPath];
    }

    DirectoryObserver *observer = (__bridge DirectoryObserver *)clientCallBackInfo;
    [observer onDirectoryChanged:directories];
}

@end
