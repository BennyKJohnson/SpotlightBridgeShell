#import "SPBSSearchResult.h"

@implementation SPBSSearchResult

-(NSImage *)iconImage {
    return [[NSWorkspace sharedWorkspace] iconForFile:@"/System/Applications/Utilities/Terminal.app"];
}

-(instancetype) initWithCommand: (SPBSCommand*)command {
    self = [super initWithDisplayName:command.program];
    if (self) {
        self.command = command;
    }
    
    return self;
}

- (BOOL)openWithSearchString:(NSString *)searchString {
    NSString *sourceScript = [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"%@\"", searchString];
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:sourceScript];
    [appleScript executeAndReturnError:nil];
    
    return YES;
}

-(BOOL)isTopHit {
    return YES;
}

@end
