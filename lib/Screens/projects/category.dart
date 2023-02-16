class Category {
  final String name, path;

  const Category(this.name, this.path);

  static const all = [
    Category("Sehkrafterhaltung", "assets/projects/vision.png"),
    Category("Kinderkrebshilfe", "assets/projects/childhoodcancer.png"),
    Category("Umweltschutz", "assets/projects/environment.png"),
    Category("Humanitäre Hilfe", "assets/projects/humanitarian.png"),
    Category("Hungerhilfe", "assets/projects/hunger.png"),
    Category("Diabeteshilfe", "assets/projects/diabetes.png"),
    Category("Katastrophenhilfe", "assets/projects/disaster.png"),
    Category("Jugendförderung", "assets/projects/youth.png")
  ];
}
