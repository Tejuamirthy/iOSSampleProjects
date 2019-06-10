
import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    var pickedAnswer : Bool = false
    let allQuestions : QuestionBank = QuestionBank()
    var questionNumberIndex : Int = 0
    var score : Int  = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        }else if sender.tag  == 2{
            pickedAnswer = false
        }
        checkAnswer()
        
        questionNumberIndex = questionNumberIndex + 1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
      
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumberIndex+1)/13"
        
        progressBar.frame.size.width = (view.frame.size.width/13)*CGFloat(questionNumberIndex+1)
        
    }
    

    func nextQuestion() {

        if questionNumberIndex <= 12 {
            questionLabel.text = allQuestions.list[questionNumberIndex].questionText
            updateUI()
        }
        else{
            
            let alert : UIAlertController = UIAlertController(title: "Very fast!", message: "You have completed the quiz. Do you want to restart it?", preferredStyle:.alert)
            
            let alertAction :UIAlertAction = UIAlertAction(title: "Restart", style: .default, handler : { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(alertAction)
            
            present(alert,animated : true,completion : nil)
            
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer : Bool = allQuestions.list[questionNumberIndex].correctAnswer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct Answer!")
            score = score + 1
        }
        else {
            ProgressHUD.showError("Wrong Answer")
        }
    
    }
    
    
    func startOver() {
        questionNumberIndex = 0
        score = 0
        nextQuestion()
    }
    

    
}
