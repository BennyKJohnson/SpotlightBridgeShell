//
//  SearchTree.m
//  SpotlightBridgeShellTests
//
//  Created by Benjamin Johnson on 14/8/20.
//  Copyright © 2020 Benjamin Johnson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPBSearchIndex.h"

@interface SPBSearchIndexTests : XCTestCase

@end

@implementation SPBSearchIndexTests

-(void)testBisectLeft {
    NSArray *fruits = @[@"apple", @"banana", @"oranges", @"peach"];
    SPBSearchIndex *searchIndex = [[SPBSearchIndex alloc]init];
    
    NSUInteger index = [searchIndex bisectLeft:fruits value:@"grapes"];
    XCTAssertEqual(index, 2);
}

-(void)testGetMatchesForStringValue {
    NSArray *shoppingList = @[@"app", @"apples", @"oranges"];
    SPBSearchIndex *searchIndex = [[SPBSearchIndex alloc] init];
    searchIndex.items = shoppingList;
    
    NSArray *matches = [searchIndex getMatchesForStringValue:@"app"];
    NSArray *expectedMatches = @[@"app", @"apples"];
    
    XCTAssertTrue([matches isEqualToArray:expectedMatches]);
    
    matches = [searchIndex getMatchesForStringValue:@"oranges"];
    XCTAssertTrue([matches isEqualToArray:@[@"oranges"]]);
    
    matches = [searchIndex getMatchesForStringValue:@"orangess"];
    XCTAssertTrue([matches isEqualToArray:@[]]);
}


@end
