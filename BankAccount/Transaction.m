#import "Transaction.h"

@interface Transaction ()

@property (nonatomic, assign)NSInteger amount;
@property (nonatomic, copy)NSString *date;

@end

@implementation Transaction

+(instancetype)transactionWithAmount:(NSInteger)amount AndDate:(NSString*)date
{
    return [[self alloc]initWithAmount:amount AndDate:date];
}

-(instancetype)initWithAmount:(NSInteger)amount AndDate:(NSString*)date
{
    self = [super init];
    if (self) {
        self.amount = amount;
        self.date = date;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithAmount:0 AndDate:@""];
}

- (BOOL)isEqualToTransaction:(Transaction *)transaction {
    if (!transaction) {
        return NO;
    }
    
    BOOL haveEqualAmounts = (!self.amount && !transaction.amount) || self.amount == transaction.amount;
    BOOL haveEqualDates = (!self.date && !transaction.date) || [self.date isEqualToString:transaction.date];
    
    return haveEqualAmounts && haveEqualDates;
}

- (BOOL)isEqual:(id)other
{
    if (other == self)
    {
        return YES;
    }
    
    if (![other isKindOfClass:[Transaction class]])
    {
        return NO;
    }
    
    return [self isEqualToTransaction:(Transaction *)other];
}

- (NSUInteger)hash
{
    return self.amount ^ [self.date hash];
}

- (NSInteger)Amount
{
    return self.amount;
}

- (NSString*)Date
{
    return self.date;
}

@end
