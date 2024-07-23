// Cam Consulting e.Kfm (germany)
// (c) by Edgar Wahl
// (copyrighted 2010,11,12, .... 2024)

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int zeilen;
    int spalten;
    double **werte;
} Matrix;

Matrix *erstelleMatrix(int zeilen, int spalten);
void freigebeMatrix(Matrix *matrix);
Matrix *liesMatrixAusCSV(const char *pfad);
void berechneEntfernungen(Matrix *matrix);
void schreibeErgebnisseZuCSV(Matrix *matrix, const char *pfad);

int main() {
    // Dateipfade anpassen
    const char *eingabePfad = "/pfad/zu/matrix.csv";
    const char *ausgabePfad = "/pfad/zu/entfernungen.csv";

    // Matrix aus CSV lesen
    Matrix *matrix = liesMatrixAusCSV(eingabePfad);
    if (matrix == NULL) {
        return 1;
    }

    // Entfernungen berechnen
    berechneEntfernungen(matrix);

    // Ergebnisse in CSV schreiben
    schreibeErgebnisseZuCSV(matrix, ausgabePfad);

    // Matrix freigeben
    freigebeMatrix(matrix);

    return 0;
}

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

void berechneEntfernungen(Matrix *matrix) {
    for (int i = 1; i < matrix->zeilen; i++) { // Beginnt bei Zeile 2
        for (int j = 0; j < matrix->spalten; j++) {
            double dx = matrix->werte[i][0] - matrix->werte[j][0];
            double dy = matrix->werte[i][1] - matrix->werte[j][1];
            double entfernung = sqrt(dx * dx + dy * dy);
            matrix->werte
