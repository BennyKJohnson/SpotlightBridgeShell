#import "SPBSAliasParser.h"

@implementation SPBSAliasParser

+(NSArray *) parseAliasesFromString: (NSString *)aliasesResponse {
    NSArray *aliasResults = [aliasesResponse componentsSeparatedByCharactersInSet:NSCharacterSet.newlineCharacterSet];
    NSMutableArray *aliases = [NSMutableArray array];
    for (NSString *aliasResult in aliasResults) {
        NSString *alias = [self parseAliasFromString:aliasResult];
        if (alias) {
            [aliases addObject:alias];
        }
    }
    
    return [aliases copy];
}

+(NSString*) parseAliasFromString: (NSString*)rawAlias {
    NSString *aliasPrefix = @"alias ";
    if (![rawAlias hasPrefix:aliasPrefix]) {
        return NULL;
    }

    NSString *aliasComponentString = [rawAlias substringFromIndex:[aliasPrefix length]];
    NSArray *aliasComponents = [aliasComponentString componentsSeparatedByString:@"="];
    if ([aliasComponents count] < 2) {
        return NULL;
    }
    
    return aliasComponents[0];
}

@end
