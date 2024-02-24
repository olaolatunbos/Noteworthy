import 'package:equatable/equatable.dart';

/// * The product identifier is an important concept and can have its own type.
typedef NoteID = String;

/// Class representing a product.
class Note extends Equatable {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.group,
    required this.uid,
  });

  /// Unique product id
  final NoteID id;
  final String title;
  final String content;
  final String color;
  final String group;
  final String uid;

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      color: map['color'] ?? '',
      group: map['group'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'color': color,
        'group': group,
        'uid': uid
      };

  Note copyWith({
    NoteID? id,
    String? title,
    String? content,
    String? color,
    String? group,
    String? uid,
  }) {
    return Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        color: color ?? this.color,
        group: group ?? this.group,
        uid: uid ?? this.uid);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        color,
        group,
        uid,
      ];

  @override
  bool? get stringify => true;
}
