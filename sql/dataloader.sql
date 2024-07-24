-- Daten laden von einem .CSV dynamisch
LOAD DATA LOCAL INFILE 'matrix.csv'
INTO TABLE matrix_tabelle
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Zeile, @col1, @col2, ..., @col283);
