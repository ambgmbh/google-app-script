#import <Foundation/Foundation.h>
#import <mysql/mysql.h>

@interface DatabaseManager : NSObject

- (instancetype)initWithHost:(NSString *)host
                         user:(NSString *)user
                     password:(NSString *)password
                     dbName:(NSString *)dbName
                       port:(unsigned int)port;

- (BOOL)connectToDatabase;
- (NSArray<NSArray<NSString *> *> *)fetchAllDevices;

@end
