#import "TransactionsRepository.h"
#import "Transaction.h"

@interface TransactionsRepository ()

@property (nonatomic, strong)NSMutableArray *transactions;

@end

@implementation TransactionsRepository

+ (instancetype)transactionWithClock:(Clock*)clock
{
    return [[self alloc] initWithClock:clock];
}

- (instancetype)init
{
    return [self initWithClock:nil];
}

- (instancetype)initWithClock:(Clock*)clock;
{
    self = [super init];
    if (self)
    {
        self.transactions = [NSMutableArray array];
        self.clock = clock;
    }
    return self;
}

-(NSArray*)allTransactions
{
    return [[self.transactions reverseObjectEnumerator] allObjects];
}

-(void)deposit:(NSInteger)amount
{
    [self createTransaction:amount];
}

- (void)withdraw:(NSInteger)amount
{
    [self createTransaction:-amount];
}

-(void)createTransaction:(NSInteger)amount
{
    Transaction * transaction = [Transaction transactionWithAmount:amount AndDate:[self.clock todayAsString]];
    [self.transactions addObject:transaction];
}

- (NSNumber*)currentBalance
{
    return [self.transactions valueForKeyPath:@"@sum.amount"];
}

@end
