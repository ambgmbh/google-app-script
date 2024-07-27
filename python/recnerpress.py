def berechne_pressdruck_und_durchmesser(hochdruck, wandungsstaerke, gewuenschter_pressdruck):
  """
  Berechnet den Pressdruck und den Schlauchdurchmesser eines Klimaschlauches.

  Args:
    hochdruck: Der Druck auf der Hochdruckseite (in bar).
    wandungsstaerke: Die Wandungsstärke des Schlauches (in mm).
    gewünschter_pressdruck: Der gewünschte Pressdruck (in bar).

  Returns:
    Ein Tupel mit dem berechneten Pressdruck (in bar) und dem Schlauchdurchmesser (in mm).
  """

  if hochdruck <= 0 or wandungsstaerke <= 0 or gewuenschter_pressdruck <= 0:
    raise ValueError("Ungültige Eingabewerte. Alle Werte müssen positiv sein.")

  if gewuenschter_pressdruck > 80:
    raise ValueError("Der gewünschte Pressdruck darf 80 bar nicht überschreiten.")

  # Berechnen des Schlauchdurchmessers
  schlauchdurchmesser = hochdruck * wandungsstaerke / gewuenschter_pressdruck

  # Berechnen des Pressdrucks (erneut, um Rundungsfehler zu vermeiden)
  berechneter_pressdruck = hochdruck * wandungsstaerke / schlauchdurchmesser

  return berechneter_pressdruck, schlauchdurchmesser

# Eingabe der Werte vom Benutzer
hochdruck = float(input("Geben Sie den Hochdruck (in bar) ein: "))
wandungsstaerke = float(input("Geben Sie die Wandungsstärke (in mm) ein: "))
gewünschter_pressdruck = float(input("Geben Sie den gewünschten Pressdruck (in bar) ein: "))

# Berechnung des Pressdrucks und Schlauchdurchmessers
berechneter_pressdruck, schlauchdurchmesser = berechne_pressdruck_und_durchmesser(hochdruck, wandungsstaerke, gewuenschter_pressdruck)

# Ausgabe des Ergebnisses
print(f"Der berechnete Pressdruck beträgt: {berechneter_pressdruck:.2f} bar")
print(f"Der erforderliche Schlauchdurchmesser beträgt: {schlauchdurchmesser:.2f} mm")
