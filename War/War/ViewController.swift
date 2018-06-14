//
//  ViewController.swift
//  War
//
//  Created by DrakeVorndran on 6/11/18.
//  Copyright © 2018 myProjects. All rights reserved.
//

import UIKit
var P1Val = 0
var P2Val = 0
var bank = [String]()
var TotalDeck = ["H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "H11", "H12", "H13", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "S11", "S12", "S13", "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "D11", "D12", "D13", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "C11", "C12", "C13"]
var P1Deck = [String]()
var P2Deck = [String]()
class ViewController: UIViewController {
    @IBOutlet weak var P1Card: UILabel!
    @IBOutlet weak var P2Card: UILabel!
    @IBOutlet weak var P1CardsLeft: UILabel!
    @IBOutlet weak var P2CardsLeft: UILabel!
    @IBOutlet weak var WinLabel: UILabel!
    @IBOutlet weak var BankLabel: UILabel!
    
    override func viewDidLoad() {
        BankLabel.isHidden = false
        super.viewDidLoad()
        TotalDeck = shuffle(cards: TotalDeck)
        P1Deck = [String](TotalDeck[..<26])
        P2Deck = [String](TotalDeck[26...])
        print(P1Deck)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func compareCards(_ sender: Any) {
        var p1 = Array(P1Deck[0])
        var p2 = Array(P2Deck[0])
        P1Val = Int(String(p1[1...]))!
        P2Val = Int(String(p2[1...]))!
        P1Card.text = String(p1)
        P2Card.text = String(p2)
        
        checkWin(p1: P1Val, p2: P2Val)
    }
    
    func checkWin(p1: Int, p2: Int) -> Void {
        bank += [P1Deck[0],P2Deck[0]]
        P1Deck.remove(at:0)
        P2Deck.remove(at:0)
        if(p1>p2){
            BankLabel.isHidden = true
            WinLabel.text = "P1 wins!"
            P1Deck+=bank
            bank = []
        }
        else if(p2>p1){
            BankLabel.isHidden = true
            WinLabel.text = "P2 wins!"
            P2Deck+=bank
            bank = []
        }
        else{
            WinLabel.text = "Tie!"
            BankLabel.isHidden = false
            for _ in 0..<3{
                bank.append(P1Deck[0])
                P1Deck.remove(at:0)
                bank.append(P2Deck[0])
                P2Deck.remove(at:0)
            }
        }
        BankLabel.text = (String(bank.count)+" cards in bank")
        P1CardsLeft.text = ("Cards: "+String(P1Deck.count))
        P2CardsLeft.text = ("Cards: "+String(P2Deck.count))
    }
    func genran(from:Int, to:Int) -> Int{
        return Int(arc4random_uniform(UInt32(to-from)))+from
    }
    func shuffle(cards:[String]) -> [String]{
        var deck = cards
        var temp = ""
        var spot1 = 0
        var spot2 = 0
        for _ in 0..<genran(from:100, to:500){
            spot1 = genran(from: 0 , to: cards.count)
            spot2 = genran(from: 0 , to: cards.count)
            temp = deck[spot1]
            deck[spot1] = deck[spot2]
            deck[spot2] = temp
        }
        return deck
    }
}

