class Region {
  final String name;
  bool isSelected;

  Region({required this.name, required this.isSelected});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Region && other.name == name;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode;

  Region copyWith({String? name, bool? isSelected}) {
    return Region(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
