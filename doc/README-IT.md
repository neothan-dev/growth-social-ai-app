# Growth Social AI App

<div align="center">
  <img src="../assets/app_icon.png" alt="Growth Social AI App Logo" width="240" height="240">
  
  <h3>La Tua Piattaforma Personale di Crescita e Sociale con IA</h3>

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

## 🌟 Panoramica

Growth Social AI App è un'applicazione multipiattaforma completa basata su Flutter che funge da compagno intelligente di crescita e sociale. Combina il monitoraggio della crescita personale, l'analisi dei dati, le funzionalità della comunità sociale, la chat con gli amici e le capacità di conversazione vocale IA in una singola piattaforma potente.

## ✨ Caratteristiche Principali

### 🏥 Salute e Benessere
- **Monitoraggio della Crescita Personale**: Registra e monitora le tue metriche di salute quotidiane
- **Analisi dei Dati di Salute**: Analisi complete e approfondimenti sul tuo percorso di benessere
- **Visualizzazione dei Progressi**: Grafici e diagrammi bellissimi per tracciare i tuoi miglioramenti nel tempo
- **Obiettivi di Salute**: Imposta e raggiungi obiettivi di salute personalizzati

### 🤖 Caratteristiche Alimentate dall'IA
- **Chat Vocale IA**: Conversazioni in linguaggio naturale con il tuo assistente di salute IA
- **Raccomandazioni Intelligenti**: Consigli di salute personalizzati basati sui tuoi dati
- **Personalizzazione dello Stile Vocale**: Multiple personalità vocali IA tra cui scegliere
- **Coaching di Salute in Tempo Reale**: Ottieni feedback e guida istantanei

### 👥 Sociale e Comunità
- **Hub Sociale**: Connettiti con persone che la pensano come te nel loro percorso di salute
- **Condivisione della Comunità**: Condividi i tuoi progressi e risultati
- **Sistema di Amici**: Aggiungi amici e traccia i loro progressi insieme
- **Condivisione di Momenti**: Pubblica aggiornamenti sul tuo percorso di salute
- **Articoli di Esperti**: Accedi a contenuti curati su salute e benessere

### 💬 Comunicazione
- **Chat in Tempo Reale**: Messaggistica istantanea con amici e membri della comunità
- **Messaggi Vocali**: Invia e ricevi note vocali
- **Conversazioni di Gruppo**: Partecipa a discussioni di gruppo focalizzate sulla salute
- **Sistema di Notifiche**: Rimani aggiornato con promemoria importanti sulla salute

### 🌍 Internazionalizzazione
- **Supporto Multi-lingua**: Disponibile in più lingue
- **Contenuto Localizzato**: Informazioni sulla salute specifiche per regione e raccomandazioni
- **Adattamento Culturale**: Consigli sulla salute adattati a diversi contesti culturali

## 🚀 Iniziare

### Prerequisiti

- Flutter SDK (3.10.0 o superiore)
- Dart SDK
- Android Studio / Xcode (per lo sviluppo mobile)
- VS Code (IDE raccomandato)

### Installazione

1. **Clona il repository**
   ```bash
   git clone https://github.com/neothan-dev/growth-social-ai-app.git
   cd growth-social-ai-app
   ```

2. **Installa le dipendenze**
   ```bash
   flutter pub get
   ```

3. **Esegui l'applicazione**
   ```bash
   flutter run
   ```

### Configurazione Specifica per Piattaforma

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

