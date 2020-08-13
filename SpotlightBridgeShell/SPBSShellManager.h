#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBSShellManager : NSObject

+(NSString*) defaultShell;

-(instancetype) initWithShell: (NSString*)shell;

@property (nonatomic, strong) NSArray *aliases;

@property (nonatomic, strong) NSString *shell;

-(void)loadAliasesIntoCache;

-(BOOL)programExists: (NSString *)program;

@end

NS_ASSUME_NONNULL_END
