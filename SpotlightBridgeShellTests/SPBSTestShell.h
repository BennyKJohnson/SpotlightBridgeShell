//
//  SPBSTestShell.h
//  SpotlightBridgeShellTests
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import "SPBSShell.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBSTestShell : SPBSShell

@property (nonatomic, strong) NSArray *aliases;

@property (nonatomic, strong) NSArray *commands;


@end

NS_ASSUME_NONNULL_END
