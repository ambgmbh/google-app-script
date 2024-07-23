Matrix *erstelleMatrix(int zeilen, int spalten) {
    Matrix *matrix = malloc(sizeof(Matrix));
    if (matrix == NULL) {
        printf("Fehler beim Zuweisen von Speicher für die Matrix!\n");
        return NULL;
    }

    matrix->zeilen = zeilen;
    matrix->spalten = spalten;

    matrix->werte = malloc(zeilen * sizeof(double *));
    if (matrix->werte == NULL) {
        free(matrix);
        printf("Fehler beim Zuweisen von Speicher für die Matrixwerte!\n");
        return NULL;
    }

    for (int i = 0; i < zeilen; i++) {
        matrix->werte[i] = malloc(spalten * sizeof(double));
        if (matrix->werte[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(matrix->werte[j]);
            }
            free(matrix->werte);
            free(matrix);
            printf("Fehler beim Zuweisen von Speicher für die Matrixwerte!\n");
            return NULL;
        }
    }

    return matrix;
}

void freigebeMatrix(Matrix *matrix) {
    if (matrix != NULL) {
        for (int i = 0; i < matrix->zeilen; i++) {
            free(matrix->werte[i]);
        }
        free(matrix->werte);
        free(matrix);
    }
}
