//
//  SttirMenu.m
//  SttirUploader
//
//  Created by A12192 on 1/29/14.
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "SttirMenu.h"
#import "PreferencesWindowController.h"

@implementation SttirMenu {
    NSMenuItem *_quit;
    NSMenuItem *_preferences;

    IBOutlet NSWindow *prefWindow;
}


- (id)init {
    self = [super init];
    if (self) {
        // initialize
        _quit = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
        _preferences = [[NSMenuItem alloc] initWithTitle:@"Preferences..." action:@selector(pushedPreferences:) keyEquivalent:@""];
        [_preferences setTarget:self];
        [self addItem:_preferences];
        [self addItem:_quit];
    }
    return self;
}

- (void)pushedPreferences:(id)item {
    NSLog(@"item: %@", item);
    PreferencesWindowController *prefeWindow = [[PreferencesWindowController alloc] init];
    [prefeWindow showWindow:nil];
    [[prefeWindow window] makeMainWindow];
}

@end
