//
//  Question.swift
//  Quizzler
//
//  Created by Amirthy Tejeshwar on 10/06/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question{
    
    let questionText : String
    let correctAnswer : Bool
    
    init(text : String, correctAnswer : Bool){
        self.questionText = text
        self.correctAnswer = correctAnswer
    }
    
}
