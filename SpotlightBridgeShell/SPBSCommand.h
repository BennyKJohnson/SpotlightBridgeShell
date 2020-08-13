#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBSCommand : NSObject

@property (strong, nonatomic) NSString *program;

@property (strong, nonatomic) NSArray *arguments;

-(instancetype) initWithUserQuery: (NSString *)userQueryString;

@end

NS_ASSUME_NONNULL_END
