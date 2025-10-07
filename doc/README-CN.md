# Growth Social AI App

<div align="center">
  <img src="../assets/app_icon.png" alt="Growth Social AI App Logo" width="240" height="240">

  
  <h3>您的个人AI驱动成长和社交平台</h3>

<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/README.md"><img alt="README in English" src="https://img.shields.io/badge/English-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-CN.md"><img alt="简体中文操作指南" src="https://img.shields.io/badge/简体中文-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-JP.md"><img alt="日本語のREADME" src="https://img.shields.io/badge/日本語-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-KR.md"><img alt="README in 한국어" src="https://img.shields.io/badge/한국어-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-ES.md"><img alt="README en Español" src="https://img.shields.io/badge/Español-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-FR.md"><img alt="README en Français" src="https://img.shields.io/badge/Français-lightgrey"></a>
<a href="https://github.com/neothan-dev/growth-social-ai-app/blob/main/doc/README-IT.md"><img alt="README in Italiano" src="https://img.shields.io/badge/Italiano-lightgrey"></a>
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-green?style=for-the-badge)](https://flutter.dev/)
</div>

## 🌟 概述

Growth Social AI App 是一个基于 Flutter 的综合跨平台应用程序，作为您的智能成长和社交伙伴。它将个人成长跟踪、数据分析、社交社区功能、好友聊天和 AI 语音对话功能整合到一个强大的平台中。

## ✨ 主要功能

### 🏥 健康与健身
- **个人成长跟踪**：记录和监控您的日常健康指标
- **健康数据分析**：全面的分析和洞察您的健康之旅
- **进度可视化**：美观的图表和图形来跟踪您随时间的改善
- **健康目标**：设定和实现个性化的健康目标

### 🤖 AI 驱动功能
- **AI 语音聊天**：与您的 AI 健康助手进行自然语言对话
- **智能推荐**：基于您的数据的个性化健康建议
- **语音风格定制**：多种 AI 语音个性可供选择
- **实时健康指导**：获得即时反馈和指导

### 👥 社交与社区
- **社交中心**：与志同道合的人建立联系，共同进行健康之旅
- **社区分享**：分享您的进步和成就
- **好友系统**：添加好友并一起跟踪他们的进步
- **动态分享**：发布关于您健康之旅的更新
- **专家文章**：访问精选的健康和健身内容

### 💬 沟通
- **实时聊天**：与朋友和社区成员即时消息
- **语音消息**：发送和接收语音笔记
- **群组对话**：参与以健康为重点的群组讨论
- **通知系统**：及时了解重要的健康提醒

### 🌍 国际化
- **多语言支持**：支持多种语言
- **本地化内容**：特定地区的健康信息和推荐
- **文化适应**：针对不同文化背景定制的健康建议

## 🚀 开始使用

### 先决条件

- Flutter SDK (3.10.0 或更高版本)
- Dart SDK
- Android Studio / Xcode (用于移动开发)
- VS Code (推荐 IDE)

### 安装

1. **克隆仓库**
   ```bash
   git clone https://github.com/neothan-dev/growth-social-ai-app.git
   cd growth-social-ai-app
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行应用程序**
   ```bash
   flutter run
   ```

### 平台特定设置

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

#### 桌面 (Windows/macOS/Linux)
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 🏗️ 架构

### 项目结构
```
lib/
├── config/           # 配置文件
├── models/           # 数据模型
├── screens/          # UI 屏幕
├── services/         # 业务逻辑服务
├── widgets/          # 可重用的 UI 组件
├── theme/            # 应用主题
├── utils/            # 工具函数
└── localization/     # 国际化
```

### 关键组件

- **AI 服务**：处理 AI 对话和推荐
- **健康数据服务**：管理健康指标和分析
- **社交服务**：处理社区和好友互动
- **语音服务**：管理语音识别和合成
- **认证服务**：用户认证和管理
- **导航管理器**：应用导航和路由

## 🛠️ 使用的技术

- **Flutter**：跨平台 UI 框架
- **Dart**：编程语言
- **SQLite**：本地数据库存储
- **HTTP**：网络通信
- **WebSocket**：实时通信
- **Lottie**：动画
- **Provider**：状态管理
- **Shared Preferences**：本地存储
- **Permission Handler**：设备权限
- **Path Provider**：文件系统访问

## 📊 详细功能

### 健康跟踪
- 日常健康指标记录
- 带图表的进度可视化
- 目标设定和成就跟踪
- 健康趋势分析
- 个性化推荐

### AI 助手
- 自然语言处理
- 语音识别和合成
- 情境健康建议
- 个性化指导
- 多种 AI 个性

### 社交功能
- 用户资料和头像
- 好友连接
- 社区帖子和分享
- 群组讨论
- 成就分享

### 数据管理
- 本地 SQLite 数据库
- 云同步
- 数据导出/导入
- 隐私控制
- 备份和恢复

## 🔧 配置

### 环境设置
在根目录创建 `.env` 文件：
```env
API_BASE_URL=your_api_url
AI_SERVICE_URL=your_ai_service_url
VOICE_SERVICE_URL=your_voice_service_url
```

### 网络配置
在 `lib/config/network_config.dart` 中更新您的 API 端点。

### 语音配置
在 `lib/config/voice_config.dart` 中配置语音设置。

## 🤝 贡献

我们欢迎贡献！请查看我们的[贡献指南](CONTRIBUTING.md)了解详情。

### 开发工作流程
1. Fork 仓库
2. 创建功能分支
3. 进行更改
4. 如果适用，添加测试
5. 提交拉取请求

## 📝 许可证

本项目采用 Apache License 2.0 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🆘 支持

- **文档**：[Wiki](https://github.com/neothan-dev/growth-social-ai-app/wiki)
- **问题**：[GitHub Issues](https://github.com/neothan-dev/growth-social-ai-app/issues)
- **讨论**：[GitHub Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
- **邮箱**：neothan7@hotmail.com

## 🗺️ 路线图

- [ ] 高级 AI 健康指导
- [ ] 可穿戴设备集成
- [ ] 远程医疗功能
- [ ] 高级分析仪表板
- [ ] 多租户支持
- [ ] 第三方集成 API

## 🙏 致谢

- Flutter 团队提供的出色框架
- 开源社区提供的各种包
- 健康专业人士提供的领域专业知识
- 测试用户提供的宝贵反馈

## 📈 统计

![GitHub stars](https://img.shields.io/github/stars/neothan-dev/growth-social-ai-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/neothan-dev/growth-social-ai-app?style=social)
![GitHub issues](https://img.shields.io/github/issues/neothan-dev/growth-social-ai-app)
![GitHub pull requests](https://img.shields.io/github/issues-pr/neothan-dev/growth-social-ai-app)

---

<div align="center">
  <p>由 Growth Social AI 团队用 ❤️ 制作</p>
  <p>⭐ 如果您觉得这个仓库有用，请给它一个星标！</p>
</div>
