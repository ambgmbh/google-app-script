void schreibeErgebnisseZuCSV(Matrix *matrix, const char *pfad) {
    FILE *datei = fopen(pfad, "w");
    if (datei == NULL) {
        printf("Fehler beim Öffnen der CSV-Datei!\n");
        return;
    }

    for (int i = 0; i < matrix->zeilen; i++) {
        for (int j = 0; j < matrix->spalten; j++) {
            fprintf(datei, "%lf,", matrix->werte[i][j]);
        }
        fprintf(datei, "\n");
    }

    fclose(datei);
}
