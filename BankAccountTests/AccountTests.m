#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "Account.h"
#import "TransactionsRepository.h"
#import "Constants.h"

@interface AccountTests : XCTestCase

@end

@implementation AccountTests
{
    id transactionRepository;
    Account *account;
}

-(void)setUp
{
    [super setUp];
    
    transactionRepository = OCMClassMock([TransactionsRepository class]);
    account = [Account accountWithTransactionRepository:transactionRepository];
}


- (void)testShouldAddADepositTransaction
{
    [account deposit:DEPOSIT_VALUE];
    
    OCMVerify([transactionRepository deposit:DEPOSIT_VALUE]);
}

- (void)testShouldAddAWithdrawTransaction
{
    [account withdraw:WITHDRAW_VALUE];
    OCMVerify([transactionRepository withdraw:WITHDRAW_VALUE]);
}

- (void)testItShouldReturnAllTransactions
{
    [account transactions];
    
    OCMVerify([transactionRepository allTransactions]);
}

- (void)testItShouldReturnTheCurrentBalance
{
    [account deposit:DEPOSIT_VALUE];
    [account deposit:DEPOSIT_VALUE];
    [account withdraw:WITHDRAW_VALUE];
    
    OCMStub([transactionRepository currentBalance]).andReturn(@1500);
    NSString* currentBalance = [NSString stringWithFormat:@"%@", [account currentBalance]];
    
    XCTAssertTrue([currentBalance isEqualToString:@"1500"]);
}

@end
