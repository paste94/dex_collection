class Generation {
  final String name;
  bool isSelected;

  Generation({required this.name, required this.isSelected});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Generation && other.name == name;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode;

  Generation copyWith({String? name, bool? isSelected}) {
    return Generation(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
