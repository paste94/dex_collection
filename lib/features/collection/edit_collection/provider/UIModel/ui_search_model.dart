class UISearchModel<T> {
  final T item;
  bool isSelected;
  bool isVisible;

  UISearchModel({
    required this.item,
    this.isSelected = false,
    this.isVisible = true,
  });

  UISearchModel<T> copyWith({bool? isSelected, bool? isVisible}) {
    return UISearchModel<T>(
      item: item,
      isSelected: isSelected ?? this.isSelected,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
