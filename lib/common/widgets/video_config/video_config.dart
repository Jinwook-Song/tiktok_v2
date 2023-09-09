import 'package:flutter/material.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoPlay = false;

  void togleMute() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void togleAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}

/** ValueNotifier
 * final videoConfig = ValueNotifier(false);
 */

/** ChangeNotifier
class VideoConfig extends ChangeNotifier {
  bool videoMute = false;

  void toggleVideoMute() {
    videoMute = !videoMute;

    // videoMute 값을 listen하고 있는 위젯에게 변경 사항이 있음을 알림
    notifyListeners();
  }
}

final videoConfig = VideoConfig();
*/

