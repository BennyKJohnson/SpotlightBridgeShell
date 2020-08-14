//
//  SPBSShell.m
//  SpotlightBridgeShell
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import "SPBSShell.h"
#import "SPBSAliasParser.h"

@implementation SPBSShell

-(instancetype)initWithPath: (NSString *)path {
    self = [super init];
    if (self) {
        self.shellPath = path;
    }
    
    return self;
}

-(BOOL)hasProgram: (NSString*)program {
    NSString *command = [[NSString alloc] initWithFormat:@"type %@", program];
    NSTask *commandTask = [self taskForCommand:command];
          
    [commandTask launch];
    [commandTask waitUntilExit];
      
    return [commandTask terminationStatus] == 0;
}

-(NSArray*)fetchCommands {
    NSTask *commandTask = [self taskForCommand:@"compgen -c"];

   NSPipe *pipe = [NSPipe pipe];
   NSFileHandle *fileHandle = pipe.fileHandleForReading;
   commandTask.standardOutput = pipe;

   [commandTask launch];

   NSData *data = [fileHandle readDataToEndOfFile];
   [fileHandle closeFile];

   NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   NSArray *commands = [output componentsSeparatedByCharactersInSet:NSCharacterSet.newlineCharacterSet];
   return commands;
}

-(NSArray*)fetchAliases {
    NSTask *aliasTask = [self taskForCommand:@"alias"];

   NSPipe *pipe = [NSPipe pipe];
   NSFileHandle *fileHandle = pipe.fileHandleForReading;
   aliasTask.standardOutput = pipe;

   [aliasTask launch];

   NSData *data = [fileHandle readDataToEndOfFile];
   [fileHandle closeFile];

   NSString *aliasOutput = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

   return [SPBSAliasParser parseAliasesFromString:aliasOutput];
}

-(NSTask*)taskForCommand: (NSString*)command {
    NSTask *commandTask = [[NSTask alloc] init];
    
    // Use provided shell to perform command as NSTask does not pull in environment variables from the user's profiles
    commandTask.launchPath = self.shellPath;
    
    // -l tells bash to act like a login shell
    // -c executes the command
    commandTask.arguments = @[@"-l", @"-c", command];
    
    return commandTask;
}

@end
