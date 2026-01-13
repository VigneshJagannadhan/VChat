import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';

class SocketEvents {
  static const String setup = 'setup';
  static const String joinChat = 'join chat';
  static const String leaveChat = 'leave chat';
  static const String typing = 'typing';
  static const String stopTyping = 'stop typing';
  static const String newMessage = 'new message';
  static const String messageReceived = 'message received';
}

class SocketService {
  io.Socket? _socket;

  bool get isConnected => _socket?.connected ?? false;

  /// ------------------------------------------------------------
  /// CONNECT
  /// ------------------------------------------------------------
  void connect() {
    if (_socket != null && _socket!.connected) return;

    var userId = locator<StorageService>().fetchUserId() ?? '';
    if (userId == '' || userId.isEmpty) {
      log('❌ Socket connect aborted: no userId');
      return;
    }

    _socket = io.io(
      AppUrls.socketUrl,
      io.OptionBuilder()
          .disableAutoConnect()
          .setTransports(['websocket'])
          .enableReconnection()
          .setReconnectionDelay(2000)
          .setTimeout(10000)
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      log('🟢 Socket connected');
      _socket!.emit(SocketEvents.setup, userId);
    });

    _socket!.onDisconnect((_) {
      log('🔴 Socket disconnected');
    });

    _socket!.onError((error) {
      log('❌ Socket error: $error');
    });

    _socket!.onAny((event, [data]) {
      log('🔵 Socket event: $event');
    });
  }

  /// ------------------------------------------------------------
  /// CHAT ROOM
  /// ------------------------------------------------------------
  void joinChat(String chatId) {
    _socket?.emit(SocketEvents.joinChat, chatId);
  }

  void leaveChat(String chatId) {
    _socket?.emit(SocketEvents.leaveChat, chatId);
  }

  /// ------------------------------------------------------------
  /// TYPING EVENTS
  /// ------------------------------------------------------------
  void startTyping(String chatId) {
    _socket?.emit(SocketEvents.typing, chatId);
  }

  void stopTyping(String chatId) {
    _socket?.emit(SocketEvents.stopTyping, chatId);
  }

  /// ------------------------------------------------------------
  /// SEND MESSAGE
  /// ------------------------------------------------------------
  void sendMessage(Map<String, dynamic> messagePayload) {
    _socket?.emit(SocketEvents.newMessage, messagePayload);
  }

  /// ------------------------------------------------------------
  /// LISTENERS
  /// ------------------------------------------------------------
  /// Returns a closure to unsubscribe from the listener
  void Function() onMessageReceived(Function(dynamic data) callback) {
    void handler(data) {
      log('📩 Raw Socket Data for ${SocketEvents.messageReceived}: $data');
      callback(data);
    }

    _socket?.on(SocketEvents.messageReceived, handler);

    return () {
      _socket?.off(SocketEvents.messageReceived, handler);
      log('🚫 Listener removed for ${SocketEvents.messageReceived}');
    };
  }

  void Function() onTyping(Function(String? chatId) callback) {
    handler(data) => callback(data);
    _socket?.on(SocketEvents.typing, handler);
    return () => _socket?.off(SocketEvents.typing, handler);
  }

  void Function() onStopTyping(Function(String? chatId) callback) {
    handler(data) => callback(data);
    _socket?.on(SocketEvents.stopTyping, handler);
    return () => _socket?.off(SocketEvents.stopTyping, handler);
  }

  /// ------------------------------------------------------------
  /// CLEANUP
  /// ------------------------------------------------------------
  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    log('🟠 Socket disposed');
  }
}
