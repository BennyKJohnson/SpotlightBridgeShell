//
//  SPBSShell.h
//  SpotlightBridgeShell
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBSShell : NSObject

-(BOOL)hasProgram: (NSString*)program;

-(NSArray*)fetchCommands;

-(NSArray*)fetchAliases;

-(NSTask*)taskForCommand: (NSString*)command;

@property (nonatomic, strong) NSString *shellPath;

-(instancetype)initWithPath: (NSString *)path;

@end

NS_ASSUME_NONNULL_END
