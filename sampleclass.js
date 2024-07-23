// Definition der Klasse Person
class Person {
    // Der Konstruktor wird aufgerufen, wenn eine neue Instanz der Klasse erstellt wird
    constructor(name, age) {
        this.name = name; // Setzt den Namen der Person
        this.age = age;   // Setzt das Alter der Person
    }

    // Eine Methode, um eine Begrüßung auszugeben
    greet() {
        console.log(`Hallo, mein Name ist ${this.name} und ich bin ${this.age} Jahre alt.`);
    }

    // Eine Methode, um das Alter der Person zu erhöhen
    haveBirthday() {
        this.age++;
        console.log(`Danke! Jetzt bin ich ${this.age} Jahre alt.`);
    }
}

// Erstellen einer neuen Instanz der Klasse Person
const person1 = new Person('Max', 30);

// Aufrufen der Methoden der Instanz
person1.greet(); // Ausgabe: Hallo, mein Name ist Max und ich bin 30 Jahre alt.
person1.haveBirthday(); // Ausgabe: Danke! Jetzt bin ich 31 Jahre alt.
person1.greet(); // Ausgabe: Hallo, mein Name ist Max und ich bin 31 Jahre alt.
