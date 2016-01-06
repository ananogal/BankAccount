#import "AccountCell.h"

@implementation AccountCell

- (AccountCell*)drawCell:(Transaction*)transaction
{
    float theAmount = [[NSNumber numberWithInteger:transaction.Amount] floatValue];
    self.lblAmount.text = [NSString stringWithFormat:@"%.02f", theAmount];
    self.lblDate.text = transaction.Date;
    
    return self;
}

@end
