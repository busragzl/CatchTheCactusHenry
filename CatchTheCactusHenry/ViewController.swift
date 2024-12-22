//
//  ViewController.swift
//  CatchTheCactusHenry
//
//  Created by Büşra Gazel on 22.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Views

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var henry1: UIImageView!
    @IBOutlet weak var henry2: UIImageView!
    @IBOutlet weak var henry3: UIImageView!
    @IBOutlet weak var henry4: UIImageView!
    @IBOutlet weak var henry5: UIImageView!
    @IBOutlet weak var henry6: UIImageView!
    @IBOutlet weak var henry7: UIImageView!
    @IBOutlet weak var henry8: UIImageView!
    @IBOutlet weak var henry9: UIImageView!
    
    //Variables
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var henryArray: [UIImageView] = []
    var highScore = 0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //High Score Chech
        
        let storedHighScore = UserDefaults.standard.integer(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
          
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        //Images
        
        henry1.isUserInteractionEnabled = true
        henry2.isUserInteractionEnabled = true
        henry3.isUserInteractionEnabled = true
        henry4.isUserInteractionEnabled = true
        henry5.isUserInteractionEnabled = true
        henry6.isUserInteractionEnabled = true
        henry7.isUserInteractionEnabled = true
        henry8.isUserInteractionEnabled = true
        henry9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        henry1.addGestureRecognizer(recognizer1)
        henry2.addGestureRecognizer(recognizer2)
        henry3.addGestureRecognizer(recognizer3)
        henry4.addGestureRecognizer(recognizer4)
        henry5.addGestureRecognizer(recognizer5)
        henry6.addGestureRecognizer(recognizer6)
        henry7.addGestureRecognizer(recognizer7)
        henry8.addGestureRecognizer(recognizer8)
        henry9.addGestureRecognizer(recognizer9)
        
        
        
        henryArray = [henry1, henry2, henry3, henry4, henry5, henry6, henry7, henry8, henry9]
        
        
        
        //Timer
        
        counter = 10
      
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideHenry), userInfo: nil, repeats: true)
        
        
        hideHenry()
        
    }
    
    @objc func hideHenry() {
       for henry in henryArray {
            henry.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(henryArray.count - 1)))
        henryArray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for henry in henryArray {
                 henry.isHidden = true
             }
            
            //Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            
            // Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again ?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //Replay function
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideHenry), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert,animated: true , completion: nil)
            
        }
    }
    

}

