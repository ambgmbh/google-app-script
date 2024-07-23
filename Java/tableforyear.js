function createTableForYear(year) {
  // Abrufen der Daten aus der Tabelle "sunny" für das Jahr 2024
  var sunnySheet = SpreadsheetApp.openById("TABLE_ID").getSheetByName("sunny");
  var sunnyData = sunnySheet.getDataRange().getValues();

  // Extrahieren der Spaltennamen
  var columnNames = sunnyData[0];

  // Filtern der Daten für das Jahr 2024
  var filteredData = sunnyData.filter(function(row) {
    return row[0].getFullYear() === 2024;
  });

  // Erstellen einer neuen Tabelle mit dem Namen "Jahr_" + Jahr
  var newTable = SpreadsheetApp.getActiveSpreadsheet().insertSheet("Jahr_" + year);

  // Hinzufügen der Spaltennamen in der ersten Zeile
  newTable.appendRow(columnNames);

  // Berechnen und Hinzufügen der Daten für jedes Jahr
  for (var i = 1; i < filteredData.length; i++) {
    var rowData = filteredData[i];

    // Berechnen der Zeitverschiebung für Spalten G-H und J-K
    rowData[6] = calculateTimeShift(rowData[6], 1);
    rowData[7] = calculateTimeShift(rowData[7], -1);
    rowData[9] = calculateTimeShift(rowData[9], 1);
    rowData[10] = calculateTimeShift(rowData[10], -1);

    // Hinzufügen der Zeile mit den berechneten Daten
    newTable.appendRow(rowData);
  }
}

// Funktion zum Berechnen der Zeitverschiebung
function calculateTimeShift(originalTime, shift) {
  var hours = parseInt(originalTime.split(":")[0]);
  var minutes = parseInt(originalTime.split(":")[1]);

  hours += shift;
  minutes += shift;

  while (minutes >= 60) {
    minutes -= 60;
    hours += 1;
  }

  while (hours < 0) {
    hours += 24;
  }

  return (hours < 10 ? "0" : "") + hours + ":" + (minutes < 10 ? "0" : "") + minutes;
}

// Erstellen von Tabellen für jedes Jahr von 2025 bis 2065
for (var year = 2025; year <= 2065; year++) {
  createTableForYear(year);
}
