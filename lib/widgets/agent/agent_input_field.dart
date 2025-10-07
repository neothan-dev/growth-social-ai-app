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

import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';

class AgentInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onVoiceTapDown;
  final VoidCallback onVoiceTapUp;
  final VoidCallback onVoiceTapCancel;
  final bool isListening;
  final bool isLoading;
  final String hintText;

  AgentInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onVoiceTapDown,
    required this.onVoiceTapUp,
    required this.onVoiceTapCancel,
    required this.isListening,
    this.isLoading = false,
    String? hintText,
  }) : hintText = hintText ?? "d798be5606nIk1NeVa2X".tr;

  @override
  State<AgentInputField> createState() => _AgentInputFieldState();
}

class _AgentInputFieldState extends State<AgentInputField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: widget.controller,
                enabled: !widget.isLoading,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: widget.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : null,
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => widget.onSend(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTapDown: (_) => widget.onVoiceTapDown(),
            onTapUp: (_) => widget.onVoiceTapUp(),
            onTapCancel: widget.onVoiceTapCancel,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.isListening ? Colors.red : Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.mic, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: widget.controller.text.trim().isNotEmpty && !widget.isLoading
                ? widget.onSend
                : null,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    widget.controller.text.trim().isNotEmpty &&
                        !widget.isLoading
                    ? Colors.blue
                    : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
