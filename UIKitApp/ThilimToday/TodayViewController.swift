//
//  TodayViewController.swift
//  ThilimToday
//
//  Created by Israel Berezin on 07/08/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    var prayerTypes : NSArray = ["Personal","Monthly","Weekly"]
    var activeDisplayMode: NCWidgetDisplayMode = NCWidgetDisplayMode.compact
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var mainTableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        self.mainTableVIew .reloadData()
        completionHandler(NCUpdateResult.newData)
    }
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize){
        self.activeDisplayMode = activeDisplayMode
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize;
        }
        else {
            self.preferredContentSize = CGSize(width: 0, height: 150);
        }
        self.mainTableVIew .reloadData()
    }
}

extension TodayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.activeDisplayMode == NCWidgetDisplayMode.compact{
            return (prayerTypes.count - 1)

        }
        return prayerTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MainTableViewCell"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! MainTableViewCell
        let text : NSString = NSLocalizedString(prayerTypes[indexPath.row] as! String, comment:"") as NSString
        cell.cellTitle?.text = text as String
        cell.cellType = prayerTypes[indexPath.row] as! String
        print (cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // solve: If you touch a cell, it remains gray
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndexPath = indexPath;
        let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell
        
        switch cell!.cellType {
        case "Monthly":
            extensionContext?.open(URL(string: "TestThilim://Monthly")! , completionHandler: nil)
            break
            
        case "Personal":
            extensionContext?.open(URL(string: "TestThilim://Personal")! , completionHandler: nil)

        case "Weekly":
            extensionContext?.open(URL(string: "TestThilim://Weekly")! , completionHandler: nil)
            break
            
        default:
            
            break
        }
    }
    
}
