void berechneEntfernungen(Matrix *matrix) {
    for (int i = 1; i < matrix->zeilen; i++) { // Beginnt bei Zeile 2
        for (int j = 0; j < matrix->spalten; j++) {
            double dx = matrix->werte[i][0] - matrix->werte[j][0];
            double dy = matrix->werte[i][1] - matrix->werte[j][1];
            double entfernung = sqrt(dx * dx + dy * dy);
            matrix->werte[i][j] = entfernung;
        }
    }
}