#### Desktop (Windows/macOS/Linux)
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```


## 🏗️ Architettura

### Struttura del Progetto
```
lib/
├── config/           # File di configurazione
├── models/           # Modelli di dati
├── screens/          # Schermate UI
├── services/         # Servizi di logica di business
├── widgets/          # Componenti UI riutilizzabili
├── theme/            # Temi dell'app
├── utils/            # Funzioni di utilità
└── localization/     # Internazionalizzazione
```

### Componenti Chiave

- **Servizio IA**: Gestisce conversazioni e raccomandazioni IA
- **Servizio Dati di Salute**: Gestisce metriche di salute e analisi
- **Servizio Sociale**: Gestisce interazioni di comunità e amicizie
- **Servizio Vocale**: Gestisce riconoscimento e sintesi vocale
- **Servizio di Autenticazione**: Autenticazione e gestione utenti
- **Gestore di Navigazione**: Navigazione e routing dell'app

## 🛠️ Tecnologie Utilizzate

- **Flutter**: Framework UI multipiattaforma
- **Dart**: Linguaggio di programmazione
- **SQLite**: Archiviazione database locale
- **HTTP**: Comunicazione di rete
- **WebSocket**: Comunicazione in tempo reale
- **Lottie**: Animazioni
- **Provider**: Gestione dello stato
- **Shared Preferences**: Archiviazione locale
- **Permission Handler**: Permessi del dispositivo
- **Path Provider**: Accesso al filesystem

## 📊 Caratteristiche in Dettaglio

### Monitoraggio della Salute
- Registrazione delle metriche di salute quotidiane
- Visualizzazione dei progressi con grafici
- Impostazione di obiettivi e tracciamento dei risultati
- Analisi delle tendenze di salute
- Raccomandazioni personalizzate

### Assistente IA
- Elaborazione del linguaggio naturale
- Riconoscimento e sintesi vocale
- Consigli di salute contestuali
- Coaching personalizzato
- Personalità IA multiple

### Caratteristiche Sociali
- Profili utente e avatar
- Connessioni di amicizia
- Post e condivisione della comunità
- Discussioni di gruppo
- Condivisione di risultati

### Gestione dei Dati
- Database SQLite locale
- Sincronizzazione cloud
- Esportazione/importazione dati
- Controlli della privacy
- Backup e ripristino

## 🔧 Configurazione

### Configurazione dell'Ambiente
Crea un file `.env` nella directory root:
```env
API_BASE_URL=your_api_url
AI_SERVICE_URL=your_ai_service_url
VOICE_SERVICE_URL=your_voice_service_url
```

### Configurazione di Rete
Aggiorna `lib/config/network_config.dart` con i tuoi endpoint API.

### Configurazione Vocale
Configura le impostazioni vocali in `lib/config/voice_config.dart`.

## 🤝 Contribuire

Accogliamo i contributi! Consulta le nostre [Linee Guida per i Contributi](CONTRIBUTING.md) per i dettagli.

### Flusso di Lavoro di Sviluppo
1. Fork del repository
2. Crea un branch per la funzionalità
3. Apporta le tue modifiche
4. Aggiungi test se applicabile
5. Invia una pull request

## 📝 Licenza

Questo progetto è concesso in licenza sotto la Licenza Apache 2.0 - vedi il file [LICENSE](LICENSE) per i dettagli.

## 🆘 Supporto

- **Documentazione**: [Wiki](https://github.com/neothan-dev/growth-social-ai-app/wiki)
- **Problemi**: [GitHub Issues](https://github.com/neothan-dev/growth-social-ai-app/issues)
- **Discussioni**: [GitHub Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
- **Email**: neothan7@hotmail.com

## 🗺️ Roadmap

- [ ] Coaching di salute IA avanzato
- [ ] Integrazione con dispositivi indossabili
- [ ] Funzionalità di telemedicina
- [ ] Dashboard di analisi avanzata
- [ ] Supporto multi-tenant
- [ ] API per integrazioni di terze parti

## 🙏 Ringraziamenti

- Team Flutter per l'incredibile framework
- Comunità open source per vari pacchetti
- Professionisti della salute per l'expertise del dominio
- Beta tester per il feedback prezioso

## 📈 Statistiche

![GitHub stars](https://img.shields.io/github/stars/neothan-dev/growth-social-ai-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/neothan-dev/growth-social-ai-app?style=social)
![GitHub issues](https://img.shields.io/github/issues/neothan-dev/growth-social-ai-app)
![GitHub pull requests](https://img.shields.io/github/issues-pr/neothan-dev/growth-social-ai-app)

---

<div align="center">
  <p>Fatto con ❤️ dal Team Growth Social AI</p>
  <p>⭐ Dai una stella a questo repository se lo trovi utile!</p>
</div>
