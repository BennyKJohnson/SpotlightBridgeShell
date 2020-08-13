#import <XCTest/XCTest.h>
#import "SPBSShellManager.h"

@interface SPBSShellManagerTests : XCTestCase

@end

@implementation SPBSShellManagerTests

-(void) testInitWithShell {
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:@"/bin/bash"];
    
    XCTAssertNotNil(manager);
    XCTAssertTrue([manager.shell isEqualToString:@"/bin/bash"]);
}

- (void)testProgramExists {
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:@"/bin/bash"];
    XCTAssertTrue([manager programExists:@"which"]);
    XCTAssertTrue([manager programExists:@"ls"]);
    XCTAssertTrue([manager programExists:@"cat"]);
    
    XCTAssertFalse([manager programExists:@"fakespotlightbridgeprogram"]);
}

-(void)testProgramExistsWithAlias {
    SPBSShellManager *manager = [[SPBSShellManager alloc] initWithShell:@"/bin/bash"];
    manager.aliases = @[@"mountmac"];
    
    XCTAssertTrue([manager programExists: @"mountmac"]);
    XCTAssertFalse([manager programExists: @"unavailablealias"]);

}

@end
