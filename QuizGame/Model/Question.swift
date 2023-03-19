//
//  Question.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import Foundation

struct Question: Codable, Identifiable {
    let id = UUID().uuidString
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
     }
}

extension Question {

    var shuffledAnswers: [String] {
        return (self.incorrectAnswers + [correctAnswer]).shuffled()
    }
    
}
