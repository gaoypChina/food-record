import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabTypeProvider = StateProvider<TabType>((ref) => TabType.home);

enum TabType {
  home,
  record,
  settings,
}
