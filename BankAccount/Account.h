#import <Foundation/Foundation.h>
#import "TransactionsRepository.h"

@interface Account : NSObject

+ (instancetype)accountWithTransactionRepository:(TransactionsRepository*)transactionRepo;

- (void)deposit:(NSInteger)amount;
- (void)withdraw:(NSInteger)amount;
- (NSArray*)transactions;
- (NSNumber*)currentBalance;

@end
