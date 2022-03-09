extension StringExtension on String {
  String toCapitalized() {
    return length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  }

  String toTitleCase() {
    const List<String> nonTitleList = [
      'to',
      'the',
    ];
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => nonTitleList.contains(str) ? str : str.toCapitalized())
        .join(' ');
  }
}
