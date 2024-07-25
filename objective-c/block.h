#import <Foundation/Foundation.h>

@interface Block : NSObject

@property (nonatomic, strong) NSString *previousHash;
@property (nonatomic, strong) NSString *hash;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSDate *timestamp;

- (instancetype)initWithData:(NSString *)data previousHash:(NSString *)previousHash;
- (NSString *)calculateHash;

@end
