import 'dart:convert';

class Joke {
  String type;
  String? setup;
  String? delivery;
  String? joke;
  Joke({
    required this.type,
    this.setup,
    this.delivery,
    this.joke,
  });

  Joke copyWith({
    String? type,
    String? setup,
    String? delivery,
    String? joke,
  }) {
    return Joke(
      type: type ?? this.type,
      setup: setup ?? this.setup,
      delivery: delivery ?? this.delivery,
      joke: joke ?? this.joke,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'setup': setup,
      'delivery': delivery,
      'joke': joke,
    };
  }

  factory Joke.fromMap(Map<String, dynamic> map) {
    return Joke(
      type: map['type'] ?? '',
      setup: map['setup'],
      delivery: map['delivery'],
      joke: map['joke'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Joke.fromJson(String source) => Joke.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Joke(type: $type, setup: $setup, delivery: $delivery, joke: $joke)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Joke &&
        other.type == type &&
        other.setup == setup &&
        other.delivery == delivery &&
        other.joke == joke;
  }

  @override
  int get hashCode {
    return type.hashCode ^ setup.hashCode ^ delivery.hashCode ^ joke.hashCode;
  }
}
