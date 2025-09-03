// ignore_for_file: file_names

class UICollection<T> {
  final T item;
  bool isVisible;

  UICollection({required this.item, this.isVisible = true});

  UICollection<T> copyWith({bool? isSelected, bool? isVisible}) {
    return UICollection<T>(item: item, isVisible: isVisible ?? this.isVisible);
  }
}
