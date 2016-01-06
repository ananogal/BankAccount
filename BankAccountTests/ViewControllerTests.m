#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewController.h"
#import "Account.h"
#import "Constants.h"

@interface ViewControllerTests : XCTestCase

@end

@implementation ViewControllerTests
{
    ViewController *controller;
    id account;
}

- (void)setUp {
    [super setUp];
    
    account = OCMClassMock([Account class]);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    controller = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.account = account;
    [controller loadView];
}

- (void)tearDown {
    controller = nil;
    
    [super tearDown];
}

- (void)testShouldHaveAnOutletConnectionToTxtAmount
{
    XCTAssertNotNil(controller.txtAmount);
}

- (void)testShouldHaveAnOutletConnectionToBtnWithdraw
{
    XCTAssertNotNil(controller.btnWithdraw);
}

- (void)testShouldHaveAnOutletConnectionToBtnDeposit
{
    XCTAssertNotNil(controller.btnDeposit);
}

- (void)testShouldHaveAnOutletConnectionToTblTransactions
{
    XCTAssertNotNil(controller.tblTransactions);
}

- (void)testShouldHaveAnActionToButtonDeposit {
    NSArray *actions = [controller.btnDeposit actionsForTarget:controller forControlEvent:UIControlEventTouchUpInside];
    NSString *action = [actions firstObject];
    XCTAssertTrue([action isEqualToString:@"deposit"]);
}

- (void)testShouldHaveAnActionToButtonWithdraw {
    NSArray *actions = [controller.btnWithdraw actionsForTarget:controller forControlEvent:UIControlEventTouchUpInside];
    NSString *action = [actions firstObject];
    XCTAssertTrue([action isEqualToString:@"withdraw"]);
}

- (void)testShouldMakeDeposit
{
    controller.txtAmount.text = [NSString stringWithFormat:@"%i", DEPOSIT_VALUE];
    [controller deposit];
    
    OCMVerify([account deposit:DEPOSIT_VALUE]);
}

- (void)testShouldMakeAWithdraw
{
    controller.txtAmount.text = [NSString stringWithFormat:@"%i", WITHDRAW_VALUE];
    [controller withdraw];
    
    OCMVerify([account withdraw:WITHDRAW_VALUE]);
}

-(void)testItShouldGetAllTransactions
{
    controller.txtAmount.text = [NSString stringWithFormat:@"%i", DEPOSIT_VALUE];
    [controller deposit];
    
    controller.txtAmount.text = [NSString stringWithFormat:@"%i", WITHDRAW_VALUE];
    [controller withdraw];
    
    [controller updateTransactions];
    
    OCMVerify([account transactions]);
}

@end
