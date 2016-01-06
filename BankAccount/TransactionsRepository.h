#import <Foundation/Foundation.h>
#import "Clock.h"

@interface TransactionsRepository : NSObject

@property (nonatomic, strong)Clock *clock;

+ (instancetype)transactionWithClock:(Clock*)clock;

- (void)deposit:(NSInteger)amount;
- (void)withdraw:(NSInteger)amount;
- (NSArray*)allTransactions;
- (NSNumber*)currentBalance;

@end
