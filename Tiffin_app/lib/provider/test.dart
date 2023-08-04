class test {
  String x = "indiana";

  Map<String, int> map = {};

  void checkfrequency(value) {
    for (int i = 0; i < x.length; i++) {
      int count = map[x[i]] ?? 0;

      map[x[i]] = count + 1;
    }
  }
}
