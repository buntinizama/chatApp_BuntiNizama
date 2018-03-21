//
//  ChatViewController.swift
//  chatTest_BuntiNizama
//
//  Created by Bunti Nizama on 3/21/18.
//  Copyright © 2018 BuntiNizama. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController,UITableViewDataSource
{

    var selectedUser : NSMutableDictionary = NSMutableDictionary()
    @IBOutlet weak var txtViewMessage: UITextView!

      @IBOutlet var tblView: UITableView!
    //Array to store chats
    var arrayChatData : [MessageModel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayChatData = [MessageModel]()
        self.getChatFromServer()
        // Do any additional setup after loading the view.
    }
    
    
    func getChatFromServer()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkUtils.GetAPI(apiName:"\(NetworkUtils.GetChat)/\(self.selectedUser.value(forKey: NetworkUtils.UserId)!)") { (status, arrayData) in
            DispatchQueue.main.async
            {
                    print(arrayData)
                    self.convertArrayToModelArray(arrayData: arrayData)
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            }
        }
    }
    
    func convertArrayToModelArray(arrayData : NSMutableArray)
    {
        arrayChatData.removeAll()
        
       for dictData in arrayData
       {
        let msg = MessageModel(dict: dictData as! NSMutableDictionary)
        arrayChatData.append(msg)
        
        }
        tblView.reloadData()
    }
    
    
    
    @IBAction func send()
    {
        
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let dict:NSMutableDictionary  = NSMutableDictionary()
            dict.setValue("\(self.selectedUser.value(forKey: NetworkUtils.UserId)!)", forKey: NetworkUtils.ToUserId)
            dict.setValue(self.txtViewMessage.text, forKey: NetworkUtils.Message)
            self.txtViewMessage.text = ""
            self.view.endEditing(true)
            NetworkUtils.SendChat(apiName:NetworkUtils.GetChat,params: dict as! Dictionary<String, String>) { (status, dict) in
                
                DispatchQueue.main.async
                    {
                        
                        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                       
                         self.getChatFromServer()
                }
                
            }
            
        }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Getting message Model at Index
        let msgModelObj = arrayChatData[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
            // configure cell data
        cell.setChatDataWithMessage(msgModel: msgModelObj)
        cell.tag = indexPath.row
         return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
