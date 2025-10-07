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
import '../../../widgets/blur_background_container.dart';
import '../../../utils/asset_manager.dart';

class EventsHubScreen extends StatefulWidget {
  const EventsHubScreen({super.key});

  @override
  State<EventsHubScreen> createState() => _EventsHubScreenState();
}

class _EventsHubScreenState extends State<EventsHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<EventItem> _events = [];
  bool _isLoading = true;
  String _selectedType = "5c55a67935Z88EA3wsTz".tr;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadMockData();
    _startAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _fadeController.forward();
      _slideController.forward();
    }
  }

  void _loadMockData() {
    _events.addAll([
      EventItem(
        id: '1',
        title: "14af99b476tpJHgv7cEB".tr,
        description: "926c7a32cbthihVMIhnj".tr,
        image: 'assets/images/social_custom/events/marathon.jpg',
        startTime: DateTime.now().add(const Duration(days: 7)),
        endTime: DateTime.now().add(const Duration(days: 7, hours: 4)),
        location: "0078972c82a6GgrAhytz".tr,
        eventType: EventType.offline,
        category: EventCategory.fitness,
        maxParticipants: 500,
        currentParticipants: 234,
        price: 0,
        organizer: "1a5b440f89qkvZSM6myJ".tr,
        tags: [
          "ac4ca14fecCNQ6YWO9vg".tr,
          "591052c733S8tBhQxzgt".tr,
          "4eed57b5a1RACGsAFytX".tr,
        ],
        isRegistered: false,
        isFeatured: true,
      ),
      EventItem(
        id: '2',
        title: "b4ca1c8a3eG3lyaro3mj".tr,
        description: "64e0d96f175RinHXpG6g".tr,
        image: 'assets/images/social_custom/events/healthy_diet.jpg',
        startTime: DateTime.now().add(const Duration(days: 3)),
        endTime: DateTime.now().add(const Duration(days: 3, hours: 2)),
        location: "6789eb76cegz5ZF3tuP5".tr,
        eventType: EventType.offline,
        category: EventCategory.nutrition,
        maxParticipants: 30,
        currentParticipants: 28,
        price: 50,
        organizer: "63cae58ed3fsajiLeyo4".tr,
        tags: [
          "fd8f627cc1m6cpvYWPxV".tr,
          "c79bb628c74jshlcvTwC".tr,
          "aa18b6dcd8N5dypodkru".tr,
        ],
        isRegistered: true,
        isFeatured: false,
      ),
      EventItem(
        id: '3',
        title: "fae4d18f248TOdzgMZvl".tr,
        description: "0cc9d3d898NpyMaO6E5Y".tr,
        image: 'assets/images/social_custom/events/online_yoga.jpg',
        startTime: DateTime.now().add(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
        location: "3afb401d87RxFalLi8qF".tr,
        eventType: EventType.online,
        category: EventCategory.mindfulness,
        maxParticipants: 200,
        currentParticipants: 156,
        price: 0,
        organizer: "1fa62fbdfefl8l7zrvwK".tr,
        tags: [
          "bd4e166240mCOMJ4pGei".tr,
          "87eececcd1GfrpBHbItj".tr,
          "7bb5f03a005fn2mGIsnL".tr,
        ],
        isRegistered: false,
        isFeatured: true,
      ),
      EventItem(
        id: '4',
        title: "f87538f098zoLzgXA0gD".tr,
        description: "5005ab2f6dmXM8U3IB63".tr,
        image: 'assets/images/social_custom/events/fitness_challenge.jpg',
        startTime: DateTime.now().add(const Duration(days: 14)),
        endTime: DateTime.now().add(const Duration(days: 44)),
        location: "6aef1657580RAM5KZNe6".tr,
        eventType: EventType.hybrid,
        category: EventCategory.fitness,
        maxParticipants: 1000,
        currentParticipants: 567,
        price: 0,
        organizer: "625314e2cejK4LeJzGDY".tr,
        tags: [
          "4eed57b5a19RqvGv72jv".tr,
          "5d925cc69dWH5Y7Uzwwu".tr,
          "317a0db94bQ0mlFn1AGE".tr,
        ],
        isRegistered: false,
        isFeatured: false,
      ),
      EventItem(
        id: '5',
        title: "3b100d457fvVDXDgPB09".tr,
        description: "a0ce18d70dxrV7cdcA5m".tr,
        image: 'assets/images/social_custom/events/healthy_lecture.jpg',
        startTime: DateTime.now().add(const Duration(days: 5)),
        endTime: DateTime.now().add(
          const Duration(days: 5, hours: 1, minutes: 30),
        ),
        location: "d04cb2a570alrU01MrqN".tr,
        eventType: EventType.offline,
        category: EventCategory.mindfulness,
        maxParticipants: 100,
        currentParticipants: 78,
        price: 30,
        organizer: "7e6c1c0906nOJ5Vjk6QD".tr,
        tags: [
          "33de5fa31aF7cHau7dTo".tr,
          "30fe3f304c7RdnpjSG48".tr,
          "2e0502f2a7bXPnoRgG6e".tr,
        ],
        isRegistered: false,
        isFeatured: false,
      ),
      EventItem(
        id: '6',
        title: "ef4d60ca15b2CQPmYYwf".tr,
        description: "bc138833c2Geh9qFw9LD".tr,
        image: 'assets/images/social_custom/events/hiking.jpg',
        startTime: DateTime.now().add(const Duration(days: 10)),
        endTime: DateTime.now().add(const Duration(days: 10, hours: 6)),
        location: "60d59d57c4ma914DSVrN".tr,
        eventType: EventType.offline,
        category: EventCategory.outdoor,
        maxParticipants: 50,
        currentParticipants: 42,
        price: 80,
        organizer: "500cbb7c11ZvCnH5gM2k".tr,
        tags: [
          "a0d4309fe2LPUN3upFMj".tr,
          "f16030806591Fw3C3hjO".tr,
          "4f12408398YS8Evu0XA5".tr,
        ],
        isRegistered: true,
        isFeatured: false,
      ),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassmorphismBackgroundContainer(
        backgroundName: AppBackgrounds.societyBackground,
        blurSigma: 7.0,
        glassOpacity: 0.01,
        overlayColor: Colors.black.withValues(alpha: 0.1),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  _buildAppBar(),
                  _buildTypeFilter(),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : _buildEventList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "25034ce4e5QZxnUe2vO6".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              _showMyEvents();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilter() {
    final types = [
      "5c55a67935npjqiZaIrx".tr,
      "c9a557f346r7iLNUdTse".tr,
      "ea0a4b5a42BkajHHF6Cz".tr,
      "1b76c104f4n02oojZ03y".tr,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = _selectedType == type;
          return _buildTypeChip(type, isSelected);
        },
      ),
    );
  }

  Widget _buildTypeChip(String type, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          type,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          HapticFeedbackHelper.lightImpact();
          setState(() {
            _selectedType = type;
          });
        },
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        selectedColor: Colors.teal.withValues(alpha: 0.8),
        checkmarkColor: Colors.yellowAccent,
        side: BorderSide(
          color: isSelected
              ? Colors.teal.withValues(alpha: 0.8)
              : Colors.green.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    final filteredEvents = _selectedType == "5c55a67935grq7DKFOeW".tr
        ? _events
        : _events
              .where(
                (event) =>
                    _getTypeDisplayName(event.eventType) == _selectedType,
              )
              .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        final event = filteredEvents[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildEventCard(EventItem event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 活动图片
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _getCategoryColor(event.category).withValues(alpha: 0.2),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // 活动图片背景
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      event.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: _getCategoryColor(
                            event.category,
                          ).withValues(alpha: 0.2),
                          child: Center(
                            child: Icon(
                              _getCategoryIcon(event.category),
                              color: _getCategoryColor(event.category),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // 半透明遮罩
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.01),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                if (event.isFeatured)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "1452deafc6yHYzPB6LIP".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getEventTypeColor(
                        event.eventType,
                      ).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getTypeDisplayName(event.eventType),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 活动信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                // 描述
                Text(
                  event.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                // 时间地点
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatEventTime(event.startTime, event.endTime),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.location,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 统计信息
                Row(
                  children: [
                    _buildStatItem(
                      Icons.people,
                      '${event.currentParticipants}/${event.maxParticipants}',
                    ),
                    const SizedBox(width: 16),
                    _buildStatItem(Icons.person, event.organizer),
                    const SizedBox(width: 16),
                    _buildStatItem(
                      Icons.attach_money,
                      event.price == 0
                          ? "649a0fc7236CjsBDkwFw".tr
                          : '¥${event.price}',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 标签
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: event.tags.map((tag) => _buildTag(tag)).toList(),
                ),
                const SizedBox(height: 16),
                // 操作按钮
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedbackHelper.lightImpact();
                          if (event.isRegistered) {
                            _cancelRegistration(event);
                          } else {
                            _registerEvent(event);
                          }
                        },
                        icon: Icon(
                          event.isRegistered ? Icons.cancel : Icons.event,
                        ),
                        label: Text(
                          event.isRegistered
                              ? "ce5adae423LPj2KP98Wa".tr
                              : "1291213426bzpgyJ6zlr".tr,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: event.isRegistered
                              ? Colors.red.withValues(alpha: 0.8)
                              : Colors.teal.withValues(alpha: 0.8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        HapticFeedbackHelper.lightImpact();
                        _viewEventDetails(event);
                      },
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HapticFeedbackHelper.lightImpact();
                        _shareEvent(event);
                      },
                      icon: Icon(
                        Icons.share,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.teal.shade300,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getCategoryColor(EventCategory category) {
    switch (category) {
      case EventCategory.fitness:
        return Colors.blue;
      case EventCategory.nutrition:
        return Colors.orange;
      case EventCategory.mindfulness:
        return Colors.purple;
      case EventCategory.outdoor:
        return Colors.green;
    }
  }

  IconData _getCategoryIcon(EventCategory category) {
    switch (category) {
      case EventCategory.fitness:
        return Icons.fitness_center;
      case EventCategory.nutrition:
        return Icons.restaurant;
      case EventCategory.mindfulness:
        return Icons.self_improvement;
      case EventCategory.outdoor:
        return Icons.landscape;
    }
  }

  Color _getEventTypeColor(EventType eventType) {
    switch (eventType) {
      case EventType.offline:
        return Colors.green;
      case EventType.online:
        return Colors.blue;
      case EventType.hybrid:
        return Colors.purple;
    }
  }

  String _getTypeDisplayName(EventType eventType) {
    switch (eventType) {
      case EventType.offline:
        return "c9a557f346OdadJqy92R".tr;
      case EventType.online:
        return "ea0a4b5a420yRXJ9Q3sy".tr;
      case EventType.hybrid:
        return "1b76c104f4DGfki4MV5B".tr;
    }
  }

  String _formatEventTime(DateTime startTime, DateTime endTime) {
    final start = startTime;
    final end = endTime;

    if (start.day == end.day) {
      return '${start.month}/${start.day} ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    } else {
      return '${start.month}/${start.day} - ${end.month}/${end.day}';
    }
  }

  void _registerEvent(EventItem event) {
    if (event.currentParticipants >= event.maxParticipants) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("1b073e2587lSF3eeQXzw".tr),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      event.isRegistered = true;
      event.currentParticipants++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("a6b47f5b84D0iqipRUJ7".tr + '${event.title}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _cancelRegistration(EventItem event) {
    setState(() {
      event.isRegistered = false;
      event.currentParticipants--;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("d2595ec72eyo3fYjl7BL".tr + '${event.title}'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _viewEventDetails(EventItem event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description),
            const SizedBox(height: 16),
            Text(
              "f22259e888PgiNxmX6cf".tr +
                  '${_formatEventTime(event.startTime, event.endTime)}',
            ),
            Text("5b6cc870f0crrcwzp6hw".tr + '${event.location}'),
            Text("940f98812ay96HcMLBbq".tr + '${event.organizer}'),
            Text(
              '价格: ${event.price == 0 ? "649a0fc7236CjsBDkwFw".tr : '¥${event.price}'}',
            ),
            Text(
              "694ce9bba3rJpU3WnQAM".tr +
                  '${event.currentParticipants}/${event.maxParticipants}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4fI0ejE9ilf".tr),
          ),
        ],
      ),
    );
  }

  void _shareEvent(EventItem event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("5bdfb8ce2aoZsysRN8Kt".tr),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showMyEvents() {
    final myEvents = _events.where((event) => event.isRegistered).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("d098a963ddx6pUTc3ZBI".tr),
        content: SizedBox(
          width: double.maxFinite,
          child: myEvents.isEmpty
              ? Text("e143c4176f2XB8McqQpF".tr)
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: myEvents.length,
                  itemBuilder: (context, index) {
                    final event = myEvents[index];
                    return ListTile(
                      title: Text(event.title),
                      subtitle: Text(
                        _formatEventTime(event.startTime, event.endTime),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                          _cancelRegistration(event);
                        },
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4F5V4YqwQCo".tr),
          ),
        ],
      ),
    );
  }
}

class EventItem {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final EventType eventType;
  final EventCategory category;
  final int maxParticipants;
  int currentParticipants;
  final int price;
  final String organizer;
  final List<String> tags;
  bool isRegistered;
  final bool isFeatured;

  EventItem({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.eventType,
    required this.category,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.price,
    required this.organizer,
    required this.tags,
    required this.isRegistered,
    required this.isFeatured,
  });
}

enum EventType { offline, online, hybrid }

enum EventCategory { fitness, nutrition, mindfulness, outdoor }
