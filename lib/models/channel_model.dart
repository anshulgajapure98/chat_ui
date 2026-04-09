class ChannelModel {
  final String id;
  final String name;
  final int unreadCount;

  ChannelModel({required this.id, required this.name, this.unreadCount = 0});

  // Add this
  ChannelModel copyWith({String? id, String? name, int? unreadCount}) {
    return ChannelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
