#import <Foundation/Foundation.h>

@interface Transaction : NSObject

+(instancetype)transactionWithAmount:(NSInteger)amount AndDate:(NSString*)date;
- (NSInteger)Amount;
- (NSString*)Date;
@end
