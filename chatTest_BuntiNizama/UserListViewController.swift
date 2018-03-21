//
//  UserListViewController.swift
//  chatTest_BuntiNizama
//
//  Created by Bunti Nizama on 3/21/18.
//  Copyright © 2018 BuntiNizama. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet var tblView: UITableView!
    
    var userListArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //get user list from server
        self.getUsers()
    }

    
    func getUsers()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let dict:NSMutableDictionary  = NSMutableDictionary()
        dict.setValue(NetworkUtils.GetUsers, forKey: NetworkUtils.APIName)
         NetworkUtils.GetAPI(apiName: NetworkUtils.GetUsers) { (status, arrayOfUsers) in
            DispatchQueue.main.async
            {
                    print(arrayOfUsers)
                    self.userListArray = arrayOfUsers
                    self.tblView.reloadData()
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            }
        }
    }
    
    
    // MARK: UITableView delegate
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return displayArray.count+1
        return userListArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "CELL")
        }
        let user = userListArray[indexPath.row] as! NSDictionary
        cell?.textLabel?.text = user.value(forKey: "name") as! String
        
        return cell!
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let chatObj = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatObj.selectedUser = userListArray[indexPath.row] as! NSMutableDictionary
        //Navigate to chatVC
        self.navigationController?.pushViewController(chatObj, animated: true)
        
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
