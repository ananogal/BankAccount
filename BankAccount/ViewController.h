#import <UIKit/UIKit.h>
#import "Account.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UITableView *tblTransactions;
@property (weak, nonatomic) IBOutlet UIButton *btnWithdraw;
@property (weak, nonatomic) IBOutlet UIButton *btnDeposit;

@property (nonatomic, copy, readonly) NSArray* transactions;
@property (nonatomic, strong) Account* account;

- (IBAction)withdraw;
- (IBAction)deposit;

- (void)updateTransactions;

@end

