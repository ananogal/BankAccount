#import "Clock.h"

@implementation Clock

-(NSString*)todayAsString
{
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    return [formatter stringFromDate:[NSDate date]];
}

@end
