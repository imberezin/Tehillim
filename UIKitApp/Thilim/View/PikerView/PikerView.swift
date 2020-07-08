//
//  UIPikerView.swift
//  Thilim
//
//  Created by Israel Berezin on 21/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit
enum PikerMode: Int {
    case SingleMode=0,BookMode
}

protocol PikerViewDelegate {
    func didSelectRow(row:Int , pikerMode:PikerMode)
}


class PikerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var  muteForPickerData: [String] = []
    var selectedRow : Int = 0
    var datePickerView:UIPickerView? = nil
    // MARK:- Delegate
    var delegate:PikerViewDelegate?

    var pagePikerMode:PikerMode?
    
    public func updatePikerUI(pikerMode: PikerMode) {
        
        self.pagePikerMode = pikerMode
        muteForPickerData.removeAll()
        if (pikerMode == .SingleMode)
        {
            for index in 1...150 {
                muteForPickerData.append("\(index)")
            }
        }
        else if (pikerMode == .BookMode){
            for index in 1...5 {
                muteForPickerData.append("\(index)")
            }
        }
        self.createPiker()
    }
    
    func createPiker(){
        if self.datePickerView != nil {
            self.datePickerView?.selectRow(0, inComponent: 0, animated: false)
            self.datePickerView?.reloadAllComponents()
        }
        else
        {
            self.datePickerView = UIPickerView()
            self.datePickerView?.dataSource = self
            self.datePickerView?.delegate = self
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker))
            let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

            let textFiled = UITextField()
            textFiled.frame.size = CGSize(width: 100, height: 44)
            textFiled.backgroundColor = UIColor.white
            textFiled.textColor = UIColor.black
            textFiled.isUserInteractionEnabled  = false
            textFiled.textAlignment = .center
            textFiled.tag = 770;
            let textFiledButton = UIBarButtonItem(customView: textFiled)
            
            toolBar.setItems([cancelButton,spaceButton ,textFiledButton,spaceButton2, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            toolBar.frame = CGRect(origin: CGPoint(x: 0,y :0) , size: CGSize(width: self.frame.width, height: 44) )
            self.datePickerView?.frame = CGRect(origin: CGPoint(x: 0,y :45) , size: CGSize(width: self.frame.width, height: (self.datePickerView?.frame.height)!))
            
            self.addSubview(self.datePickerView!)
            
            self.addSubview(toolBar)
        }
    }
    
    public func showPiker(){
        self.isHidden = false
    }
    
    @objc public func donePicker (sender:UIBarButtonItem)
    {
        delegate?.didSelectRow(row: self.selectedRow, pikerMode: self.pagePikerMode!)
        self.isHidden = true
    }
    
    @objc public func cancelPicker (sender:UIBarButtonItem)
    {
        self.isHidden = true;

    }

}

extension PikerView: UIPickerViewDelegate, UIPickerViewDataSource{
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return muteForPickerData.count
    }

    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selectRow: Int = row
        if let theLabel = self.viewWithTag(770) as? UITextField {
            theLabel.text = muteForPickerData[selectRow]
        }
        return muteForPickerData[selectRow]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let theLabel = self.viewWithTag(770) as? UITextField {
            theLabel.text = muteForPickerData[row]
        }
        self.selectedRow = row
    }
}
