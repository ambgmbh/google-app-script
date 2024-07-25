#import "Block.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Block

- (instancetype)initWithData:(NSString *)data previousHash:(NSString *)previousHash {
    self = [super init];
    if (self) {
        self.previousHash = previousHash;
        self.data = data;
        self.timestamp = [NSDate date];
        self.hash = [self calculateHash];
    }
    return self;
}

- (NSString *)calculateHash {
    NSString *input = [NSString stringWithFormat:@"%@%@%@", self.previousHash, self.data, self.timestamp];
    const char *cStr = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

@end
