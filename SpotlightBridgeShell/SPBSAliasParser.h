#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBSAliasParser : NSObject

+(NSArray *) parseAliasesFromString: (NSString *)aliasesResponse;

+(NSString*) parseAliasFromString: (NSString*)rawAlias;

@end

NS_ASSUME_NONNULL_END
