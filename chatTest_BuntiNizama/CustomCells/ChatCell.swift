
import UIKit

class ChatCell: UITableViewCell {
   // Outlets for label chat message and image bubble for sender and receive
    @IBOutlet weak var lblChatMsgReceiver: UILabel!
    @IBOutlet weak var bubbleImgSender: UIImageView!
    @IBOutlet weak var lblChatMsgSender: UILabel!
    @IBOutlet weak var bubbleImgReceiver: UIImageView!
   
    //Constraints to set width of lbl message for sender and receive
    @IBOutlet var widthConstraintForlblMsgSender: NSLayoutConstraint!
    @IBOutlet var widthConstraintForlblMsgReceiver: NSLayoutConstraint!
    
    //Constraints to set width of bubble Image for sender and receiver
    @IBOutlet var widthConstraintForBubbleImgMsgSender: NSLayoutConstraint!
    @IBOutlet var widthConstraintForBubbleImgMsgReceiver: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        //Hide all labels and images initially
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setChatDataWithMessage(msgModel : MessageModel)
    {
        //get names from message message if have
        self.showHideBubbleAndImageForSender(sender: msgModel.isSendingMessage)

        if msgModel.isSendingMessage
        {
            self.lblChatMsgSender.text = msgModel.chatMessage
            self.lblChatMsgSender.sizeToFit()
            let width = msgModel.chatMessage.width(withConstrainedHeight: self.lblChatMsgSender.frame.size.height, font: self.lblChatMsgSender.font)
            if width > 200{
                widthConstraintForlblMsgSender.constant = 200
            }else{
                widthConstraintForlblMsgSender.constant = width + 20
//                widthConstraintForlblMsgSender.constant = msgModel.chatMessage.width(withConstrainedHeight: self.lblChatMsgSender.frame.size.height, font: self.lblChatMsgSender.font) + 20
            }
            setImageForMe(isMe: true, height: Float(msgModel.chatMessage.height(withConstrainedWidth: self.lblChatMsgSender.frame.size.width , font: self.lblChatMsgSender.font)))
            widthConstraintForBubbleImgMsgSender.constant = widthConstraintForlblMsgSender.constant + self.lblChatMsgReceiver.frame.origin.x + 10
            self.layoutSubviews()
            
        }else{
            self.lblChatMsgReceiver.text = msgModel.chatMessage
            self.lblChatMsgReceiver.sizeToFit()
            let width = msgModel.chatMessage.width(withConstrainedHeight: self.lblChatMsgReceiver.frame.size.height, font: self.lblChatMsgReceiver.font)
            if width > 200{
                widthConstraintForlblMsgReceiver.constant = 200
            }else{
                widthConstraintForlblMsgReceiver.constant = width + 20// nameMentions.width(withConstrainedHeight: self.lblChatMsgReceiver.frame.size.height, font: self.lblChatMsgReceiver.font) + 20
            }
            setImageForMe(isMe: false, height: Float(msgModel.chatMessage.height(withConstrainedWidth: self.lblChatMsgReceiver.frame.size.width , font: self.lblChatMsgReceiver.font)))
            widthConstraintForBubbleImgMsgReceiver.constant = widthConstraintForlblMsgReceiver.constant + self.lblChatMsgReceiver.frame.origin.x + 10
            self.layoutSubviews()
        }
        self.layoutIfNeeded()
    }
    
    //Un hide controls based on message type
    func showHideBubbleAndImageForSender(sender : Bool)
    {
        self.bubbleImgSender.isHidden = !sender
        self.lblChatMsgSender.isHidden = !sender
        self.bubbleImgReceiver.isHidden = sender
        self.lblChatMsgReceiver.isHidden = sender
    }
    //set bubble image and position
    func setImageForMe(isMe : Bool,height : Float){
        let marginLeft: CGFloat = 5
        let marginRight: CGFloat = 0
        //Bubble positions
        var bubble_x: CGFloat = 0.0
        let bubble_y: CGFloat = 0
        var bubble_width: CGFloat = 0.0
        
        let bubble_height: Float = min(height + 8, Float(lblChatMsgSender.frame.origin.y + lblChatMsgSender.frame.size.height + 6))
        if isMe
        {
            bubble_x = min(frame.origin.x - marginLeft, lblChatMsgSender.frame.origin.x - 2 * marginLeft)
            bubbleImgSender.image? = UIImage(named: "BubbleSender")!.stretchableImage(withLeftCapWidth: 21, topCapHeight: 14)
            
            bubble_width = contentView.frame.size.width - bubble_x - marginRight
            bubbleImgSender.frame = CGRect(x: bubble_x, y: bubble_y, width: bubble_width, height: CGFloat(bubble_height))
            bubbleImgSender.autoresizingMask = autoresizingMask
        }
        else
        {
            bubble_x = marginRight
            bubbleImgReceiver.image? = UIImage(named: "BubbleReceiver")!.stretchableImage(withLeftCapWidth: 21, topCapHeight: 14)
            bubble_width = max(frame.origin.x + frame.size.width + marginLeft, lblChatMsgReceiver.frame.origin.x + lblChatMsgReceiver.frame.size.width + 2 * marginLeft)
            bubbleImgReceiver.frame = CGRect(x: bubble_x, y: bubble_y, width: bubble_width , height: CGFloat(bubble_height))
            bubbleImgReceiver.autoresizingMask = autoresizingMask
        }
        
    }
    
}


