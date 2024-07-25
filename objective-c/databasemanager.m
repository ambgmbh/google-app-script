#import "DatabaseManager.h"

@interface DatabaseManager ()

@property (nonatomic) MYSQL *conn;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *dbName;
@property (nonatomic) unsigned int port;

@end

@implementation DatabaseManager

- (instancetype)initWithHost:(NSString *)host
                         user:(NSString *)user
                     password:(NSString *)password
                     dbName:(NSString *)dbName
                       port:(unsigned int)port {
    self = [super init];
    if (self) {
        _host = [host copy];
        _user = [user copy];
        _password = [password copy];
        _dbName = [dbName copy];
        _port = port;
        _conn = mysql_init(NULL);
    }
    return self;
}

- (BOOL)connectToDatabase {
    if (mysql_real_connect(_conn, [_host UTF8String], [_user UTF8String], [_password UTF8String], [_dbName UTF8String], _port, NULL, 0) == NULL) {
        NSLog(@"Connection failed: %s", mysql_error(_conn));
        return NO;
    }
    return YES;
}

- (NSArray<NSArray<NSString *> *> *)fetchAllDevices {
    NSMutableArray<NSArray<NSString *> *> *resultArray = [NSMutableArray array];
    
    if (mysql_query(_conn, "SELECT * FROM devices")) {
        NSLog(@"Query failed: %s", mysql_error(_conn));
        return resultArray;
    }
    
    MYSQL_RES *res = mysql_store_result(_conn);
    if (res == NULL) {
        NSLog(@"Result storing failed: %s", mysql_error(_conn));
        return resultArray;
    }
    
    MYSQL_ROW row;
    while ((row = mysql_fetch_row(res))) {
        NSMutableArray<NSString *> *rowArray = [NSMutableArray array];
        for (unsigned int i = 0; i < mysql_num_fields(res); i++) {
            [rowArray addObject:(row[i] ? [NSString stringWithUTF8String:row[i]] : @"NULL")];
        }
        [resultArray addObject:[rowArray copy]];
    }
    
    mysql_free_result(res);
    return [resultArray copy];
}

- (void)dealloc {
    mysql_close(_conn);
}

@end
