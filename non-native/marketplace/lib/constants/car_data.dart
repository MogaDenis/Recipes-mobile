class CarData {
  static List<String> carBrands = [
    "Toyota",
    "Honda",
    "Ford",
    "BMW",
    "Mercedes-Benz",
    "Audi",
    "Seat"
  ]..sort();

  static Map<String, List<String>> carModels = {
    "Toyota": ["Yaris", "Supra", "Corolla", "Camry", "Prius", "C-HR"]..sort(),
    "Honda": ["Accord", "Civic", "CR-V"]..sort(),
    "Ford": ["Focus", "Mondeo", "EcoSport", "Kuga", "Fiesta", "Ka"]..sort(),
    "BMW": ["1-series", "2-series", "3-series"]..sort(),
    "Mercedes-Benz": ["C-klass", "A-klass", "E-klass", "S-klass"]..sort(),
    "Audi": ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "R8"]..sort(),
    "Seat": ["Exeo", "Leon", "Ibiza"]..sort(),
    "": []
  };

  static List<String> colours = [
    "Black",
    "White",
    "Red",
    "Blue",
    "Silver",
    "Green",
    "Yellow"
  ]..sort();

  static List<int> yearsList = List<int>.generate(50, (index) => 2024 - index);
}
