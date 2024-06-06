class ChatParticipant {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePhoto;
  final String email;

  ChatParticipant({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
    required this.email,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: json['profilePhoto'],
      email: json['email'],
    );
  }
}

class ChatMessage {
  final String content;
  final String createdAt;

  ChatMessage({
    required this.content,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}

class Conversation {
  final String id;
  final ChatParticipant participant;
  final ChatMessage lastMessage;

  Conversation({
    required this.id,
    required this.participant,
    required this.lastMessage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      participant: ChatParticipant.fromJson(json['participant']),
      lastMessage: ChatMessage.fromJson(json['lastMessage']),
    );
  }
}

class Message {
  final String id;
  final String content;
  final List<String> images;
  final Sender sender;
  final String userId;
  final String createdAt;
  final String updatedAt;

  Message({
    required this.id,
    required this.content,
    required this.images,
    required this.sender,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      content: json['content'],
      images: List<String>.from(json['images']),
      sender: Sender.fromJson(json['sender']),
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Sender {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePhoto;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePhoto,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profilePhoto: json['profilePhoto'],
    );
  }
}

