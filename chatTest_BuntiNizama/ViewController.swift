//
//  ViewController.swift
//  chatTest_BuntiNizama
//
//  Created by Bunti Nizama on 3/21/18.
//  Copyright © 2018 BuntiNizama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInTepped(_ sender: Any)
    {
        if txtUserName.text?.count == 0
        {
            MyMacro.showAlert(title: "Empty", Message: "Please Enter UserName", buttonText: "Ok", viewController: self)
            return;
        }
        
        if txtUserName.text?.containsWhitespace == true
        {
            MyMacro.showAlert(title: "Error", Message: "UserName not contain splace", buttonText: "Ok", viewController: self)
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let dict:NSMutableDictionary  = NSMutableDictionary()
        dict.setValue(txtUserName.text, forKey: NetworkUtils.Name)
        dict.setValue(NetworkUtils.LoginAPI, forKey: NetworkUtils.APIName)
        
        NetworkUtils.postApiCall(params: dict as! Dictionary<String, String>) { (status, dict) in
            
            DispatchQueue.main.async
                {
                    MyMacro.sharedInstance.saveToPreferences(dict.value(forKey: NetworkUtils.Token) as! String as AnyObject, ForKey: NetworkUtils.Token)
                    MyMacro.sharedInstance.saveToPreferences(dict.value(forKey:NetworkUtils.UserId) as AnyObject, ForKey: NetworkUtils.UserId)
                    MyMacro.sharedInstance.saveToPreferences(dict.value(forKey: NetworkUtils.Name) as! String as AnyObject, ForKey: NetworkUtils.Name)
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    self.navigateToUserListPage()
            }
        }
    }
    
    
    func navigateToUserListPage()
    {
        
        txtUserName.text = ""
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let userList = storyboard.instantiateViewController(withIdentifier: "UserListViewController")
        
        //Navigate to chatVC
        self.navigationController?.pushViewController(userList, animated: true)
    }
    
}



