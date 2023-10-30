extension CapExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String capitalizeFirstofEach() {
    return split(" ").map((str) => str.capitalize()).join(" ");
  }
}
