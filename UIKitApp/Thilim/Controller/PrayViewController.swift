//
//  PrayViewController.swift
//  Thilim
//
//  Created by Israel Berezin on 19/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

enum PrayerMode: Int {
    case Single=0, Monthly, Weekly, Book, Personal,Spaicel,Elul
}


class PrayViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var selectedMode: PrayerMode = .Single;
    var allThilimDivision: [AllThilimDivision] = []
    var cheaptersToSay : [String] = []
    var selectDay : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        print("PrayerMode = \(selectedMode)")
        allThilimDivision = try! AllThilimDivision.loadFromPlist(selectedMode: self.selectedMode)
        print(allThilimDivision)
        
        let twoFingerPinch:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized))
        self.view.addGestureRecognizer(twoFingerPinch)
        
        let hebDate : String = self.getHebrewDate(date: Date())
        print("hebDate = \(hebDate)")
        
        print(Date().dayNumberOfWeek()!) // 4
        
        //self.getTime()

        self.cheaptersToSay.removeAll()
        var selectedThilim : AllThilimDivision  = self.allThilimDivision[0]
        switch selectedMode  {
        case .Weekly:
            selectDay = (Date().dayNumberOfWeek()!)-1
            selectedThilim = self.allThilimDivision[selectDay!]
            self.buildCheaptersToSayArray(selectDay: selectDay!, t: selectedThilim)
            break
        case .Book:
            selectedThilim = self.allThilimDivision[selectDay!]
            self.buildCheaptersToSayArray(selectDay: selectDay!, t: selectedThilim)
            break
        case .Single:
            
            break
        case .Monthly:
            let parts:Array = hebDate.components(separatedBy: " ")
            selectDay = (Int(parts[0])!)-1
            selectedThilim = self.allThilimDivision[selectDay!]
            if (selectDay == 28){ //check if month is 29 or 30  days
                let hebNextDate : String = self.getHebrewDate(date: self.dateByAddingDays(inDays: 1))
                let parts1:Array = hebNextDate.components(separatedBy: " ")
                let nextDay = (Int(parts1[0])!)-1
                if (nextDay == 0){
                    selectedThilim = self.allThilimDivision[30] // include 29 + 30 days (140-150)
                }
            }
            self.buildCheaptersToSayArray(selectDay: selectDay!, t: selectedThilim)
            break
        case .Personal:
            self.buildPersonalCheaptersToSayArray(allT: self.allThilimDivision)
            break
        case.Elul:
            self.buildElol(allT: self.allThilimDivision);
        default:
            break
        }
        
        self.mainTableView.setNeedsLayout()
        self.mainTableView.layoutIfNeeded()
        self.automaticallyAdjustsScrollViewInsets = false

    }

    func buildElol(allT : Array<AllThilimDivision>){
        let hebDate : String = self.getHebrewDate(date: Date())
        let parts:Array = hebDate.components(separatedBy: " ")
        var selectDay = (Int(parts[0])!)-1
        let selectMonth = parts[1]
        // (todayDate.range(of:"Tishrei") != nil && selectDay < 9)
        if (selectMonth == "Tishrei"){
            selectDay = selectDay + 28
        }
        let start:Int = (selectDay*3) + 1
        let end:Int = start + 2
        for index in start...end {
            self.cheaptersToSay.append("t\(index)")
        }
    }
    
    func buildPersonalCheaptersToSayArray(allT : Array<AllThilimDivision>){
        for t : AllThilimDivision in allT {
            let calendar = NSCalendar.current
            let weeksBetweenStevenotes = calendar.dateComponents([.weekOfYear],
                                                                     from: t.birthday,
                                                                     to: Date())
            print("weeksBetweenStevenotes: \(weeksBetweenStevenotes)")

            let year:Int = (Calendar.current.dateComponents([.year], from: t.birthday, to: Date()).year ?? 0) + 1
            print("year: \(year)")
            
            let start:Int = Int(t.start as String)!

            if (start == -1){ // it chapter by birthday
                if (year != 119){
                    self.cheaptersToSay.append("t\(year)")
                }
                else{
                    self.cheaptersToSay.append("t\(year)")
                    self.cheaptersToSay.append("t\(year)b")
                 }
            }
            else{ // it chapter by user selected
                if (start != 119){
                    self.cheaptersToSay.append("t\(start)")
                }
                else{
                    self.cheaptersToSay.append("t\(start)")
                    self.cheaptersToSay.append("t\(start)b")
                }
             }
        }
    }

    func buildCheaptersToSayArray(selectDay : Int ,t : AllThilimDivision)
    {
        let start:Int = Int(t.start as String)!
        let end:Int = Int(t.end as String)!
        for index in start...end {
            let numberOfChapter = index
            if (index != 119){
                self.cheaptersToSay.append("t\(numberOfChapter)")
            }
            else{
                if (selectedMode != .Monthly){
                    self.cheaptersToSay.append("t\(numberOfChapter)")
                    self.cheaptersToSay.append("t\(numberOfChapter)b")
                }else{
                    if(selectDay == 24){
                        self.cheaptersToSay.append("t\(numberOfChapter)")
                    }
                    else if(selectDay == 25){
                        self.cheaptersToSay.append("t\(numberOfChapter)b")
                    }
                }
            }
        }
        print(self.cheaptersToSay)
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
        return (str)
    }
    
    @objc func pinchRecognized(pinch: UIPinchGestureRecognizer){
        print("Pinch scale: \(pinch.scale)")
        var scale:CGFloat = pinch.scale
        if (scale < 1){ scale = 1 }
        let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        self.view.transform = transform
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateByAddingDays(inDays:NSInteger)->Date{
        let today = Date()
        return Calendar.current.date(byAdding: .day, value: inDays, to: today)!
    }

    // not need now
    func getTime(){
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://www.hebcal.com/converter/?cfg=json&gy=2017&gm=2&gd=26&g2h=1")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json:Dictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        //Implement your logic
                        print(json)
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
   
}


extension PrayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.selectedMode == PrayerMode.Personal{
            return self.cheaptersToSay.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedMode == PrayerMode.Personal{
            return 1
        }
        return self.cheaptersToSay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PrayTableViewCell"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! PrayTableViewCell
        
       // cell.updateCellIWithChapterNumber(chapterNumber: numberOfChapter)
        
        var number:Int = indexPath.row;
        if self.selectedMode == PrayerMode.Personal{
            number = indexPath.section
        }

        let imageName = self.cheaptersToSay[number]
        print("imageName = \(imageName)")
        let image:UIImage = UIImage(named: imageName)!
        cell.cellImage.image = image;
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var number:Int = indexPath.row;
        if self.selectedMode == PrayerMode.Personal{
            number = indexPath.section
        }
        if (self.cheaptersToSay.count > number){
            let imageName = self.cheaptersToSay[number]
            let image:UIImage = UIImage(named: imageName)!
            return (CGFloat(image.size.height/1.8))
        }
        else{
            print("return 0")
            return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.selectedMode == PrayerMode.Personal{
            return allThilimDivision[section].end
        }
        return nil

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.selectedMode == PrayerMode.Personal{
            return 44
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
       // tableViewHeaderFooterView.textLabel.textAlignment = NSTextAlignmentCenter;
        let tableViewHeaderFooterView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        tableViewHeaderFooterView.textLabel?.textAlignment = .center
        tableViewHeaderFooterView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return 0.1
    }
   

    
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    
}

