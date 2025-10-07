# Growth Social AI App

<div align="center">
  <img src="../assets/app_icon.png" alt="Growth Social AI App Logo" width="240" height="240">
  
  <h3>Tu Plataforma Personal de Crecimiento y Social con IA</h3>

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

## 🌟 Resumen

Growth Social AI App es una aplicación integral multiplataforma basada en Flutter que sirve como tu compañero inteligente de crecimiento y social. Combina seguimiento de crecimiento personal, análisis de datos, funciones de comunidad social, chat con amigos y capacidades de conversación por voz con IA en una sola plataforma poderosa.

## ✨ Características Principales

### 🏥 Salud y Bienestar
- **Seguimiento de Crecimiento Personal**: Registra y monitorea tus métricas de salud diarias
- **Análisis de Datos de Salud**: Análisis integral e insights sobre tu viaje de bienestar
- **Visualización de Progreso**: Gráficos y diagramas hermosos para rastrear tu mejora a lo largo del tiempo
- **Objetivos de Salud**: Establece y logra objetivos de salud personalizados

### 🤖 Características Impulsadas por IA
- **Chat de Voz con IA**: Conversaciones en lenguaje natural con tu asistente de salud con IA
- **Recomendaciones Inteligentes**: Consejos de salud personalizados basados en tus datos
- **Personalización de Estilo de Voz**: Múltiples personalidades de voz de IA para elegir
- **Coaching de Salud en Tiempo Real**: Obtén retroalimentación y orientación instantáneas

### 👥 Social y Comunidad
- **Centro Social**: Conecta con personas afines en su viaje de salud
- **Compartir en Comunidad**: Comparte tu progreso y logros
- **Sistema de Amigos**: Agrega amigos y rastrea su progreso juntos
- **Compartir Momentos**: Publica actualizaciones sobre tu viaje de salud
- **Artículos de Expertos**: Accede a contenido curado de salud y bienestar

### 💬 Comunicación
- **Chat en Tiempo Real**: Mensajería instantánea con amigos y miembros de la comunidad
- **Mensajes de Voz**: Envía y recibe notas de voz
- **Conversaciones Grupales**: Participa en discusiones grupales enfocadas en la salud
- **Sistema de Notificaciones**: Mantente actualizado con recordatorios importantes de salud

### 🌍 Internacionalización
- **Soporte Multiidioma**: Disponible en múltiples idiomas
- **Contenido Localizado**: Información de salud específica por región y recomendaciones
- **Adaptación Cultural**: Consejos de salud adaptados a diferentes contextos culturales

## 🚀 Comenzar

### Prerrequisitos

- Flutter SDK (3.10.0 o superior)
- Dart SDK
- Android Studio / Xcode (para desarrollo móvil)
- VS Code (IDE recomendado)

### Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/neothan-dev/growth-social-ai-app.git
   cd growth-social-ai-app
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

### Configuración Específica de Plataforma

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

#### Escritorio (Windows/macOS/Linux)
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 🏗️ Arquitectura

### Estructura del Proyecto
```
lib/
├── config/           # Archivos de configuración
├── models/           # Modelos de datos
├── screens/          # Pantallas de UI
├── services/         # Servicios de lógica de negocio
├── widgets/          # Componentes de UI reutilizables
├── theme/            # Temas de la aplicación
├── utils/            # Funciones de utilidad
└── localization/     # Internacionalización
```

### Componentes Clave

- **Servicio de IA**: Maneja conversaciones y recomendaciones de IA
- **Servicio de Datos de Salud**: Gestiona métricas de salud y análisis
- **Servicio Social**: Maneja interacciones de comunidad y amigos
- **Servicio de Voz**: Gestiona reconocimiento y síntesis de voz
- **Servicio de Autenticación**: Autenticación y gestión de usuarios
- **Administrador de Navegación**: Navegación y enrutamiento de la aplicación

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de UI multiplataforma
- **Dart**: Lenguaje de programación
- **SQLite**: Almacenamiento de base de datos local
- **HTTP**: Comunicación de red
- **WebSocket**: Comunicación en tiempo real
- **Lottie**: Animaciones
- **Provider**: Gestión de estado
- **Shared Preferences**: Almacenamiento local
- **Permission Handler**: Permisos del dispositivo
- **Path Provider**: Acceso al sistema de archivos

## 📊 Características en Detalle

### Seguimiento de Salud
- Registro de métricas de salud diarias
- Visualización de progreso con gráficos
- Establecimiento de objetivos y seguimiento de logros
- Análisis de tendencias de salud
- Recomendaciones personalizadas

### Asistente de IA
- Procesamiento de lenguaje natural
- Reconocimiento y síntesis de voz
- Consejos de salud contextuales
- Coaching personalizado
- Múltiples personalidades de IA

### Características Sociales
- Perfiles de usuario y avatares
- Conexiones de amigos
- Publicaciones y compartir de comunidad
- Discusiones grupales
- Compartir logros

### Gestión de Datos
- Base de datos SQLite local
- Sincronización en la nube
- Exportar/importar datos
- Controles de privacidad
- Respaldo y restauración

## 🔧 Configuración

### Configuración del Entorno
Crear un archivo `.env` en el directorio raíz:
```env
API_BASE_URL=your_api_url
AI_SERVICE_URL=your_ai_service_url
VOICE_SERVICE_URL=your_voice_service_url
```

### Configuración de Red
Actualizar `lib/config/network_config.dart` con tus endpoints de API.

### Configuración de Voz
Configurar ajustes de voz en `lib/config/voice_config.dart`.

## 🤝 Contribuir

¡Damos la bienvenida a las contribuciones! Por favor, consulta nuestras [Pautas de Contribución](CONTRIBUTING.md) para más detalles.

### Flujo de Trabajo de Desarrollo
1. Fork del repositorio
2. Crear una rama de característica
3. Hacer tus cambios
4. Agregar pruebas si es aplicable
5. Enviar una solicitud de extracción

## 📝 Licencia

Este proyecto está licenciado bajo la Licencia Apache 2.0 - consulta el archivo [LICENSE](LICENSE) para más detalles.

## 🆘 Soporte

- **Documentación**: [Wiki](https://github.com/neothan-dev/growth-social-ai-app/wiki)
- **Problemas**: [GitHub Issues](https://github.com/neothan-dev/growth-social-ai-app/issues)
- **Discusiones**: [GitHub Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
- **Correo**: neothan7@hotmail.com

## 🗺️ Hoja de Ruta

- [ ] Coaching de salud con IA avanzado
- [ ] Integración con dispositivos portátiles
- [ ] Características de telemedicina
- [ ] Panel de análisis avanzado
- [ ] Soporte multiinquilino
- [ ] API para integraciones de terceros

## 🙏 Agradecimientos

- Equipo de Flutter por el increíble framework
- Comunidad de código abierto por varios paquetes
- Profesionales de la salud por su experiencia en el dominio
- Probadores beta por su valiosa retroalimentación

## 📈 Estadísticas

![GitHub stars](https://img.shields.io/github/stars/neothan-dev/growth-social-ai-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/neothan-dev/growth-social-ai-app?style=social)
![GitHub issues](https://img.shields.io/github/issues/neothan-dev/growth-social-ai-app)
![GitHub pull requests](https://img.shields.io/github/issues-pr/neothan-dev/growth-social-ai-app)

---

<div align="center">
  <p>Hecho con ❤️ por el Equipo de Growth Social AI</p>
  <p>⭐ ¡Dale una estrella a este repositorio si te resulta útil!</p>
</div>
