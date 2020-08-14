#import "SPBSShellManager.h"
#import "SPBSAliasParser.h"

@implementation SPBSShellManager

-(instancetype) initWithShell: (SPBSShell*)shell {
    self = [super init];
    if (self) {
        self.shell = shell;
        self.searchIndex = [[SPBSearchIndex alloc] init];
    }
        
    return self;
}

+(SPBSShell *)defaultShell {
    NSString *shellPath = [[[NSProcessInfo processInfo] environment] objectForKey:@"SHELL"];
    return [[SPBSShell alloc]initWithPath:shellPath];
}

-(NSArray*)matchesForProgram: (NSString*)program {
    return [self.searchIndex getMatchesForStringValue:program];
}

-(void)loadAliasesIntoCache {
    [self.searchIndex addItems: [self.shell fetchAliases]];
}

-(void)loadProgramsIntoCache {
    [self.searchIndex addItems:[self.shell fetchCommands]];
}

@end
