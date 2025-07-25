class Generation {
  final String name;
  bool isSelected;

  Generation(this.name, this.isSelected);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Generation && other.name == name;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode;
}
