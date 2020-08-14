//
//  SearchTree.m
//  SpotlightBridgeShell
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import "SPBSearchIndex.h"

@implementation SPBSearchIndex

-(instancetype)init {
    self = [super init];
    if (self) {
        self.items = [NSArray array];
    }
    
    return self;
}

-(void)addItems:(NSArray* )newItems {
    self.items = [[self.items arrayByAddingObjectsFromArray:newItems] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

-(BOOL)containsItem: (NSString *)item {
    return [self.items containsObject: item];
}

-(NSArray*)getMatchesForStringValue: (NSString *)value {
    NSMutableArray *matches = [NSMutableArray array];
    
    NSUInteger startPosition = [self bisectLeft: self.items value: value];
    for (NSUInteger index = startPosition; index < [self.items count]; index++) {
        NSString *item = self.items[index];
        
        if ([item hasPrefix: value]) {
            [matches addObject: item];
        } else {
            break;
        }
    }
    
    return matches;
}

-(NSUInteger)bisectLeft: (NSArray *)array value: (NSString *)value {
    return [self bisectLeftOfArray: array value: value min: 0 max: [array count]];
}

-(NSUInteger)bisectLeftOfArray:(NSArray *)array value:(NSString *)value min:(NSUInteger)min max:(NSUInteger)max {
    if (min >= max)
        return min;
    
    NSUInteger mid = min + (max - min) / 2;
    
    NSString *midElement = array[mid];
    if ([midElement compare:value] == NSOrderedAscending) {
        return [self bisectLeftOfArray:array value:value min:mid + 1  max:max];
    } else {
        return [self bisectLeftOfArray:array value:value min:min max:mid];
    }
}



@end
