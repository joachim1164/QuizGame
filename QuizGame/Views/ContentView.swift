//
//  ContentView.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var stateController: StateController
    @State private var selectedCategoryIndex = 0
    @State private var selectedDifficulty = DifficultyLevel.easy
    @State private var showQuestions = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
            
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                if stateController.categories.isEmpty {
                        
                        VStack{
                            Text("Loading categories")
                                .foregroundColor(.black)
                                .font(.title)
                            ProgressView()
                        }
                    
                } else {
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            Text("QuizGame")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        
                        Spacer()
                        
                        VStack{
                            Text("Choose a category")
                                .foregroundColor(.black)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            
                            Picker("", selection: $selectedCategoryIndex) {
                                ForEach(0..<self.stateController.categories.count, id: \.self) { index in
                                    Text(self.stateController.categories[index].name)
                                }
                            }
                            .onChange(of: selectedCategoryIndex) { newValue in
                                stateController.fetchCategoryData(categoryIndex: newValue)
                            }
                            
                            
                            Text("Choose difficulty")
                                .foregroundColor(.black)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                            
                            Picker(selection: $selectedDifficulty, label: Text("Difficulty Level")) {
                                ForEach(DifficultyLevel.allCases, id: \.self) { level in
                                    Text(level.rawValue)
                                }
                            }
                            
                            
                            
                        }
                        Spacer()
                        
                        VStack{
                            Text("Possible questions:")
                            
                            if stateController.categoryData != nil {
                                
                                switch selectedDifficulty {
                                case .easy:
                                    Text(String(stateController.categoryData!.possibleQuestions.easyCount))

                                case .medium:
                                    Text(String(stateController.categoryData!.possibleQuestions.mediumCount))
                                    
                                case .hard:
                                    Text(String(stateController.categoryData!.possibleQuestions.hardCount))
                                }
                                
                            } else {
                                ProgressView()
                            }
                            
                        }
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        
                        Spacer()
                        
                        VStack {
                            
                            Button {
                                stateController.fetchQuestions(categoryIndex: selectedCategoryIndex, difficulty: selectedDifficulty.rawValue)
                                showQuestions = true
                            } label: {
                                HStack{
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: 180, height: 60)
                                        .cornerRadius(15)
                                        .overlay(
                                            Text("Start game!")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        )
                                    Spacer()
                                }
                            }
                            
                        }
                    }.onAppear{
                        if stateController.categoryData == nil{
                            stateController.fetchCategoryData(categoryIndex: selectedCategoryIndex)
                        }
                    }
                }
                
                
                
            }
                
        }
        .fullScreenCover(isPresented: $showQuestions, content: {
         QuestionsView()
        })
        
        }
        
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(StateController())
    }
}
