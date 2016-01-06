#import "FooterCell.h"

@implementation FooterCell

-(FooterCell*)drawCell:(NSString*)balance
{
    float balanceAsFloat = [balance floatValue];
    self.lblCurrentBalance.text = [NSString stringWithFormat:@"%.02f", balanceAsFloat];
    return self;
}

@end
