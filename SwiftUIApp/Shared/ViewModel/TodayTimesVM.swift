//
//  TodayTimesVM.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 07/07/2020.
//

import Foundation
import SwiftUI

class TodayTimesVM: Identifiable {
    
    let id = UUID()
    
    let todayTimes: TodayTimes
    
    private let zmanim: Zmanim
    
    private var _morning = [[String: String]]()
    private var _noon = [[String: String]]()
    private var _evening = [[String: String]]()
    
    var allData = [[[String: String]]]()
    init(todayTimes: TodayTimes) {
        self.todayTimes = todayTimes
        self.zmanim = self.todayTimes.zmanim!
        
        self.buildData()
    }
    
    func buildData(){
        _morning.append(["alosMa"           : self.zmanim.alosMa!])
        _morning.append(["talisMa"          : self.zmanim.talisMa!])
        _morning.append(["sunrise"          : self.zmanim.sunrise!])
        _morning.append(["sofZmanShemaMa"   : self.zmanim.sofZmanShemaMa!])
        _morning.append(["sofZmanShemaGra"  : self.zmanim.sofZmanShemaGra!])
        _morning.append(["sofZmanTefilaMa"  : self.zmanim.sofZmanTefilaMa!])
        _morning.append(["sofZmanTefilaGra" : self.zmanim.sofZmanTefilaGra!])
        
        allData.append(_morning)
        
        _noon.append(["chatzos"          : self.zmanim.chatzos!])
        _noon.append(["minchaGedolaMa"   : self.zmanim.minchaGedolaMa!])
        _noon.append(["minchaKetanaGra"  : self.zmanim.minchaKetanaGra!])
        _noon.append(["plagMinchaMa"     : self.zmanim.plagMinchaMa!])

        allData.append(_noon)

        _evening.append(["sunset"           : self.zmanim.sunset!])
        _evening.append(["tzeis595_Degrees" : self.zmanim.tzeis595_Degrees!])
        _evening.append(["tzeis850_Degrees" : self.zmanim.tzeis850_Degrees!])
        _evening.append(["tzeis42_Minutes"  : self.zmanim.tzeis42_Minutes!])
        _evening.append(["tzeis72_Minutes"  : self.zmanim.tzeis72_Minutes!])
        
        allData.append(_evening)

    }
    
    var hebDateString: String{
        return self.todayTimes.hebDateString!
    }
    
    var engDateString: String{
        return self.todayTimes.engDateString!
    }
    
    var morning : [[String: String]]{
        return self._morning
    }
    
    var noon : [[String: String]]{
        return self._noon
    }

    var evening : [[String: String]]{
        return self._evening
    }


    

}
