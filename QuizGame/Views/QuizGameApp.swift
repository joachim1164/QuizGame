//
//  QuizGameApp.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import SwiftUI

@main
struct QuizGameApp: App {
    
    @StateObject var stateController = StateController()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(stateController)
        }
    }
}
