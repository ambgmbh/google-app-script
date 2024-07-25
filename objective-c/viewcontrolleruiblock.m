#import "ViewControlleruiblock.h"

@interface ViewController ()

@property (nonatomic, strong) Blockchain *blockchain;
@property (nonatomic, strong) BankAccount *bankAccount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blockchain = [[Blockchain alloc] init];
    self.bankAccount = [[BankAccount alloc] initWithBalance:1000.0];
    // Additional setup if needed
}

- (void)addTransaction:(NSString *)data {
    Block *newBlock = [[Block alloc] initWithData:data previousHash:self.blockchain.getLatestBlock.hash];
    [self.blockchain addBlock:newBlock];
}

- (void)generatePVCoinAddress {
    NSString *address = [PVCoinAddressGenerator generateAddress];
    NSLog(@"Generated PV Coin Address: %@", address);
}

// Implement UITableViewDataSource and UITableViewDelegate methods

@end
