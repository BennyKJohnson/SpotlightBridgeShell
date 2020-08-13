#import "SPBSCommand.h"

@implementation SPBSCommand

-(instancetype) initWithUserQuery: (NSString *)userQueryString {
    
    self = [super init];
    if (self) {
        if ([userQueryString length] == 0) {
            return NULL;
        }
            
        NSArray *components = [userQueryString componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        self.program = [components firstObject];
        
        self.arguments = [NSArray array];
        if([components count] > 1) {
            NSArray *arguments = [components subarrayWithRange:NSMakeRange(1, components.count - 1)];
            self.arguments = arguments;
        }
    }
    
    return self;
}

@end
