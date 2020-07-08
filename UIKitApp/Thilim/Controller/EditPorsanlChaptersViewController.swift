//
//  EditPorsanlChaptersViewController.swift
//  Thilim
//
//  Created by Israel Berezin on 26/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit




class EditPorsanlChaptersViewController: UIViewController,AddNewChapterViewControllerDelegate {
    
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var numberOfItem: Int = 10
    var isTableEditing :Bool = false
    var allPordanlThilimArray:NSMutableArray = []
    var allThilimDivision: [AllThilimDivision] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ערוך", style: .plain, target: self, action: #selector(addTapped))
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        self.isTableEditing = false;
        self.mainTableView.isEditing = false;
        self.mainTableView.reloadData()
        self.loadDataDromPlist()
        // aaa()
    }
    
    func loadDataDromPlist(){
        if Plist(name: "personThilim") != nil{
            let plist = Plist(name: "personThilim")
            self.allPordanlThilimArray = (plist?.getValuesInPlistFile())!
            
            allThilimDivision = try! AllThilimDivision.loadFromArray(array: self.allPordanlThilimArray as Array<AnyObject>)
            print(allThilimDivision)
            self.mainTableView.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if (self.mainTableView.isEditing){
            if Plist(name: "personThilim") != nil{
                let plist = Plist(name: "personThilim")
                do{
                    try plist?.addValuesToPlistFile(array: self.allPordanlThilimArray)
                }catch{
                    print("can't save file")
                }
            }
            navigationItem.rightBarButtonItem?.title = "ערוך"
        }
        else{
            navigationItem.rightBarButtonItem?.title = "שמור"
        }
        self.isTableEditing = !self.isTableEditing
        self.mainTableView.isEditing = isTableEditing
    }
    
    func takePersonalCheaptersToUser(t : AllThilimDivision) -> String{
        let calendar = NSCalendar.current
        let weeksBetweenStevenotes = calendar.dateComponents([.weekOfYear],
                                                             from: t.birthday,
                                                             to: Date())
        print("weeksBetweenStevenotes: \(weeksBetweenStevenotes)")
        
        let year:Int = (Calendar.current.dateComponents([.year], from: t.birthday, to: Date()).year ?? 0) + 1
        print("year: \(year)")
        
        let start:Int = Int(t.start as String)!
        
        if (start == -1){ // it chapter by birthday
            return "\(year)"
        }
        else{ // it chapter by user selected
            return "\(start)"
        }
    }
    
    func aaa()  {
        if Plist(name: "personThilim") != nil{
            let plist = Plist(name: "personThilim")
            self.allPordanlThilimArray = (plist?.getValuesInPlistFile())!
            self.allPordanlThilimArray.removeObject(at: 0)
            
            do{
                try plist?.addValuesToPlistFile(array: self.allPordanlThilimArray)
            }catch{
                // array1?.write(toFile: destPath!, atomically: true)
            }
            let array3 = plist?.getValuesInPlistFile()
            print(array3!)
        }
    }
}

extension EditPorsanlChaptersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPordanlThilimArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EditPorsanlChaptersCell"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! EditPorsanlChaptersCell
        let t: AllThilimDivision = self.allThilimDivision[indexPath.row]
        cell.name.text = t.end
        cell.chapter.text = self.takePersonalCheaptersToUser(t: t)
        
        let start:Int = Int(t.start as String)!
        if (start == -1){ // it chapter by birthday
            cell.icon.image = #imageLiteral(resourceName: "birthday")
        }
        else{ // it chapter by user selected
            cell.icon.image = #imageLiteral(resourceName: "bookmark")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.allPordanlThilimArray.removeObject(at: indexPath.row)
            self.mainTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromIndexPathItem = self.allPordanlThilimArray[fromIndexPath.row]
        let toIndexPathItem = self.allPordanlThilimArray[toIndexPath.row]
        self.allPordanlThilimArray.replaceObject(at: fromIndexPath.row, with: toIndexPathItem)
        self.allPordanlThilimArray.replaceObject(at: toIndexPath.row, with: fromIndexPathItem)
    }
    
    // AddNew
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNew"
        {
            
            if let destinationVC = segue.destination as? AddNewChapterViewController {
                destinationVC.delegate = self;
            }
        }
    }
    
    func didCloseView(){
        self.loadDataDromPlist();
    }
}


