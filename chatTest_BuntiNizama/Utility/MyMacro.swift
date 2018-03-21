//
//  MyMacro.swift
//  chatTest_BuntiNizama
//
//  Created by Bunti Nizama on 3/21/18.
//  Copyright © 2018 BuntiNizama. All rights reserved.
//

import Foundation
import UIKit
class MyMacro: NSObject
{
    static let sharedInstance = MyMacro()
    
    static func showAlert(title : String,Message message: String,buttonText text:String,viewController view:UIViewController )
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: text, style: UIAlertActionStyle.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func saveToPreferences(_ value : AnyObject, ForKey key:String)
    {
        UserDefaults.standard.set("", forKey:key)
        UserDefaults.standard.set(value, forKey:key)
        UserDefaults.standard.synchronize()
        
    }
    
    func getFromPreferences(key:String) -> AnyObject
    {
        return  UserDefaults.standard.value(forKey: key) as AnyObject
    }
    
}




extension String {
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    //calculate height based on string
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    //calculate width based on string
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
