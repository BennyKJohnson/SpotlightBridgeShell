#import <Foundation/Foundation.h>
#import "SPBSearchIndex.h"
#import "SPBSShell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPBSShellManager : NSObject

+(SPBSShell *) defaultShell;

-(instancetype) initWithShell: (SPBSShell*)shell;

@property (nonatomic, strong) SPBSShell *shell;

@property (nonatomic, strong) SPBSearchIndex *searchIndex;

-(void)loadAliasesIntoCache;

-(void)loadProgramsIntoCache;

-(NSArray*) matchesForProgram: (NSString*)program;

@end

NS_ASSUME_NONNULL_END
