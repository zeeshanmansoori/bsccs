class AppNotification {
  final String id;
  final String title;
  final String description;
  final String? image;
  final AppNotificationType type;
  final Map<String, String?>? extra;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.title,
    required this.image,
    required this.type,
    required this.isRead,
    required this.description,
    this.extra,
  });

  factory AppNotification.empty(String id) {
    return  AppNotification(
      id: id,
      title: "title",
      image: "image",
      type: AppNotificationType.course,
      isRead: false,
      description: "description",
    );
  }

  factory AppNotification.from({
    required dynamic title,
    required dynamic description,
    String? image,
    required String type,
    required String id,
    Map<String, String?>? map,
    bool isRead = false,
  }) {
    return AppNotification(
      id: id,
      title: title,
      image: image,
      type: AppNotificationType.fromString(type),
      isRead: isRead,
      extra: map,
      description: description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'type': type.name,
      'extra': extra,
      'isRead': isRead,
    };
  }

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      type: AppNotificationType.fromString(map['type']),
      extra: map['extra'],
      isRead: map['isRead'],
    );
  }

  @override
  String toString() {
    return 'AppNotification{id: $id, title: $title,'
        ' description: $description, image: $image,'
        ' type: $type, extra: $extra, isRead: $isRead}';
  }
}

enum AppNotificationType {
  course,
  non;

  static AppNotificationType fromString(String label) {
    return values.firstWhere(
      (v) => v.name.toLowerCase() == label.toLowerCase(),
      orElse: () => non,
    );
  }
}
