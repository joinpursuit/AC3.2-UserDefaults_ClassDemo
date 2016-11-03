//
//  InstaCat.swift
//  AC3.2-InstaCats-2
//
//  Created by Louis Tur on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit


struct InstaCat {
  let name: String
  let catID: Int
  let instagramURL: URL
  
  init(name: String, id: Int, instagramURL: URL) {
    self.name = name
    self.catID = id
    self.instagramURL = instagramURL
  }
  
  public var description: String {
    return "Nice to me you, I'm \(self.name)"
  }
}

// MARK: - CodingInstaCat
// See http://nshipster.com/nscoding/ for more info

/**
 In order to implement and use `NSCoding`, your object must inherit from `NSObject` (InstaCat is a struct, which
 is why we have to create this separate class). To conform properly to `NSCoding`, you need to implement `init?(coder:)` and
 `encode(with:)`.
 
 `init?(coder:)` is used to create new `CodingInstaCats` from an instance of `NSCoder` (and in this case it ends up being the
  NSCoder subclass `NSKeyedUnarchiver()`)
 
 `encode(with:)` is used to define how the class should be serialized. 
 
  Both these functions together server to code and decode an object so that it can be serialized and converted to Data to
  be stored in UserDefaults.
*/
class CodingInstaCat: NSObject, NSCoding {
  var name: String!
  var catID: Int!
  var instagramURL: URL!
  
  convenience init(name: String, catID: Int, instagramURL: URL) {
    self.init()
    
    self.name = name
    self.catID = catID
    self.instagramURL = instagramURL
  }
  
  override init() {
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard
      let name = aDecoder.decodeObject(forKey: "name") as? String,
      let id = aDecoder.decodeObject(forKey: "id") as? Int,
      let url = aDecoder.decodeObject(forKey: "url") as? URL
    else {
        print("error occurred while decoding")
        return nil
    }
    
    self.init(name: name, catID: id, instagramURL: url)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.catID, forKey: "id")
    aCoder.encode(self.instagramURL, forKey: "url")
  }
  
  
}
