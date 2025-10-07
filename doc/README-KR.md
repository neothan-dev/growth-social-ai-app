# Growth Social AI App

<div align="center">
  <img src="../assets/app_icon.png" alt="Growth Social AI App Logo" width="240" height="240">
  
  <h3>당신의 개인 AI 기반 성장 및 소셜 플랫폼</h3>
  
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

## 🌟 개요

Growth Social AI App은 당신의 지능형 성장 및 소셜 동반자 역할을 하는 Flutter 기반의 포괄적인 크로스 플랫폼 애플리케이션입니다. 개인 성장 추적, 데이터 분석, 소셜 커뮤니티 기능, 친구 채팅, AI 음성 대화 기능을 하나의 강력한 플랫폼으로 통합합니다.

## ✨ 주요 기능

### 🏥 건강 및 웰니스
- **개인 성장 추적**: 일일 건강 지표를 기록하고 모니터링
- **건강 데이터 분석**: 웰니스 여정에 대한 포괄적인 분석 및 인사이트
- **진전 시각화**: 시간에 따른 개선을 추적하는 아름다운 차트와 그래프
- **건강 목표**: 개인화된 건강 목표 설정 및 달성

### 🤖 AI 기반 기능
- **AI 음성 채팅**: AI 건강 어시스턴트와의 자연어 대화
- **지능형 추천**: 데이터 기반의 개인화된 건강 조언
- **음성 스타일 커스터마이징**: 선택할 수 있는 다양한 AI 음성 개성
- **실시간 건강 코칭**: 즉각적인 피드백과 가이드 제공

### 👥 소셜 및 커뮤니티
- **소셜 허브**: 건강 여정에서 같은 생각을 가진 사람들과 연결
- **커뮤니티 공유**: 진전과 성과 공유
- **친구 시스템**: 친구를 추가하고 함께 진전을 추적
- **모멘트 공유**: 건강 여정에 대한 업데이트 게시
- **전문가 기사**: 큐레이션된 건강 및 웰니스 콘텐츠에 액세스

### 💬 커뮤니케이션
- **실시간 채팅**: 친구 및 커뮤니티 구성원과의 즉시 메시징
- **음성 메시지**: 음성 노트 전송 및 수신
- **그룹 대화**: 건강 중심의 그룹 토론 참여
- **알림 시스템**: 중요한 건강 알림으로 최신 정보 유지

### 🌍 국제화
- **다국어 지원**: 여러 언어로 제공
- **현지화된 콘텐츠**: 지역별 건강 정보 및 추천
- **문화적 적응**: 다양한 문화적 맥락에 맞춘 건강 조언

## 🚀 시작하기

### 사전 요구사항

- Flutter SDK (3.10.0 이상)
- Dart SDK
- Android Studio / Xcode (모바일 개발용)
- VS Code (권장 IDE)

### 설치

1. **저장소 클론**
   ```bash
   git clone https://github.com/neothan-dev/growth-social-ai-app.git
   cd growth-social-ai-app
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **애플리케이션 실행**
   ```bash
   flutter run
   ```

### 플랫폼별 설정

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

#### 데스크톱 (Windows/macOS/Linux)
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 🏗️ 아키텍처

### 프로젝트 구조
```
lib/
├── config/           # 설정 파일
├── models/           # 데이터 모델
├── screens/          # UI 화면
├── services/         # 비즈니스 로직 서비스
├── widgets/          # 재사용 가능한 UI 컴포넌트
├── theme/            # 앱 테마
├── utils/            # 유틸리티 함수
└── localization/     # 국제화
```

### 주요 컴포넌트

- **AI 서비스**: AI 대화 및 추천 처리
- **건강 데이터 서비스**: 건강 지표 및 분석 관리
- **소셜 서비스**: 커뮤니티 및 친구 상호작용 처리
- **음성 서비스**: 음성 인식 및 합성 관리
- **인증 서비스**: 사용자 인증 및 관리
- **네비게이션 매니저**: 앱 네비게이션 및 라우팅

## 🛠️ 사용 기술

- **Flutter**: 크로스 플랫폼 UI 프레임워크
- **Dart**: 프로그래밍 언어
- **SQLite**: 로컬 데이터베이스 저장소
- **HTTP**: 네트워크 통신
- **WebSocket**: 실시간 통신
- **Lottie**: 애니메이션
- **Provider**: 상태 관리
- **Shared Preferences**: 로컬 저장소
- **Permission Handler**: 디바이스 권한
- **Path Provider**: 파일 시스템 액세스

## 📊 상세 기능

### 건강 추적
- 일일 건강 지표 기록
- 차트를 통한 진전 시각화
- 목표 설정 및 달성 추적
- 건강 트렌드 분석
- 개인화된 추천

### AI 어시스턴트
- 자연어 처리
- 음성 인식 및 합성
- 상황별 건강 조언
- 개인화된 코칭
- 다양한 AI 개성

### 소셜 기능
- 사용자 프로필 및 아바타
- 친구 연결
- 커뮤니티 게시물 및 공유
- 그룹 토론
- 성과 공유

### 데이터 관리
- 로컬 SQLite 데이터베이스
- 클라우드 동기화
- 데이터 내보내기/가져오기
- 개인정보 보호 제어
- 백업 및 복원

## 🔧 설정

### 환경 설정
루트 디렉토리에 `.env` 파일 생성:
```env
API_BASE_URL=your_api_url
AI_SERVICE_URL=your_ai_service_url
VOICE_SERVICE_URL=your_voice_service_url
```

### 네트워크 설정
`lib/config/network_config.dart`에서 API 엔드포인트를 업데이트하세요.

### 음성 설정
`lib/config/voice_config.dart`에서 음성 설정을 구성하세요.

## 🤝 기여

기여를 환영합니다! 자세한 내용은 [기여 가이드라인](CONTRIBUTING.md)을 참조하세요.

### 개발 워크플로우
1. 저장소 포크
2. 기능 브랜치 생성
3. 변경사항 적용
4. 해당하는 경우 테스트 추가
5. 풀 리퀘스트 제출

## 📝 라이선스

이 프로젝트는 Apache License 2.0 하에 라이선스되어 있습니다 - 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🆘 지원

- **문서**: [Wiki](https://github.com/neothan-dev/growth-social-ai-app/wiki)
- **이슈**: [GitHub Issues](https://github.com/neothan-dev/growth-social-ai-app/issues)
- **토론**: [GitHub Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
- **이메일**: neothan7@hotmail.com

## 🗺️ 로드맵

- [ ] 고급 AI 건강 코칭
- [ ] 웨어러블 디바이스 통합
- [ ] 원격 의료 기능
- [ ] 고급 분석 대시보드
- [ ] 멀티 테넌트 지원
- [ ] 서드파티 통합 API

## 🙏 감사의 말

- 훌륭한 프레임워크를 제공한 Flutter 팀
- 다양한 패키지를 제공한 오픈소스 커뮤니티
- 도메인 전문성을 제공한 건강 전문가
- 귀중한 피드백을 제공한 베타 테스터

## 📈 통계

![GitHub stars](https://img.shields.io/github/stars/neothan-dev/growth-social-ai-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/neothan-dev/growth-social-ai-app?style=social)
![GitHub issues](https://img.shields.io/github/issues/neothan-dev/growth-social-ai-app)
![GitHub pull requests](https://img.shields.io/github/issues-pr/neothan-dev/growth-social-ai-app)

---

<div align="center">
  <p>Growth Social AI 팀이 ❤️로 제작</p>
  <p>⭐ 이 저장소가 도움이 된다면 별표를 눌러주세요!</p>
</div>
