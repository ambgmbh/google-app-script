#import <Foundation/Foundation.h>
#import "Block.h"

@interface Blockchain : NSObject

@property (nonatomic, strong) NSMutableArray *blocks;

- (void)addBlock:(Block *)block;
- (Block *)getLatestBlock;

@end
