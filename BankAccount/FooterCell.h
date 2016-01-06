#import <UIKit/UIKit.h>

@interface FooterCell :  UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCurrentBalance;

-(FooterCell*)drawCell:(NSNumber*)balance;

@end
