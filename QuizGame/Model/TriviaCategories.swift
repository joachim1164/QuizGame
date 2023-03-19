//
//  TriviaCategories.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import Foundation

struct TriviaCategories: Codable {
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
     case categories = "trivia_categories"
     }
}
