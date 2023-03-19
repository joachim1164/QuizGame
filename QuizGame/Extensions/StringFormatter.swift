//
//  StringFormatter.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 17/03/2023.
//

import Foundation

extension String {
    
    func formatted() -> AttributedString {

        do {
            return try AttributedString(markdown: self)
        } catch {
            print("Conversion error: \(error)")
            return ""
        }
        
    }
}
