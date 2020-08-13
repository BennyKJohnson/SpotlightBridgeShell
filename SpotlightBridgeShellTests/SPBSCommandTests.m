#import <XCTest/XCTest.h>
#import "SPBSCommand.h"

@interface SPBSCommandTests : XCTestCase

@end

@implementation SPBSCommandTests

-(void)testInitWithUserQueryWithNoArguments {
    SPBSCommand *query = [[SPBSCommand alloc] initWithUserQuery:@"cat"];
    
    XCTAssertTrue([query.program isEqualToString:@"cat"]);
    XCTAssertEqual([query.arguments count], 0);
}

- (void)testInitWithUserQueryWithAnArgument {
    SPBSCommand *query = [[SPBSCommand alloc] initWithUserQuery:@"ls /usr/bin/"];
    
    XCTAssertTrue([query.program isEqualToString:@"ls"]);
    XCTAssertEqual([query.arguments count], 1);
    XCTAssertTrue([query.arguments[0] isEqualToString:@"/usr/bin/"]);
}

-(void)testInitWithUserQueryWithMultipleArguments {
    SPBSCommand *query = [[SPBSCommand alloc] initWithUserQuery:@"sudo shutdown -h now"];
    
    NSArray *expectedArguments = @[@"shutdown", @"-h", @"now"];
    
    XCTAssertTrue([query.program isEqualToString:@"sudo"]);
    XCTAssertTrue([query.arguments isEqualToArray:expectedArguments]);
}

-(void)testInitWithUserQueryWithEmptyString {
    SPBSCommand *query = [[SPBSCommand alloc] initWithUserQuery:@""];
    XCTAssertNil(query);
}


@end
