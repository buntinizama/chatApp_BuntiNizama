

import Foundation
import UIKit
public class MessageModel : NSObject{
    
    //Chat Message variables
    var isSendingMessage : Bool = false
    var chatMessage : String = ""
    var messageTime : String = ""
    
    init(dict: NSMutableDictionary)
    {
        self.chatMessage = dict.value(forKey: "message") as! String
        self.messageTime = dict.value(forKey: "createdDateTime") as! String
        if (MyMacro.sharedInstance.getFromPreferences(key: NetworkUtils.UserId) as! Int) == (dict.value(forKey: NetworkUtils.FromUserId) as! Int)
        {
             self.isSendingMessage = true
        }
        else
        {
            self.isSendingMessage = false
        }
    }
}
