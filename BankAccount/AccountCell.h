#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface AccountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;

- (AccountCell*)drawCell:(Transaction*)transaction;

@end
