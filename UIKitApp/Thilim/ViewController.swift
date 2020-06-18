//
//  ViewController.swift
//  Thilim
//
//  Created by Israel Berezin on 19/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var pikerview: PikerView!
    @IBOutlet weak var mainTableView: UITableView!
    var prayerTypes : Array = ["Single","Monthly","Weekly","Book","Personal","Edit Personal", "About"]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "תהילים"
        
        
        let todayDate:String = self.getHebrewDate(date: Date())
        let parts:Array = todayDate.components(separatedBy: " ")
        let selectDay:Int = (Int(parts[0])!)-1
        if todayDate.range(of:"Elul") != nil || (todayDate.range(of:"Tishrei") != nil && selectDay < 9){
            print("exists")
            prayerTypes.insert("Elul", at: 0)
        }
        mainTableView.dataSource = self
        mainTableView.delegate = self
        //                 NotificationCenter.default.post(name: Notification.Name(rawValue: "KDeepLinkingActionNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(insertToDeepLink(_:)), name: NSNotification.Name(rawValue: "KDeepLinkingActionNotification"), object: nil)
    }

    public func getHebrewDate(date:Date) -> String {
        let hebrew = NSCalendar(identifier: NSCalendar.Identifier.hebrew)
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.short
        
        formatter.timeStyle = DateFormatter.Style.short
        
        formatter.calendar = hebrew as Calendar!
        
        formatter.locale = Locale(identifier: "en")
        let str:String = formatter.string(from: date as Date)
        
        print(str)
        return (str)
    }
        
    func insertToDeepLink(_ notification: Notification){
        if let deepLinkingPage = notification.userInfo?["DeepLinkingPage"] as? String{
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())

            switch deepLinkingPage {
            case "Monthly":
                self.openPrayViewControllerWIthPrayerMode(plaerMode: .Monthly, selectItem: 0)
            case "Personal":
                self.openPrayViewControllerWIthPrayerMode(plaerMode: .Personal, selectItem: 0)
            case "Weekly":
                self.openPrayViewControllerWIthPrayerMode(plaerMode: .Weekly, selectItem: 0)
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // this func in this case replace tableView:didSelectRowAtInedxPath becuse i use "segue" in storyboared from cell to load new app.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCounterSegue"
        {
            let sclectedCell : IndexPath = self.mainTableView.indexPathForSelectedRow! // as! NSIndexPath
            
            if let destinationVC = segue.destination as? PrayViewController {
                destinationVC.selectedMode = PrayerMode(rawValue: sclectedCell.row)!
            }
        }
    }
    
    public func openPrayViewControllerWIthPrayerMode(plaerMode:PrayerMode,selectItem:Int){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prayViewController = mainStoryboard.instantiateViewController(withIdentifier: "userProfileController") as! PrayViewController
        prayViewController.selectedMode = plaerMode
        prayViewController.selectDay = selectItem
        self.navigationController!.pushViewController(prayViewController, animated: true)
    }
    
    public func openSingleCheapterViewControllerWith(selectItem:Int){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prayViewController = mainStoryboard.instantiateViewController(withIdentifier: "SingleCheapterViewController") as! SingleCheapterViewController
        prayViewController.selectDay = (selectItem + 1)
        self.navigationController!.pushViewController(prayViewController, animated: true)
    }
    
    public func openaboutViewController(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prayViewController = mainStoryboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        let navigationVC = UINavigationController(rootViewController: prayViewController)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
   
    
    // EditPorsanlChaptersViewController
    public func editPorsanlChaptersViewController(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prayViewController = mainStoryboard.instantiateViewController(withIdentifier: "EditPorsanlChaptersViewController") as! EditPorsanlChaptersViewController
        self.navigationController!.pushViewController(prayViewController, animated: true)
    }
    
    
    public func showPikerViewWithPikerMode(pikerMode:PikerMode){
       // var mode:
        self.pikerview.updatePikerUI(pikerMode: pikerMode)
        self.pikerview.delegate = self;
        self.pikerview.showPiker()
    }
    
   
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MainTableViewCell"

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! MainTableViewCell
        let text : NSString = NSLocalizedString(prayerTypes[indexPath.row] , comment:"") as NSString
        cell.cellTitle?.text = text as String
        cell.cellType = prayerTypes[indexPath.row] 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // solve: If you touch a cell, it remains gray
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndexPath = indexPath;
        let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell

        switch cell!.cellType {
        case "Single":
            self.showPikerViewWithPikerMode(pikerMode: .SingleMode)
            break
            
        case "Monthly":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.openPrayViewControllerWIthPrayerMode(plaerMode: .Monthly, selectItem: 0)
            break

        case "Weekly":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.openPrayViewControllerWIthPrayerMode(plaerMode: .Weekly, selectItem: 0)
            break
        case "Book":
            self.showPikerViewWithPikerMode(pikerMode: .BookMode)
            break
        case "Personal":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.openPrayViewControllerWIthPrayerMode(plaerMode: .Personal, selectItem: 0)
            break
        case "Spaicel":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.openPrayViewControllerWIthPrayerMode(plaerMode: .Spaicel, selectItem: 0)
            break
         
        case "Edit Personal":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.editPorsanlChaptersViewController()
            break
            
        case "About":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.openaboutViewController()
            break
            
        case "Elul":
            self.pikerview.cancelPicker(sender: UIBarButtonItem.init())
            self.openPrayViewControllerWIthPrayerMode(plaerMode: PrayerMode.Elul, selectItem: 0)
            break
        default:
            
          break
        }
    }
    
}



extension ViewController : PikerViewDelegate {
    internal func didSelectRow(row: Int, pikerMode: PikerMode) {
        print("selected in piker : \(row)")
        
        switch pikerMode {
        case .BookMode:
            self.openPrayViewControllerWIthPrayerMode(plaerMode: .Book, selectItem: row)
            break
        case .SingleMode:
            self.openSingleCheapterViewControllerWith(selectItem: row)
            break
          
        }
        self.pikerview.cancelPicker(sender: UIBarButtonItem.init())

    }
}
