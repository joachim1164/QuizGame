//
//  QuestionsView.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import SwiftUI

struct QuestionsView: View {
    
    @EnvironmentObject var stateController: StateController
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            if stateController.questions.isEmpty {
                
                
                VStack{
                    Text("Loading questions")
                        .font(.title)
                        .foregroundColor(.black)
                    ProgressView()
                }
                
                
            } else {
                
                if stateController.finished {
                    VStack{
                        
                        Spacer()
                        
                            
                        Text("You finished with \(stateController.points) points!")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Text("🥳")
                            .font(.system(size: 100))
                        
                        Spacer()
                            
                        Button {
                            
                            dismiss()
                            
                            stateController.quizEnded()
                            
                        } label: {
                            HStack{
                                Spacer()
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 180, height: 60)
                                    .cornerRadius(15)
                                    .overlay(
                                        Text("Go to main screen")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                                Spacer()
                            }
                        }

                        Spacer()
                        
                    }                    
                    
                } else {
                    VStack{
                        
                        let currentQuestion = stateController.questions[stateController.currentQuestionIndex]
                        
                        VStack{
                            
                            HStack {
                                
                                Text("Question \(stateController.currentQuestionIndex + 1) of \(stateController.questions.count)")
                                    .fontWeight(.bold)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Text("Points: \(stateController.points)")
                                    .fontWeight(.bold)
                                    .padding(.trailing)
                                
                            }
                            .foregroundColor(.black)
                            .padding(.vertical)
                            
                            
                            Text(currentQuestion.question.formatted())
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                       
                        }
                        
                        Spacer()
                        
                        ForEach(stateController.shuffledAnswers, id: \.self) { answer in
                            
                            Button {
                                
                                stateController.submitAnswer(answer: answer)
                                
                            } label: {
                                HStack{
                                    Spacer()
                                    Rectangle()
                                        .fill(Color(hue: 0.727, saturation: 0.886, brightness: 0.593))
                                        .frame(height: 50)
                                        .cornerRadius(10)
                                        .overlay(
                                            Text(answer.formatted())
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(answer == currentQuestion.correctAnswer ? .green : .red, lineWidth: 4)
                                                .opacity(stateController.selectedAnswer == answer || (answer == currentQuestion.correctAnswer && stateController.selectedAnswer != nil) ? 1 : 0)
                                        )
                                    
                                    Spacer()
                                }
                            }
                            .disabled(stateController.selectedAnswer != nil)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            stateController.nextQuestion()
                        } label: {
                            HStack{
                                Spacer()
                                Rectangle()
                                    .fill(stateController.selectedAnswer == nil ? .gray : .black )
                                    .frame(width: 150, height: 60)
                                    .cornerRadius(15)
                                    .overlay(
                                        Text(stateController.currentQuestionIndex + 1 < stateController.questions.count ? "Next question" : "Finish")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                                Spacer()
                            }
                        }
                        .disabled(stateController.selectedAnswer == nil)
                        
                    }
                }
            }
        }
    }
}
