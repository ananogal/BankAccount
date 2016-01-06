#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "TransactionsRepository.h"
#import "Clock.h"
#import "Transaction.h"
#import "Constants.h"

@interface TransactionsRepositoryTests : XCTestCase

@end

@implementation TransactionsRepositoryTests
{
    id clock;
    TransactionsRepository *transactionsRepository;
}

-(void)setUp
{
    [super setUp];
    
    clock = OCMClassMock([Clock class]);
    transactionsRepository = [TransactionsRepository transactionWithClock:clock];
}

- (void)testShouldCreateADepositTransaction
{
    [self createDepositForDate:TODAY];
    
    NSArray* transactions = [transactionsRepository allTransactions];
    
    Transaction *expectedTransaction =[self createTransaction:DEPOSIT_VALUE withDate:TODAY];
    
    XCTAssertTrue([transactions count] == 1);
    XCTAssertEqualObjects(transactions[0], expectedTransaction);
}

- (void)testShouldCreateAWithdrawTransaction
{
    [self createWithdrawForDate:TODAY];
    NSArray* transactions = [transactionsRepository allTransactions];
    
    Transaction *expectedTransaction = [self createTransaction:-WITHDRAW_VALUE withDate:TODAY];
    
    XCTAssertTrue([transactions count] == 1);
    XCTAssertEqualObjects(transactions[0], expectedTransaction);
}

- (void)testItShouldReturnTransactionInDescendentOrder
{
    [self createDepositForDate:YESTERDAY];
    
    [self depositForToday];
    
    [self withdrawForTomorrow];
    
    NSArray* transactions = [transactionsRepository allTransactions];
    
    Transaction *expectedTransaction = [self createTransaction:-WITHDRAW_VALUE withDate:TOMORROW];
    
    XCTAssertEqualObjects(transactions[0], expectedTransaction);
    
}

- (void)testItShouldReturnTheSumOfAllTransactions
{
    [self createDepositForDate:YESTERDAY];
    
    [self depositForToday];
    
    [self withdrawForTomorrow];

    XCTAssertEqualObjects([transactionsRepository currentBalance], @1500);
}

- (Transaction*)createTransaction:(NSInteger)amount withDate:(NSString*)date
{
    return [Transaction transactionWithAmount:amount AndDate:date];
}

- (void)createDepositForDate:(NSString*)date
{
    OCMStub([clock todayAsString]).andReturn(date);
    [transactionsRepository deposit:DEPOSIT_VALUE];
}

- (void)createWithdrawForDate:(NSString*)date
{
    OCMStub([clock todayAsString]).andReturn(date);
    [transactionsRepository withdraw:WITHDRAW_VALUE];
}

- (void)depositForToday
{
    id clockForToday = OCMClassMock([Clock class]);
    OCMStub([clockForToday todayAsString]).andReturn(TODAY);
    transactionsRepository.clock = clockForToday;
    [transactionsRepository deposit:DEPOSIT_VALUE];
}

- (void)withdrawForTomorrow
{
    id clockForTomorrow = OCMClassMock([Clock class]);
    OCMStub([clockForTomorrow todayAsString]).andReturn(TOMORROW);
    transactionsRepository.clock = clockForTomorrow;
    [transactionsRepository withdraw:WITHDRAW_VALUE];
}

@end
