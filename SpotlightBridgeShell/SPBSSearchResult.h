#import <Foundation/Foundation.h>
#import <SpotlightBridge/SpotlightBridge.h>
#import "SPBSCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPBSSearchResult : SPBSearchResult

@property (nonatomic, strong) SPBSCommand *command;

@property (nonatomic) BOOL isTopHit;

@end

NS_ASSUME_NONNULL_END
