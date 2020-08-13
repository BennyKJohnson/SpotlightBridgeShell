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
}

-(void) performQuery:(NSString *)userQueryString withCompletionHandler:(void (^)(SPBResponse *response))completionHandler {
    completionHandler([self queryResponseForUserQueryString:userQueryString]);
}

-(SPBResponse *) queryResponseForUserQueryString: (NSString *)userQueryString {
    SPBSCommand *command = [[SPBSCommand alloc] initWithUserQuery: userQueryString];
    if (!command) {
        return NULL;
    }
    
    if (shellManager && [shellManager programExists:command.program]) {
        return [self createResponseForCommand:command];
    } else {
        return NULL;
    }
}

-(SPBResponse*) createResponseForCommand:(SPBSCommand *)comannd  {
    SPBResultSection *resultSection = [[SPBResultSection alloc] initWithTitle: @"Terminal"];
    
    // Ensures rankSectionsUsingBundleIDToSectionMapping parses section correctly to appear as top hit
    // More understanding about why sections with unknown bundle identifiers are thrown out is required
    // TODO Fix hardcoded spotlight bundle identifier
    resultSection.bundleIdentifier = @"com.apple.calculator";

    SPBSSearchResult *searchResult = [[SPBSSearchResult alloc] initWithCommand:comannd];
    resultSection.results = @[searchResult];

    SPBResponse *response = [[SPBResponse alloc] init];
    response.topHitIsIn = YES;
    response.sections = @[resultSection];
    
    return response;
}

@end
