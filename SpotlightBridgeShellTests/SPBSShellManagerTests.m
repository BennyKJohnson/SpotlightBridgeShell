#import <XCTest/XCTest.h>
#import "SPBSShellManager.h"
#import "SPBSTestShell.h"

@interface SPBSShellManagerTests : XCTestCase

@end

@implementation SPBSShellManagerTests

-(void) testInitWithShell {
    SPBSTestShell *testShell = [[SPBSTestShell alloc]initWithPath:@"/bin/bash"];
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:testShell];

    XCTAssertNotNil(manager);
    XCTAssertEqual(manager.shell, testShell);
}

-(void)testLoadProgramsIntoCache {
    SPBSTestShell *testShell = [[SPBSTestShell alloc]initWithPath:@"/bin/bash"];
    testShell.commands = @[@"ls", @"cat"];
    
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:testShell];
    [manager loadProgramsIntoCache];
    
    XCTAssertNotNil(manager.searchIndex);
    
    NSArray *subsetOfExpectedPrograms = @[
        @"ls",
        @"cat",
    ];
    
    for (NSString *expectedProgram in subsetOfExpectedPrograms) {
        XCTAssertTrue([manager.searchIndex containsItem: expectedProgram]);
    }
}

-(void)testLoadAliasesIntoCache {
    SPBSTestShell *testShell = [[SPBSTestShell alloc]initWithPath:@"/bin/bash"];
    testShell.aliases = @[@"mountmac", @"myalias"];
    
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:testShell];
    [manager loadAliasesIntoCache];
    
    NSArray *expectedAliases = @[
        @"mountmac",
        @"myalias",
    ];
    
    for (NSString *expectedAlias in expectedAliases) {
        XCTAssertTrue([manager.searchIndex containsItem: expectedAlias]);
    }
}

-(void)testMatchesForProgram {
    SPBSTestShell *testShell = [[SPBSTestShell alloc]initWithPath:@"/bin/bash"];
    testShell.commands = @[@"lsm",@"ls", @"cat"];
    testShell.aliases = @[@"myalias"];
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:testShell];
    [manager loadProgramsIntoCache];
    [manager loadAliasesIntoCache];
    
    NSArray *matches = [manager matchesForProgram:@"ls"];
    NSArray *expectedMatches = @[@"ls", @"lsm"];
    XCTAssertTrue([matches isEqualToArray:expectedMatches]);
    
    matches = [manager matchesForProgram:@"my"];
    expectedMatches = @[@"myalias"];
    XCTAssertTrue([matches isEqualToArray:expectedMatches]);
    
    matches = [manager matchesForProgram:@"unknown"];
    XCTAssertTrue([matches isEqualToArray:@[]]);
}

@end
