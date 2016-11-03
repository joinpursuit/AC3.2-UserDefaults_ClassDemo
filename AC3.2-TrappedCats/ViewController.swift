//
//  ViewController.swift
//  AC3.2-TrappedCats
//
//  Created by Louis Tur on 11/3/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var parsedCatsLabel: UILabel!
  @IBOutlet weak var parsedCatsTextField: UITextView!

  @IBOutlet weak var loadedCatsLabel: UILabel!
  @IBOutlet weak var loadedCatsTextView: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // in class paired programming example
//    self.savePairedProgrammingCats()
    self.loadPairedProgrammingCats()
    
    // my solution
    // self.saveCats()
    // self.loadCats()
    
    // solution storing w. Data
    // self.saveCatsAsData()
    // self.loadCatsAsData()
    
    // solution using NSCoding conformance
    // self.saveCodedCats()
    // self.loadCodedCats()
    
  }
  
  
  // ---------------------------------------------------------------------------------------
  // MARK: - In-Class Paired Demo Solution
  
  // Saving
//  internal func savePairedProgrammingCats() {
//    let defaults = UserDefaults.standard
//    
//    if let instaCats: [InstaCat] = InstaCatFactory.makeInstaCats(fileName: "InstaCats.json") {
//      
//      var defaultDict = [String: String]()
//      
//      for eachCat in 0..<instaCats.count {
//        defaultDict["name\(eachCat)"] = instaCats[eachCat].name
//        defaultDict["id\(eachCat)"] = String(instaCats[eachCat].catID)
//        defaultDict["instagram\(eachCat)"] = instaCats[eachCat].instagramURL.absoluteString
//        defaultDict["description\(eachCat)"] = instaCats[eachCat].description
//      }
//      
//      print(defaultDict) //What would be the last four elements?
//      defaults.set(defaultDict,forKey: "instaCats")
//      
//      parsedCatsTextField.text = "\(defaultDict)"
//    }
//  }
  
  // Loading
  func loadPairedProgrammingCats() {
    let defaults = UserDefaults.standard
    if let defaultsCatDict = defaults.value(forKey: "instaCats") as? [String : String] {
      
      var appendMeMeow = [InstaCat]()
      
      for i in 0..<3 {
          // Returns optional Strings
        guard let name = defaultsCatDict["name\(i)"],
        let id = defaultsCatDict["id\(i)"],
        let instagram = defaultsCatDict["instagram\(i)"],
        let _ = defaultsCatDict["description\(i)"],
      
          // String -> Int && String -> URL
        let IntID = Int(id),
        let instagramURL = URL(string: instagram)
        else { return }
        
        appendMeMeow.append(InstaCat.init(name: name, id: IntID, instagramURL: instagramURL))
        print(appendMeMeow)
      }
      
    }
  }
  
  
  // ---------------------------------------------------------------------------------------
  // MARK: - Saving using Data
  
  // Save
  internal func saveCatsAsData() {
    let defaults = UserDefaults.standard
  
    if let validURL = InstaCatFactory.manager.getResourceURL(from: "InstaCats.json") {
      if let validData = InstaCatFactory.manager.getData(from: validURL) {
        print("Storing out cat data")
        
        self.parsedCatsTextField.text = "Saving cats as data:\n\(validData)"
        defaults.set(validData, forKey: "InstaCatData")
      }
    }
  }
  
  // Load
  internal func loadCatsAsData() {
    let defaults = UserDefaults.standard
    
    if let catData = defaults.value(forKey: "InstaCatData") as? Data {
      if let allCats = InstaCatFactory.getInstaCats(from: catData) {
        print("We've got data cats!")
        
        self.loadedCatsTextView.text = "\(allCats)"
      }
    }
  }
  
  
  // ---------------------------------------------------------------------------------------
  // MARK: - Saving with NSCoding
  
  // Save
  internal func saveCodedCats() {
    let defaults = UserDefaults.standard
    
    if let validURL = InstaCatFactory.manager.getResourceURL(from: "InstaCats.json") {
      if let validData = InstaCatFactory.manager.getData(from: validURL) {
        if let validCodingCats = InstaCatFactory.getCodedInstaCats(from: validData) {
          
          print("Archiving coded cats!")
          self.parsedCatsTextField.text = "\(validCodingCats)"
          
          let data = NSKeyedArchiver.archivedData(withRootObject: validCodingCats)
          defaults.set(data, forKey: "CodingInstaCatss")
        }
      }
    }
  }
  
  // Load
  internal func loadCodedCats() {
    let defaults = UserDefaults.standard
    
    if let catData = defaults.value(forKey: "CodingInstaCatss") as? Data {
      if let codingCatsData = NSKeyedUnarchiver.unarchiveObject(with: catData) as? [CodingInstaCat] {
        print("we've got instacats! \(codingCatsData)")
        
        self.loadedCatsTextView.text = "\(codingCatsData)"
      }
      
    }
  }
  
  
  // ---------------------------------------------------------------------------------------
  // MARK: - My Original Solution
  
  // Saving
  func saveCats() {
    
    let defaults = UserDefaults.standard
    if let instaCats: [InstaCat] = InstaCatFactory.makeInstaCats(fileName: "InstaCats.json") {
      
      var defaultDict: [[String: String]] = [[:]]
      for cat in instaCats {
        var tempCatDict: [String: String] = [:]
        tempCatDict["name"] = cat.name
        tempCatDict["id"] = String(cat.catID)
        tempCatDict["url"] = cat.instagramURL.absoluteString
        
        defaultDict.append(tempCatDict)
      }
      
      defaults.set(defaultDict, forKey: "InstaCats")
      parsedCatsTextField.text = "\(defaultDict)"
    }
    
  }
  
  // loading
  internal func loadCats() {
    let defaults = UserDefaults.standard
    if let allCats = defaults.value(forKey: "InstaCatsKey") as? [[String:String]]{
      
      var textFieldString: String = ""
      for cat in allCats {
        guard let name = cat["name"],
        let idString = cat["id"],
        let urlString  = cat["url"] ,
        
        let id = Int(idString),
        let url = URL(string: urlString)
        else {
            print("Could not make cat")
            return
        }
        
        let newInstaCat = InstaCat(name: name, id: id, instagramURL: url)
        textFieldString.append("\n\(newInstaCat.description)")
      }
      
      self.loadedCatsTextView.text = textFieldString
      
    } else {
        print("could not find any of the cats")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

