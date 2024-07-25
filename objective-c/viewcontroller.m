#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *stations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self initializeStations];
}

- (void)initializeStations {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 1; i <= 255; i++) {
        [tempArray addObject:@{@"name": [NSString stringWithFormat:@"WR %03d", i], @"exists": @(arc4random_uniform(2))}];
    }
    self.stations = [NSArray arrayWithArray:tempArray];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationCell" forIndexPath:indexPath];
    NSDictionary *station = self.stations[indexPath.row];
    cell.textLabel.text = station[@"name"];
    
    BOOL exists = [station[@"exists"] boolValue];
    if (exists) {
        cell.backgroundColor = [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *station = self.stations[indexPath.row];
    [self showAlertForStation:station[@"name"]];
}

- (void)showAlertForStation:(NSString *)station {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Station Selected"
                                                                   message:[NSString stringWithFormat:@"You selected %@", station]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
