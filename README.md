# Quizzer - iOS Quiz Uygulaması

Quizzer, SwiftUI kullanılarak geliştirilmiş bir iOS quiz uygulamasıdır. Kullanıcıya 5 adet çoktan seçmeli soru sorulur, her sorunun belirli bir süresi vardır. Toplam sınav süresi ve her sorunun bireysel süresi ayrı ayrı yönetilir.


## ✨ Özellikler

* 📋 JSON'dan yüklenen sorular
* ⏱ Her soru için ayrı süre (10 saniye vb.)
* ⌛ Toplam sınav süre kontrolü (60 saniye vb.)
* ✅ Cevap seçildiğinde otomatik olarak bir sonraki soruya geçiş
* 🔁 Önceki ve sonraki soruya dönebilme
* ✅ Seçilen şık yeşil renkle görsel olarak vurgulanır
* 📏 Skorlar UserDefaults ile kaydedilir
* 📊 Ana ekranda geçmiş skorlar listelenir
* 🗑 Geçmişi temizleme seçeneği

## 🚀 Kurulum

1. Projeyi Xcode ile aç
2. `questions.json` dosyasındaki soruları kendine göre düzenle
3. Simülatör veya gerçek cihazda çalıştır

## 🛠 Kullanılan Teknolojiler

* Swift 5
* SwiftUI
* MVVM (basit düzeyde)
* UserDefaults
* JSON Parsing

## 📁 Dosya Yapısı

```
├── Models
│   └── Question.swift
├── Views
│   ├── StartView.swift
│   └── QuizView.swift
├── Utils
│   └── QuestionLoader.swift
├── Resources
│   └── questions.json
├── Assets.xcassets
├── Info.plist
```

## 📷 Ekran Görüntüleri

> Örnek ekran görüntülerini buraya ekleyebilirsin:

```
![Start Screen](screenshots/start.png)
![Quiz Screen](screenshots/quiz.png)
```

## 🧑‍💻 Geliştirici

* **Osman Baş**
* 📧 \[[obas1869@gmail.com](mailto:email@example.com)] 

## 📝 Lisans

Bu proje eğitim ve portföy amacıyla hazırlanmıştır. Lisanssızdır.
