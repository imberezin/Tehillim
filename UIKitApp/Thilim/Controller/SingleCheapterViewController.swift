//
//  SIngleCheapterViewController.swift
//  Thilim
//
//  Created by Israel Berezin on 26/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

class SingleCheapterViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var btnPreviousChapter: UIButton!
    @IBOutlet weak var btnNextChapter: UIButton!
    
    var selectedMode: PrayerMode = .Single;
    var selectDay : Int = 0

//    var imagesArray = Array<Int>(repeating: Int(), count: 2)
    var cheaptersToSay : [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        let twoFingerPinch:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized))
        self.view.addGestureRecognizer(twoFingerPinch)

        self.buildCheaptersToSayArray()
        
        self.mainTableView.setNeedsLayout()
        self.mainTableView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                self.previousChapter(NSNull.self)
                break
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                break
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                self.nextChapter(NSNull.self)
                break
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                break
            default:
                break
            }
        }
    }

    
    @objc func pinchRecognized(pinch: UIPinchGestureRecognizer){
        print("Pinch scale: \(pinch.scale)")
        var scale:CGFloat = pinch.scale
        if (scale < 1){ scale = 1 }
        let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        self.view.transform = transform
    }
    
    func buildCheaptersToSayArray()
    {
        self.cheaptersToSay.removeAll()
        
        if (self.selectDay != 119){
            let imageName = "t\(self.selectDay)"
            self.cheaptersToSay.append(imageName)
        }
        else{
            var imageName = "t\(self.selectDay)"
            self.cheaptersToSay.append(imageName)
            imageName = "t\(self.selectDay)b"
            self.cheaptersToSay.append(imageName)
        }
        
        print(self.cheaptersToSay)
    }

    @IBAction func nextChapter(_ sender: Any) {
        if (self.selectDay < 150){
            self.selectDay += 1
            
            self.buildCheaptersToSayArray()
            
            self.mainTableView.reloadData()
            self.mainTableView.setNeedsLayout()
            self.mainTableView.layoutIfNeeded()
        }
    }
    
    @IBAction func previousChapter(_ sender: Any) {
        if (self.selectDay > 1){
            self.selectDay -= 1
            self.buildCheaptersToSayArray()

            self.mainTableView.reloadData()
            self.mainTableView.setNeedsLayout()
            self.mainTableView.layoutIfNeeded()
        }
    }
}

extension SingleCheapterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cheaptersToSay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PrayTableViewCell"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! PrayTableViewCell
        
        // cell.updateCellIWithChapterNumber(chapterNumber: numberOfChapter)
        
        let imageName = self.cheaptersToSay[indexPath.row]
        print("imageName = \(imageName)")
        let image:UIImage = UIImage(named: imageName)!
        cell.cellImage.image = image;
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.cheaptersToSay.count > indexPath.row){
            let imageName = self.cheaptersToSay[indexPath.row]
            let image:UIImage = UIImage(named: imageName)!
            return (CGFloat(image.size.height/1.8))
        }
        else{
            print("return 0")
            return 0
        }
    }
}
