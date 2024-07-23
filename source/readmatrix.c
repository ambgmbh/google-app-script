Matrix *liesMatrixAusCSV(const char *pfad) {
    FILE *datei = fopen(pfad, "r");
    if (datei == NULL) {
        printf("Fehler beim Öffnen der CSV-Datei!\n");
        return NULL;
    }

    int zeilen, spalten;
    fscanf(datei, "%d,%d", &zeilen, &spalten);

    Matrix *matrix = erstelleMatrix(zeilen, spalten);
    if (matrix == NULL) {
        fclose(datei);
        return NULL;
    }

    for (int i = 0; i < zeilen; i++) {
        for (int j = 0; j < spalten; j++) {
            fscanf(datei, "%lf,", &matrix->werte[i][j]);
        }
    }

    fclose(datei);
    return matrix;
}
