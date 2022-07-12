import 'dart:async';
import 'dart:math';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia!',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'João',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Bom dia. Teremos reunião hoje?',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'Maria',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Sim',
      createdAt: DateTime.now(),
      userId: '3',
      userName: 'Lucas',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );
    _msgs.add(newMessage);
    _controller?.add(_msgs);
    return newMessage;
  }
}