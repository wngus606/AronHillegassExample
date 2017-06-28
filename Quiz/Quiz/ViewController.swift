//
//  ViewController.swift
//  Quiz
//
//  Created by seo on 2017. 6. 28..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit

// Control layer
class ViewController: UIViewController {
    
    // View layer
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    // Model layer
    let questions: [String] = ["From what is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes",
                             "14",
                             "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        self.currentQuestionIndex += 1
        
        if self.currentQuestionIndex == self.questions.count {
            self.currentQuestionIndex = 0
        }
        
        let question: String = self.questions[self.currentQuestionIndex]
        self.questionLabel.text = question
        self.answerLabel.text = "????"
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = self.answers[self.currentQuestionIndex]
        self.answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionLabel.text = self.questions[self.currentQuestionIndex]
    }
}

