//
//  ViewController.swift
//  Dentaku
//
//  Created by 西村拓也 on 2021/06/04.
//

import UIKit

class ViewController: UIViewController {

    var numberOnScreen:Int = 0
    var previousNumber:Int = 0
    var performingMath = false
    var operation = 0

    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {

        if performingMath == true {
            label.text = String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
            performingMath = false
        }
        else {
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
        }

    }

    @IBAction func buttons(_ sender: UIButton) {

        if label.text != "" && sender.tag != 11 && sender.tag != 16{
            previousNumber = Int(label.text!)!
            if sender.tag == 12{ // ÷
                label.text = "÷";
            }
            else if sender.tag == 13{  // ×
                label.text = "×";
            }
            else if sender.tag == 14{  // -
                label.text = "-";
            }
            else if sender.tag == 15{  // +
                label.text = "+";
            }
            operation = sender.tag
            performingMath = true;
        }
        else if sender.tag == 16 // = が押された時の処理
        {
            if operation == 12{
                label.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 13{
                label.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 14{
                label.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 15{
                label.text = String(previousNumber + numberOnScreen)
            }
        }
        else if sender.tag == 11{ // C が押された時の処理
            label.text = ""
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
