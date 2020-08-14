#import "SPBSSearchResult.h"

@implementation SPBSSearchResult

-(NSImage *)iconImage {
    return [[NSWorkspace sharedWorkspace] iconForFile:@"/System/Applications/Utilities/Terminal.app"];
}

- (BOOL)openWithSearchString:(NSString *)searchString {
    NSString *sourceScript = [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"%@\"", searchString];
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:sourceScript];
    [appleScript executeAndReturnError:nil];
    
    return YES;
}

@end
