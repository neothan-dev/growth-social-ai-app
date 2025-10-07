/** Copyright © 2025 Neothan
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

class VoiceConfig {
  static const int calibrationFrameCount = 10;

  static const int volumeHistorySize = 50;
  static const double minVolumeThreshold = 0.005;
  static const double maxVolumeThreshold = 1;
  static const double adaptiveFactor = 1.6;

  static const int androidFrameInterval = 200;
  static const int iosFrameInterval = 200;

  static const int silenceThreshold = 7;

  static const double volumeNormalizationFactor = 32768.0;

  static const int androidBufferSize = 4096;
  static const int androidMaxBufferFrames = 10;
  static const bool enableAndroidFrameThrottling = true;
}
