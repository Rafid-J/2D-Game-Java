class FileHandling {

  String filename;

  FileHandling(String filename) {
    this.filename = filename;
  }

  // Save best score
  void saveScore(int score) {
    String[] data = { str(score) };
    saveStrings(filename, data);
  }

  // Load best score
  int loadScore() {
    String[] data = loadStrings(filename);
    if (data != null && data.length > 0) {
      return int(data[0]);
    }
    return 0;
  }
}
