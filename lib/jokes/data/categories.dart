import 'dart:convert';

import 'package:flutter/foundation.dart';

class Categories {
  List<String> categories;
  Categories({
    required this.categories,
  });

  Categories copyWith({
    List<String>? categories,
  }) {
    return Categories(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories,
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      categories: List<String>.from(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source));

  @override
  String toString() => 'Categories(categories: $categories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categories && listEquals(other.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}
