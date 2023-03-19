//
//  CategoryData.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 19/03/2023.
//

import Foundation

struct CategoryData: Codable{
    let id: Int
    let possibleQuestions: PossibleQuestions
    
    enum CodingKeys: String, CodingKey {
        case id = "category_id"
        case possibleQuestions = "category_question_count"
     }
    

    struct PossibleQuestions: Codable{
        let totalCount: Int
        let easyCount: Int
        let mediumCount: Int
        let hardCount: Int

        enum CodingKeys: String, CodingKey {
            case totalCount = "total_question_count"
            case easyCount = "total_easy_question_count"
            case mediumCount = "total_medium_question_count"
            case hardCount = "total_hard_question_count"
         }
    }
}


