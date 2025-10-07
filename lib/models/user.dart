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

import 'package:vital_ai/localization/app_localizations.dart';

class User {
  final int id;
  final String username;
  final String? fullName;
  final String? email;
  final String? avatarUrl;
  final int? age;
  final String? region;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? preferences;

  User({
    required this.id,
    required this.username,
    this.fullName,
    this.email,
    this.avatarUrl,
    this.age,
    this.region,
    this.createdAt,
    this.lastLoginAt,
    this.preferences,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toInt() ?? 0,
      username: json['username'] ?? '',
      fullName: json['full_name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      age: json['age']?.toInt(),
      region: json['region'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'])
          : null,
      preferences: json['preferences'] != null
          ? Map<String, dynamic>.from(json['preferences'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'email': email,
      'avatar_url': avatarUrl,
      'age': age,
      'region': region,
      'created_at': createdAt?.toIso8601String(),
      'last_login_at': lastLoginAt?.toIso8601String(),
      'preferences': preferences,
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? fullName,
    String? email,
    String? avatarUrl,
    int? age,
    String? region,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      age: age ?? this.age,
      region: region ?? this.region,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      preferences: preferences ?? this.preferences,
    );
  }

  String get displayName => fullName ?? username;

  String get ageDisplay => age != null
      ? '$age ' + "43e84a7a98a5mnbacqoq".tr
      : "2f5f1d6fbfPdkgv629Nq".tr;

  String get regionDisplay => region ?? "2f5f1d6fbfcamCV3s7x3".tr;

  @override
  String toString() {
    return 'User(id: $id, username: $username, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
