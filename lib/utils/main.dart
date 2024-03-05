String removeITags(String text) {
  return text.replaceAll(RegExp(r'<\/?i>'), '');
}
