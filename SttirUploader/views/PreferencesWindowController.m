//
//  PreferencesWindowController.m
//  SttirUploader
//
//  Created by A12192 on 1/29/14.
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "PreferenceWindow.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController {
    IBOutlet PreferenceWindow *prefWindow;
    // IBOutlet NSWindow *prefWindow;
}


- (id)init {
    if (self = [super init]) {
//        prefWindow = [[PreferenceWindow alloc] init];
//        [self setWindow:prefWindow];
        self = [super initWithWindowNibName:@"PreferenceWindow"];
        NSLog(@"window: %@", self.window);
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
