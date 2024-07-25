#import <Foundation/Foundation.h>
#import <mysql/mysql.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Verbindungskonfigurationsparameter
        const char *host = "192.168.34.1";
        const char *user = "root";
        const char *passwd = "dein_root_passwort";  // Setze hier dein root Passwort ein
        const char *dbname = "count";
        unsigned int port = 3306;

        MYSQL *conn;
        MYSQL_RES *res;
        MYSQL_ROW row;

        // Initialisiere MySQL-Verbindung
        conn = mysql_init(NULL);

        if (conn == NULL) {
            fprintf(stderr, "mysql_init() fehlgeschlagen\n");
            return EXIT_FAILURE;
        }

        // Verbindung herstellen
        if (mysql_real_connect(conn, host, user, passwd, dbname, port, NULL, 0) == NULL) {
            fprintf(stderr, "mysql_real_connect() fehlgeschlagen\n");
            fprintf(stderr, "Fehler: %s\n", mysql_error(conn));
            mysql_close(conn);
            return EXIT_FAILURE;
        }

        // Abfrage ausführen
        if (mysql_query(conn, "SELECT * FROM devices")) {
            fprintf(stderr, "Abfrage fehlgeschlagen: %s\n", mysql_error(conn));
            mysql_close(conn);
            return EXIT_FAILURE;
        }

        res = mysql_store_result(conn);

        if (res == NULL) {
            fprintf(stderr, "mysql_store_result() fehlgeschlagen: %s\n", mysql_error(conn));
            mysql_close(conn);
            return EXIT_FAILURE;
        }

        // Abfrageergebnisse verarbeiten
        int num_fields = mysql_num_fields(res);
        while ((row = mysql_fetch_row(res))) {
            for(int i = 0; i < num_fields; i++) {
                printf("%s ", row[i] ? row[i] : "NULL");
            }
            printf("\n");
        }

        // Ressourcen freigeben
        mysql_free_result(res);
        mysql_close(conn);

        printf("Verbindung erfolgreich beendet.\n");
    }
    return EXIT_SUCCESS;
}
