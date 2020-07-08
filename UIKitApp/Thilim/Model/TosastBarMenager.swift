//
//  TosastBarMenager.swift
//  Thilim
//
//  Created by Israel Berezin on 06/03/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

enum BgColor: Int {
    case Red=0, Grean, Yellow
}
class TosastBarMenager: NSObject {

    static let sharedInstance = TosastBarMenager()
    var toastView:UIView?
    var isShowNow:Bool? = false
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    func showToastBarMessage(text:String, color:BgColor, showOnView:UIView) {
        
        guard self.isShowNow == false else {
            return;
        }
        self.toastView = UIView(frame: CGRect(x: 0, y: 70, width: showOnView.frame.width, height: 40))
        switch color {
        case .Red:
            self.toastView?.backgroundColor = UIColor.red
            break
        case .Grean:
            self.toastView?.backgroundColor = UIColor.green
            break
        case .Yellow:
            self.toastView?.backgroundColor = UIColor.yellow
            break
        default:
            self.toastView?.backgroundColor = UIColor.green
            break
        }
        let textLable : UILabel = UILabel(frame: CGRect(x: 0, y: 10, width: showOnView.frame.width, height: 20))
        textLable.textAlignment = .center
        textLable.text = text
        self.toastView?.addSubview(textLable)
        showOnView.addSubview(self.toastView!)
        self.animateInView()
    }
    
    func animateInView(){
        self.isShowNow = true;
        self.toastView?.alpha = 0;
        UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
            self.toastView?.alpha = 1;

        }) { (finished: Bool) in
            Timer.scheduledTimer(timeInterval: 3.0,
                                 target: self,
                                 selector: #selector(self.adjustmentBestSongBpmHeartRate(_:)),
                                 userInfo: nil, 
                                 repeats: false)

        }
    }
    
    @objc func adjustmentBestSongBpmHeartRate(_ timer: Timer) {
        self.animateOutView()
    }
    
    func animateOutView(){ // (showView:UIView, onView:UIView){
        self.toastView?.alpha = 1.0;
        UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
            self.toastView?.alpha = 0.0;
            
        }) { (finished: Bool) in
            self.toastView?.removeFromSuperview()
            self.isShowNow = false
        }
    }

}


