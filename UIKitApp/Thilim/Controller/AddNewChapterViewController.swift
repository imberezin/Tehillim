//
//  AddNewChapterViewController.swift
//  Thilim
//
//  Created by Israel Berezin on 28/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

protocol AddNewChapterViewControllerDelegate {
    func didCloseView()
}

class AddNewChapterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var chapterTextFiled: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var topNavigationBar: UINavigationBar!
    
    @IBOutlet weak var btnChapter: UIButton!
    @IBOutlet weak var btnEnBirthday: UIButton!
    
    @IBOutlet weak var btnHebBirthday: UIButton!
    
    var selectedUserDate:String = ""
    
    var delegate:AddNewChapterViewControllerDelegate?
    
    var allPordanlThilimArray:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextFiled.delegate = self;
        self.chapterTextFiled.delegate = self;
        let hebrew = NSCalendar(identifier: NSCalendar.Identifier.hebrew)
        self.datePicker.maximumDate = Date()
        self.datePicker.calendar = hebrew as Calendar?
        if Plist(name: "personThilim") != nil{
            let plist = Plist(name: "personThilim")
            self.allPordanlThilimArray = (plist?.getValuesInPlistFile())!
        }
        self.btnChapter.isSelected = true
        self.addDoneButton()
        self.hideDatePiker(animate: false)
        // Do any additional setup after loading the view.
    }
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.chapterTextFiled.inputAccessoryView = keyboardToolbar
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didCloseView()
        }
    }
    
    
    @IBAction func save(_ sender: Any) {
        var dic :Dictionary =  [String : Any]()
        
        if (self.btnHebBirthday.isSelected || self.btnEnBirthday.isSelected){
            dic["Start"] =  "-1"
            dic["End"] =  self.nameTextFiled.text;
            if (self.selectedUserDate.count > 0){
                dic["birthday"] = self.selectedUserDate
            }
            else{
                //dateFormatter.dateFormat = "MM-dd-yyyy" //Your New Date format as per requirement change it own
                dic["birthday"] = "01-01-1900"
            }
            
        }
        else{
            dic["Start"] =  self.chapterTextFiled.text;
            dic["End"] =  self.nameTextFiled.text;
            if (self.selectedUserDate.count > 0){
                dic["birthday"] = self.selectedUserDate
            }
            else{
                //dateFormatter.dateFormat = "MM-dd-yyyy" //Your New Date format as per requirement change it own
                dic["birthday"] = "01-01-1900"
            }
        }
        
        self.allPordanlThilimArray.add(dic)
        if (!(self.nameTextFiled.text?.isEmpty)!){
            if !(self.chapterTextFiled.text?.isEmpty)!{
                if Plist(name: "personThilim") != nil{
                    let plist = Plist(name: "personThilim")
                    do{
                        try plist?.addValuesToPlistFile(array: self.allPordanlThilimArray)
                    }catch{
                        print("can't save file")
                    }
                    self.dismiss(animated: true) {
                        self.delegate?.didCloseView()
                    }
                }
                
            }
            else{
                TosastBarMenager.sharedInstance.showToastBarMessage(text: "אנא מלא את כל  השדות בדף", color: .Red, showOnView: self.view)
                print("chapterTextFiled is empty ")
            }
        }
        else{
            TosastBarMenager.sharedInstance.showToastBarMessage(text: "אנא מלא את כל  השדות בדף", color: .Red, showOnView: self.view)
            
            print("nameTextFiled is empty ")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func enBirthdaySelected(_ sender: Any) {
        self.btnChapter.isSelected = false
        self.btnHebBirthday.isSelected = false
        self.btnEnBirthday.isSelected = true
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        self.datePicker.calendar = gregorian as Calendar?
        self.showDatePiker(animate: true)
        self.chapterTextFiled.text = ""
        self.view.endEditing(true)
       //self.chapterTextFiled.keyboardType = UIKeyboardType.default
        self.chapterTextFiled.inputView  = UIView.init()
;//self.datePicker;
    }
    
    @IBAction func habBirthdaySelected(_ sender: Any) {
        self.btnChapter.isSelected = false
        self.btnHebBirthday.isSelected = true
        self.btnEnBirthday.isSelected = false
        let hebrew = NSCalendar(identifier: NSCalendar.Identifier.hebrew)
        self.datePicker.calendar = hebrew as Calendar?
        self.showDatePiker(animate: true)
        self.chapterTextFiled.text = ""
        self.view.endEditing(true)
        self.chapterTextFiled.inputView  = UIView.init()


    }
    
    @IBAction func singelChapterSelected(_ sender: Any) {
        self.btnChapter.isSelected = true
        self.btnHebBirthday.isSelected = false
        self.btnEnBirthday.isSelected = false
        self.hideDatePiker(animate: true)
        self.chapterTextFiled.text = ""
        self.chapterTextFiled.inputView = nil;
    }
    
    @IBAction func didChangePickerValue(_ sender: Any) {
        let pickr = sender as! UIDatePicker
        
        self.selectedUserDate = self.getGregorianDate(date: pickr.date)
        
        self.chapterTextFiled.text = self.getHebrewDate(date: pickr.date)
        
        print(self.chapterTextFiled.text as Any)
    }
    
    public func getHebrewDate(date:Date) -> String {
        let hebrew = NSCalendar(identifier: NSCalendar.Identifier.hebrew)
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.short
        
        formatter.timeStyle = DateFormatter.Style.short
        
        formatter.calendar = hebrew as Calendar?
        
        formatter.locale = Locale(identifier: "en")
        let str:String = formatter.string(from: date as Date)
        print(str)
        
        let str1:String = formatter.string(from: date as Date)
        print(str1)
        
        return (str)
    }
    
    public func getGregorianDate(date:Date) -> String {
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.short
        
        formatter.timeStyle = DateFormatter.Style.short
        
        formatter.calendar = gregorian as Calendar?
        
        formatter.locale = Locale(identifier: "en")
        
        formatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        
        let str:String = formatter.string(from: date as Date)
        
        print(str)
        
        let dateString = str
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        dateFormatter.locale = Locale.init(identifier: "Il")
        
        let dateObj = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let str1:String = "\(dateFormatter.string(from: dateObj!))"
        print("Dateobj: \(str1)")
        return (str1)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func showDatePiker(animate:Bool)  {
        self.datePicker.alpha = 0.0;
        if (animate){
            UIView.animate(withDuration: 0.3, animations: { 
                self.datePicker.alpha = 1.0;
            })
        }
        else{
            self.datePicker.alpha = 1.0;
        }
    }
    
    func hideDatePiker(animate:Bool)  {
        self.datePicker.alpha = 1.0;
        if (animate){
            UIView.animate(withDuration: 0.3, animations: {
                self.datePicker.alpha = 0.0;
            })
        }
        else{
            self.datePicker.alpha = 0.0;
        }
    }
}

