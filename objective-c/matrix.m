#import <Foundation/Foundation.h>

// Funktion zum Lesen einer CSV-Datei in ein zweidimensionales Array
NSArray *readCSV(NSString *filePath) {
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [fileContent componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        NSArray *row = [line componentsSeparatedByString:@","];
        [matrix addObject:row];
    }
    return matrix;
}

// Funktion zur Berechnung der Entfernungen zwischen Zellen
NSArray *calculateDistances(NSArray *matrix) {
    NSMutableArray *distances = [[NSMutableArray alloc] init];
    for (int i = 1; i < [matrix count]; i++) { // Beginnt bei Zeile 2
        NSMutableArray *rowDistances = [[NSMutableArray alloc] init];
        for (int j = 0; j < [matrix count]; j++) {
            int distance = (int)sqrt(pow([[matrix[i][0] intValue] - [matrix[j][0] intValue]], 2) + 
                                     pow([[matrix[i][1] intValue] - [matrix[j][1] intValue]], 2));
            [rowDistances addObject:[NSNumber numberWithInt:distance]];
        }
        [distances addObject:rowDistances];
    }
    return distances;
}

// Funktion zum Schreiben der Ergebnisse in eine neue CSV-Datei
void writeCSV(NSArray *matrix, NSString *filePath) {
    NSMutableString *fileContent = [[NSMutableString alloc] init];
    for (NSArray *row in matrix) {
        [fileContent appendString:[row componentsJoinedByString:@","]];
        [fileContent appendString:@"\n"];
    }
    [fileContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Dateipfade anpassen
        NSString *inputPath = @"/pfad/zu/matrix.csv";
        NSString *outputPath = @"/pfad/zu/entfernungen.csv";

        // Matrix aus CSV lesen
        NSArray *matrix = readCSV(inputPath);

        // Entfernungen berechnen
        NSArray *distances = calculateDistances(matrix);

        // Ergebnisse in CSV schreiben
        writeCSV(distances, outputPath);
    }
    return 0;
}
