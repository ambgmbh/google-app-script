function fillMatrixWithRandomValues() {
  // Abrufen des Arbeitsblatts "matrix"
  var matrixSheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("matrix");

  // Anzahl der Zeilen und Spalten
  var numRows = matrixSheet.getLastRow();
  var numCols = matrixSheet.getLastColumn();

  // Starten in Spalte B Zeile 2
  var startRow = 2;
  var startCol = 2;

  // Durchlaufen der Zeilen und Spalten
  for (var row = startRow; row <= numRows; row++) {
    for (var col = startCol; col <= numCols; col++) {
      // Zufällige Bewertung zwischen 0,001 und 1,000 mit drei Dezimalstellen
      var randomValue = Math.random().toFixed(3);

      // Einfügen des Bewertungswerts in die Zelle
      matrixSheet.getRange(row, col).setValue(randomValue);
    }
  }
}
