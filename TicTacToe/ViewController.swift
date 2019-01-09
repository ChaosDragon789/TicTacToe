//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ethan Chang on 10/29/18.
//  Copyright © 2018 SomeAweApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    
    
    var labelsArray = [GridLabel]()
    var turn = true
    var gameOver = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        labelsArray = [gridLabel0,gridLabel1,gridLabel2,gridLabel3,gridLabel4,gridLabel5,gridLabel6,gridLabel7,gridLabel8]
        
    }
    
    @IBAction func onTappedGridLabel(_ sender: UITapGestureRecognizer) {
        if(!gameOver){
            for test in labelsArray{
                if test.canTap {
                    if turn {
                        if test.frame.contains(sender.location(in:backgroundView)){
                            test.text = "X"
                            test.canTap = false
                            turn = !turn
                        }
                    }else{
                        if test.frame.contains(sender.location(in:backgroundView)){
                            test.text = "O"
                            test.canTap = false
                            turn = !turn
                        }
                    }
                    
                }
            }
        }
        checkForWinner()
    }
    
    func resetGame(){
        for check in labelsArray{
            check.text = ""
            check.canTap = true
        }
        gameOver = false;
        turn = true;
    }
    
    func displayWinningMessage(message: String){
        let alert = UIAlertController(title:message, message:nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Reset", style: .default){
            (action) -> Void in self.resetGame()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        gameOver = true;
    }
    
    func checkForTie(){
        var num = 0;
        for count in labelsArray {
            if count.text == "X" || count.text == "O" {
                num = num + 1
            }
        }
        if labelsArray.capacity == num{
            displayWinningMessage(message: "Tie")
        }
    }
    
    func helpCheck(one:Int, two:Int, three:Int){
        if(labelsArray[one].text != ""){
            if (labelsArray[one].text == labelsArray[two].text) &&
                (labelsArray[three].text == labelsArray[two].text){
                displayWinningMessage(message: "\(labelsArray[one].text ?? "") wins")
            }
        }
    }
    
    func checkForWinner(){
        //rows
        helpCheck(one: 0, two: 1, three: 2)
        helpCheck(one: 3, two: 4, three: 5)
        helpCheck(one: 6, two: 7, three: 8)
        //cols
        helpCheck(one: 0, two: 3, three: 6)
        helpCheck(one: 1, two: 4, three: 7)
        helpCheck(one: 2, two: 5, three: 8)
        //diag
        helpCheck(one: 0, two: 4, three: 8)
        helpCheck(one: 2, two: 4, three: 6)
        checkForTie()
    }
}
