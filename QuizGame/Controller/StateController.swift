//
//  StateController.swift
//  QuizGame
//
//  Created by Joachim Michaelsen on 16/03/2023.
//

import Foundation


class StateController: ObservableObject {
    @Published var categories: [Category] = []
    @Published var categoryData: CategoryData?
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: String?
    
    //Necessary so that the answers dont shuffle again when the view reloads.
    @Published var shuffledAnswers: [String] = []
    
    @Published var points = 0
    @Published var finished = false
    
    
    init(){
        fetchCategories()
    }
    
    func fetchCategories(){
        guard let categoryUrl = URL(string: "https://opentdb.com/api_category.php") else {return}
        
        
        Task(priority: .high){
            
            guard let rawCategoryData = await NetworkService.getData(from: categoryUrl) else {return}
            let decoder = JSONDecoder()
            
            do{
                let result = try decoder.decode(TriviaCategories.self, from: rawCategoryData)
                DispatchQueue.main.async {
                    self.categories = result.categories
                }
                
            } catch {
                fatalError("The conversion from JSON failed.")
            }
            
            
        }
    }
    
    func fetchCategoryData(categoryIndex: Int){
        guard let questionUrl = URL(string: "https://opentdb.com/api_count.php?category=\(categories[categoryIndex].id)") else {return}
        
        Task(priority: .background){
            
            guard let rawCategoryData = await NetworkService.getData(from: questionUrl) else {return}
            let decoder = JSONDecoder()
            
            do{
                let result = try decoder.decode(CategoryData.self, from: rawCategoryData)
                
                DispatchQueue.main.async {
                    self.categoryData = result
                }
                
            } catch {
                fatalError("The conversion from JSON failed.")
            }
            
            
        }
    }
    
    
    
    func fetchQuestions(categoryIndex: Int, difficulty: String){
        
        guard let questionUrl = URL(string: "https://opentdb.com/api.php?amount=10&category=\(self.categories[categoryIndex].id)&difficulty=\(difficulty.lowercased())") else {return}
        
        Task(priority: .high){
            
            guard let rawQuestionData = await NetworkService.getData(from: questionUrl) else {return}
            let decoder = JSONDecoder()
            
            do{
                let result = try decoder.decode(QuestionResult.self, from: rawQuestionData)
                DispatchQueue.main.async {
                    self.questions = result.results
                    self.shuffledAnswers = result.results[0].shuffledAnswers
                    
                }
                
            } catch {
                fatalError("The conversion from JSON failed.")
            }
            
            
        }
    }
    
    
    func submitAnswer(answer: String){
        self.selectedAnswer = answer
        
        if (answer == questions[currentQuestionIndex].correctAnswer){
            points += 1
        }
    }
    
    func nextQuestion(){
        
        if (currentQuestionIndex + 1 < questions.count){
            
            currentQuestionIndex += 1
            
            selectedAnswer = nil
            
            shuffledAnswers = questions[currentQuestionIndex].shuffledAnswers
            
        } else {
            finished = true
        }
    }
    
    func quizEnded(){
        
        questions.removeAll()
        
        selectedAnswer = nil

        currentQuestionIndex = 0
        
        finished = false
        
        points = 0
    }

}
