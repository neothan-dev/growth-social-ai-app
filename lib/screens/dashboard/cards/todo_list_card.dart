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
import 'package:vital_ai/localization/app_localizations.dart';
import '../../../utils/haptic_feedback_helper.dart';

class TodoListCard extends StatefulWidget {
  const TodoListCard({super.key});

  @override
  State<TodoListCard> createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _progressController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;

  final List<TodoItem> _todos = [
    TodoItem(
      id: '1',
      title: "0c1723dcf5rOxZR338VK".tr,
      isCompleted: false,
      priority: TodoPriority.high,
      emoji: '🌅',
    ),
    TodoItem(
      id: '2',
      title: "fd4c29aec0x9jJ9V70PK".tr,
      isCompleted: true,
      priority: TodoPriority.medium,
      emoji: '🥤',
    ),
    TodoItem(
      id: '3',
      title: "02177c07f5JTHNAqpIut".tr,
      isCompleted: false,
      priority: TodoPriority.medium,
      emoji: '🌸',
    ),
    TodoItem(
      id: '4',
      title: "8ea5abb66dAc6glhMFXa".tr,
      isCompleted: false,
      priority: TodoPriority.low,
      emoji: '📖',
    ),
    TodoItem(
      id: '5',
      title: "8a68115beaSZoNU4ClYX".tr,
      isCompleted: false,
      priority: TodoPriority.low,
      emoji: '📝',
    ),
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    final completedCount = _todos.where((todo) => todo.isCompleted).length;
    final totalCount = _todos.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;
    _progressAnimation = Tween<double>(begin: 0.0, end: progress).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    // 延迟启动动画，与其他卡片错开
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _progressController.forward();

      final completedCount = _todos.where((todo) => todo.isCompleted).length;
      final totalCount = _todos.length;
      final progress = totalCount > 0 ? completedCount / totalCount : 0.0;
      if (progress >= 0.8) {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    _progressController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_textController.text.trim().isNotEmpty) {
      // 为添加任务提供震动反馈
      HapticFeedbackHelper.success();

      setState(() {
        _todos.add(
          TodoItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: _textController.text.trim(),
            isCompleted: false,
            priority: TodoPriority.medium,
            emoji: '📋',
          ),
        );
      });
      _textController.clear();

      final completedCount = _todos.where((todo) => todo.isCompleted).length;
      final totalCount = _todos.length;
      final progress = totalCount > 0 ? completedCount / totalCount : 0.0;
      _progressAnimation = Tween<double>(begin: 0.0, end: progress).animate(
        CurvedAnimation(
          parent: _progressController,
          curve: Curves.easeOutCubic,
        ),
      );
      _progressController.forward(from: 0.0);
    }
  }

  void _toggleTodo(String id) {
    // 为勾选任务提供震动反馈
    HapticFeedbackHelper.toggleSwitch();

    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isCompleted = !todo.isCompleted;
    });

    final completedCount = _todos.where((todo) => todo.isCompleted).length;
    final totalCount = _todos.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;
    _progressAnimation = Tween<double>(begin: 0.0, end: progress).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );
    _progressController.forward(from: 0.0);
  }

  void _deleteTodo(String id) {
    // 为删除任务提供震动反馈
    HapticFeedbackHelper.error();

    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });

    final completedCount = _todos.where((todo) => todo.isCompleted).length;
    final totalCount = _todos.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;
    _progressAnimation = Tween<double>(begin: 0.0, end: progress).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );
    _progressController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _todos.where((todo) => todo.isCompleted).length;
    final totalCount = _todos.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: progress >= 0.8 ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTapDown: (_) => _scaleController.forward(),
                onTapUp: (_) => _scaleController.reverse(),
                onTapCancel: () => _scaleController.reverse(),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.45),
                              Colors.black.withValues(alpha: 0.35),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.orange.shade300,
                                          Colors.orange.shade500,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "51a09cc5e4bsFqQY7wlG".tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "9f474522dd3EJAB4EjxC".tr +
                                              '$completedCount/$totalCount',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.8,
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(
                                        alpha: 0.39,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: AnimatedBuilder(
                                      animation: _progressAnimation,
                                      builder: (context, child) {
                                        return Text(
                                          '${(_progressAnimation.value * 100).toInt()}%',
                                          style: TextStyle(
                                            color: Colors.green.shade100,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 12),

                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: AnimatedBuilder(
                                  animation: _progressAnimation,
                                  builder: (context, child) {
                                    return FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: _progressAnimation.value
                                          .clamp(0.0, 1.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green.shade400,
                                              Colors.green.shade600,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: 16),

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _textController,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "620952877fTKGMecJ98T".tr,
                                          hintStyle: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.6,
                                            ),
                                            fontSize: 13,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                        ),
                                        onSubmitted: (_) => _addTodo(),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _addTodo,
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.green.shade300,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 12),

                              ..._todos.map((todo) => _buildTodoItem(todo)),

                              if (_todos.isEmpty)
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.task_alt,
                                        size: 36,
                                        color: Colors.white.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "35dd7b2672OyDwZbZ0GN".tr,
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.7,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTodoItem(TodoItem todo) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getPriorityColor(todo.priority).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: GestureDetector(
          onTap: () => _toggleTodo(todo.id),
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: todo.isCompleted
                  ? Colors.green.shade400
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: todo.isCompleted
                    ? Colors.green.shade400
                    : Colors.white.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: todo.isCompleted
                ? Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
        ),
        title: Row(
          children: [
            Text(todo.emoji, style: TextStyle(fontSize: 14)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _getPriorityColor(todo.priority),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () => _deleteTodo(todo.id),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 14,
                  color: Colors.red.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(TodoPriority priority) {
    switch (priority) {
      case TodoPriority.high:
        return Colors.red.shade400;
      case TodoPriority.medium:
        return Colors.orange.shade400;
      case TodoPriority.low:
        return Colors.green.shade400;
    }
  }
}

class TodoItem {
  final String id;
  final String title;
  bool isCompleted;
  final TodoPriority priority;
  final String emoji;

  TodoItem({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.priority,
    required this.emoji,
  });
}

enum TodoPriority { high, medium, low }
