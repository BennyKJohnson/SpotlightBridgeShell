#import "SPBSShellQuery.h"
#import "SPBSCommand.h"
#import "SPBSSearchResult.h"
#import "SPBSShellManager.h"

@implementation SPBSShellQuery

static SPBSShellManager *shellManager;

+(void)initialize {
    [super initialize];
    
    shellManager = [[SPBSShellManager alloc] initWithShell:[SPBSShellManager defaultShell]];
    [shellManager loadAliasesIntoCache];
    [shellManager loadProgramsIntoCache];
}

-(void) performQuery:(NSString *)userQueryString withCompletionHandler:(void (^)(SPBResponse *response))completionHandler {
    SPBSCommand *command = [[SPBSCommand alloc] initWithUserQuery: userQueryString];
    
    if (!command) {
        completionHandler(NULL);
    }
    
    if(!shellManager) {
        completionHandler(NULL);
    }
    
    NSArray *matches = [shellManager matchesForProgram:command.program];
    if ([matches count]) {
       completionHandler([self createResponseForCommand:command matches:matches]);
    } else {
       completionHandler(NULL);
    }
}

-(SPBResponse*) createResponseForCommand:(SPBSCommand *)comannd matches: (NSArray*)matches  {
    SPBResultSection *resultSection = [[SPBResultSection alloc] initWithTitle: @"Terminal"];
    
    // Ensures rankSectionsUsingBundleIDToSectionMapping parses section correctly to appear as top hit
    // More understanding about why sections with unknown bundle identifiers are thrown out is required
    // TODO Fix hardcoded spotlight bundle identifier
    resultSection.bundleIdentifier = @"com.apple.calculator";

    NSMutableArray *searchResults = [NSMutableArray array];
    for (NSString *match in matches) {
        SPBSSearchResult *searchResult = [[SPBSSearchResult alloc] initWithDisplayName:match];
        searchResult.isTopHit = [comannd.program isEqualTo: match];
        [searchResults addObject:searchResult];
    }

    resultSection.results = searchResults;

    SPBResponse *response = [[SPBResponse alloc] init];
    response.topHitIsIn = YES;
    response.sections = @[resultSection];
    
    return response;
}

@end
