#import <XCTest/XCTest.h>
#import "SPBSAliasParser.h"

@interface SPBSAliasParserTests : XCTestCase

@end

@implementation SPBSAliasParserTests

-(void)testParseAliasesFromString {
    NSString *aliasResponse = @"alias lsalias='ls'\nalias mountmac='sshfs mac'";
    NSArray *aliases = [SPBSAliasParser parseAliasesFromString:aliasResponse];
    NSArray *expectedAliases = @[@"lsalias", @"mountmac"];
    XCTAssertTrue([aliases isEqualToArray:expectedAliases]);
}

-(void)testParseAliasFromString {
    NSString *alias = [SPBSAliasParser parseAliasFromString:@"alias lsalias='ls'"];
    
    XCTAssertTrue([alias isEqualToString:@"lsalias"]);
}

@end
