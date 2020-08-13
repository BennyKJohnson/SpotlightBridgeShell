#import "SPBSShellManager.h"
#import "SPBSAliasParser.h"

@implementation SPBSShellManager

-(instancetype) initWithShell: (NSString*)shell {
    self = [super init];
    if (self) {
        self.shell = shell;
    }
        
    return self;
}

+(NSString *) defaultShell {
    return [[[NSProcessInfo processInfo] environment] objectForKey:@"SHELL"];
}

-(BOOL)programExists: (NSString *)program {
    if ([self.aliases containsObject:program]) {
        return YES;
    }
    
    return [self shellHasProgram: program];
}

-(void)loadAliasesIntoCache {
    self.aliases = [self aliasesFromShell];
}

-(BOOL) shellHasProgram:(NSString*)program {
    NSString *command = [[NSString alloc] initWithFormat:@"type %@", program];
    NSTask *commandTask = [self shellTaskForCommand:command];
          
    [commandTask launch];
    [commandTask waitUntilExit];
      
    return [commandTask terminationStatus] == 0;
}

-(NSArray *) aliasesFromShell {
    NSTask *aliasTask = [self shellTaskForCommand:@"alias"];
    
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *fileHandle = pipe.fileHandleForReading;
    aliasTask.standardOutput = pipe;
    
    [aliasTask launch];
    
    NSData *data = [fileHandle readDataToEndOfFile];
    [fileHandle closeFile];
    
    NSString *aliasOutput = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return [SPBSAliasParser parseAliasesFromString:aliasOutput];
}

-(NSTask*)shellTaskForCommand: (NSString*)command {
    NSTask *commandTask = [[NSTask alloc] init];
    
    // Use provided shell to perform command as NSTask does not pull in environment variables from the user's profiles
    commandTask.launchPath = self.shell;
    
    // -l tells bash to act like a login shell
    // -c executes the command
    commandTask.arguments = @[@"-l", @"-c", command];
    
    return commandTask;
}

@end
