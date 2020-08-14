//
//  SPBSTestShell.m
//  SpotlightBridgeShellTests
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import "SPBSTestShell.h"

@implementation SPBSTestShell

-(NSArray*)fetchCommands {
    return self.commands;
}

- (NSArray *)fetchAliases {
    return self.aliases;
}

@end
