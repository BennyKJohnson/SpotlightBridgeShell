//
//  SearchTree.h
//  SpotlightBridgeShell
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBSearchIndex : NSObject

-(void)addItems:(NSArray* )newItems;

@property (strong, nonatomic) NSArray *items;

-(NSArray*)getMatchesForStringValue: (NSString *)value;

-(NSUInteger)bisectLeft: (NSArray *)array value: (NSString *)value;

-(BOOL)containsItem: (NSString *)item;

@end

NS_ASSUME_NONNULL_END
