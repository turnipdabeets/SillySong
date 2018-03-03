//
//  ViewController.swift
//  Silly Song
//
//  Created by Anna Garcia on 3/3/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        self.nameField.text = ""
//        self.lyricsView.text = ""
    }
    @IBAction func displayLyric(_ sender: Any) {
        if nameField.text == "" {
           self.lyricsView.text = "Please Enter A Name For A Silly Song!"
        }else {
           self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, name: nameField.text!)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func shortenName(name: String) -> Substring {
    let name = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiouy")
    // remove extra characters only to compare with vowelSet
    let cleanName = name.folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
    
    if let index = cleanName.rangeOfCharacter(from: vowelSet)?.lowerBound {
        return name[index...]
    }
    return ""
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func lyricsForName(lyricsTemplate: String, name: String) -> String {
    let shortName = shortenName(name: name)
    return lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: name).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
}

