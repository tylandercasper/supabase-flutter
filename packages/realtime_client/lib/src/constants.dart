import 'package:realtime_client/src/version.dart';

class Constants {
  static const String vsn = '1.0.0';
  static const Duration defaultTimeout = Duration(milliseconds: 10000);
  static const int wsCloseNormal = 1000;
  static const Map<String, String> defaultHeaders = {
    'X-Client-Info': 'realtime-dart/$version',
  };
}

enum SocketStates { connecting, open, closing, closed, disconnected }

enum ChannelStates { closed, errored, joined, joining, leaving }

enum ChannelEvents {
  close,
  error,
  join,
  reply,
  leave,
  heartbeat,
  accessToken,
  broadcast,
  presence,
  postgresChanges,
}

extension ChannelEventsExtended on ChannelEvents {
  static ChannelEvents fromType(String type) {
    for (ChannelEvents enumVariant in ChannelEvents.values) {
      if (enumVariant.name == type || enumVariant.eventName() == type) {
        return enumVariant;
      }
    }
    throw 'No type $type exists';
  }

  String eventName() {
    if (this == ChannelEvents.accessToken) {
      return 'access_token';
    } else if (this == ChannelEvents.postgresChanges) {
      return 'postgres_changes';
    } else if (this == ChannelEvents.broadcast) {
      return 'broadcast';
    } else if (this == ChannelEvents.presence) {
      return 'presence';
    }
    return 'phx_$name';
  }
}

extension EnumName on Enum {
  String get name {
    return toString().split('.').last;
  }
}

class Transports {
  static const String websocket = 'websocket';
}