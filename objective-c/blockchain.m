#import "Blockchain.h"

@implementation Blockchain

- (instancetype)init {
    self = [super init];
    if (self) {
        _blocks = [NSMutableArray array];
        // Create the genesis block
        Block *genesisBlock = [[Block alloc] initWithData:@"Genesis Block" previousHash:@""];
        [_blocks addObject:genesisBlock];
    }
    return self;
}

- (void)addBlock:(Block *)block {
    Block *latestBlock = [self getLatestBlock];
    block.previousHash = latestBlock.hash;
    block.hash = [block calculateHash];
    [_blocks addObject:block];
}

- (Block *)getLatestBlock {
    return [self.blocks lastObject];
}

@end

