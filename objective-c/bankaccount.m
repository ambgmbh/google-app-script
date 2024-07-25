#import "BankAccount.h"

@implementation BankAccount

- (instancetype)initWithBalance:(double)balance {
    self = [super init];
    if (self) {
        self.balance = balance;
    }
    return self;
}

- (void)deposit:(double)amount {
    self.balance += amount;
}

- (BOOL)withdraw:(double)amount {
    if (self.balance >= amount) {
        self.balance -= amount;
        return YES;
    } else {
        return NO;
    }
}

@end
