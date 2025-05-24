//
//  QuizView.swift
//  Quizzer
//
//  Created by Osman Baş on 24.05.2025.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.dismiss) var dismiss

    @State private var questions: [Question] = QuestionLoader.loadQuestions()
    @State private var currentIndex: Int = 0
    @State private var score: Int = 0
    @State private var timeRemaining: [Int] = []
    @State private var timer: Timer?
    @State private var totalTimeRemaining: Int = 60
    @State private var totalTimer: Timer?
    @State private var selectedOptions: [Int?] = []

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.1), .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            if currentIndex < questions.count {
                let question = questions[currentIndex]

                VStack(spacing: 25) {
                    VStack(spacing: 10) {
                        Text("Toplam Süre: \(totalTimeRemaining) saniye")
                            .font(.subheadline)
                            .foregroundColor(.orange)

                        Text(currentIndex < timeRemaining.count ? "Kalan Süre: \(timeRemaining[currentIndex]) saniye" : "Süre yükleniyor...")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }

                    Text("Soru \(currentIndex + 1)/\(questions.count)")
                        .font(.headline)

                    Text(question.question)
                        .font(.title2)
                        .multilineTextAlignment(.center)

                    VStack(spacing: 12) {
                        ForEach(question.options.indices, id: \.self) { index in
                            Button(action: {
                                handleAnswer(selectedIndex: index)
                            }) {
                                Text(question.options[index])
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background((currentIndex < selectedOptions.count && selectedOptions[currentIndex] == index) ? Color.green : Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                            }
                        }
                    }

                    HStack {
                        Button("\u{25C0}\u{FE0F} Geri") {
                            if currentIndex > 0 {
                                timer?.invalidate()
                                currentIndex -= 1
                                startTimer()
                            }
                        }
                        .disabled(currentIndex == 0)

                        Spacer()

                        Button("İleri \u{25B6}\u{FE0F}") {
                            if currentIndex < questions.count - 1 {
                                timer?.invalidate()
                                currentIndex += 1
                                startTimer()
                            }
                        }
                        .disabled(currentIndex == questions.count - 1)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .onAppear {
                    timeRemaining = questions.map { $0.timeLimit }
                    selectedOptions = Array(repeating: nil, count: questions.count)
                    startTimer()
                    startTotalTimer()
                }
            } else {
                // Skor ekranı
                VStack(spacing: 25) {
                    Text("Sınav Bitti")
                        .font(.largeTitle)
                        .bold()

                    Text("Skorunuz: \(score)/\(questions.count)")
                        .font(.title2)

                    Button("Yeniden Başla") {
                        restartQuiz()
                    }
                    .padding()
                    .frame(width: 200)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                    Button("Ana Menüye Dön") {
                        dismiss()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .onAppear {
                    saveScore()
                }
            }
        }
    }

    private func handleAnswer(selectedIndex: Int) {
        timer?.invalidate()
        selectedOptions[currentIndex] = selectedIndex
        let question = questions[currentIndex]
        if selectedIndex == question.correctAnswerIndex {
            score += 1
        }

        if currentIndex < questions.count - 1 {
            currentIndex += 1
            startTimer()
        } else {
            currentIndex = questions.count
        }
    }

    private func startTimer() {
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if currentIndex < timeRemaining.count, timeRemaining[currentIndex] > 0 {
                timeRemaining[currentIndex] -= 1
            } else {
                timer?.invalidate()
                if currentIndex < questions.count - 1 {
                    currentIndex += 1
                    startTimer()
                } else {
                    currentIndex = questions.count
                }
            }
        }
    }

    private func startTotalTimer() {
        totalTimer?.invalidate()
        totalTimeRemaining = 60

        totalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if totalTimeRemaining > 0 {
                totalTimeRemaining -= 1
            } else {
                totalTimer?.invalidate()
                timer?.invalidate()
                currentIndex = questions.count
                saveScore()
            }
        }
    }

    private func restartQuiz() {
        questions.shuffle()
        currentIndex = 0
        score = 0
        timeRemaining = questions.map { $0.timeLimit }
        selectedOptions = Array(repeating: nil, count: questions.count)
        startTimer()
        startTotalTimer()
    }

    private func saveScore() {
        let newScore = "\(score)/\(questions.count)"
        var scoreHistory = UserDefaults.standard.stringArray(forKey: "scoreHistory") ?? []
        scoreHistory.append(newScore)
        UserDefaults.standard.set(scoreHistory, forKey: "scoreHistory")
        UserDefaults.standard.set(newScore, forKey: "lastScore")
    }
}

#Preview {
    QuizView()
}



