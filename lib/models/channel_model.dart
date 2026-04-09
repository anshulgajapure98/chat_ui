class ChannelModel {
  final String id;
  final String name;
  int unreadCount;

  ChannelModel({required this.id, required this.name, this.unreadCount = 0});
}
