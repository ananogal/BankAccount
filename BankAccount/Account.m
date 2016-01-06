#import "Account.h"

@interface Account()

@property (nonatomic, strong) TransactionsRepository* transactionsRepository;

@end

@implementation Account

+ (instancetype)accountWithTransactionRepository:(TransactionsRepository*)transactionRepo
{
    return [[self alloc] initWithTransactionRepository:transactionRepo];
}

- (instancetype)initWithTransactionRepository:(TransactionsRepository*)transactionRepo
{
    self = [super init];
    if (self) {
        self.transactionsRepository = transactionRepo;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTransactionRepository:nil];
}

- (void)deposit:(NSInteger)amount
{
    [self.transactionsRepository deposit:amount];
}

- (void)withdraw:(NSInteger)amount
{
    [self.transactionsRepository withdraw:amount];
}

- (NSArray*)transactions
{
    return [self.transactionsRepository allTransactions];
}

- (NSNumber*)currentBalance
{
    return [self.transactionsRepository currentBalance];
}

@end
