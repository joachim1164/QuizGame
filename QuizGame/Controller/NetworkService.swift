//
//  NetworkService.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import Foundation


class NetworkService{
    
    static func getData(from url: URL) async -> Data? {
        let session = URLSession.shared
        
            let (data, response) = try! await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else { return nil }
            
            if httpResponse.statusCode != 200 {
                fatalError("Network error")
            }
        
        return data

    }
}
