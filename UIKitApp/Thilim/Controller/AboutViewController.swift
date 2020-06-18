//
//  AboutViewController.swift
//  Thilim
//
//  Created by Israel Berezin on 06/08/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    //        var elements: [AllThilimDivision] = []

    var loveNames: [String] = []
    var memoreyNames:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightButtonItem = UIBarButtonItem.init(
            title: NSLocalizedString("Close", comment: ""),
            style: .done,
            target: self,
            action: #selector(rightButtonAction)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        if Plist(name: "loveMames") != nil{
            let lovePlist = Plist(name: "loveMames")
            self.loveNames = (lovePlist?.getValuesInPlistFile())! as! [String]
            print(self.loveNames)
        }
        
        if Plist(name: "MemoryMames") != nil{
            let memoryPlist = Plist(name: "MemoryMames")
            self.memoreyNames = (memoryPlist?.getValuesInPlistFile())! as! [String]
            print(self.memoreyNames)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightButtonAction(){
        self.dismiss(animated: true, completion: nil)
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

extension AboutViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return self.loveNames.count
        }
         else{
            return self.memoreyNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AboutTableViewCell"
        
        let cell: AboutTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! AboutTableViewCell
        if (indexPath.section == 0){
            cell.updateCell(cellType: .Lave, text: self.loveNames[indexPath.row])
        }
        else{
            cell.updateCell(cellType: .Memory, text: self.memoreyNames[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "האפליקציה  לזכות"
        }
        else{
            return "ולעילוי  נשמת"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return 0.1
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let tableViewHeaderFooterView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        tableViewHeaderFooterView.textLabel?.textAlignment = .center
        tableViewHeaderFooterView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
}

