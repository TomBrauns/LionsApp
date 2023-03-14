//Licensed under the EUPL v.1.2 or later
class Category {
  final String name, path;

  const Category(this.name, this.path);

  static const all = [
    Category("Sehkrafterhaltung", "assets/projects/Sehkrafterhaltung.png"),
    Category("Kinderkrebshilfe", "assets/projects/Kinderkrebshilfe.png"),
    Category("Umweltschutz", "assets/projects/Umweltschutz.png"),
    Category("Humanitäre Hilfe", "assets/projects/Humanitäre Hilfe.png"),
    Category("Hungerhilfe", "assets/projects/Hungerhilfe.png"),
    Category("Diabeteshilfe", "assets/projects/Diabeteshilfe.png"),
    Category("Katastrophenhilfe", "assets/projects/Katastrophenhilfe.png"),
    Category("Jugendförderung", "assets/projects/Jugendförderung.png")
  ];
}
