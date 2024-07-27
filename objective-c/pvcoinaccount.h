#import <Foundation/Foundation.h>

@interface BankAccount : NSObject

@property (nonatomic, assign) double balance;

- (instancetype)initWithBalance:(double)balance;
- (void)deposit:(double)amount;
- (BOOL)withdraw:(double)amount;

@end
