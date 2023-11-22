//
//  headsetModel.swift
//  HeadPhones
//
//  Created by Inyene Etoedia on 27/10/2023.
//

import Foundation
import SceneKit

struct HeadsetModel: Equatable {
    var id = UUID().uuidString
    var name: String
    var subName: String
    var title: String
    var subtitle: String
    var node: String
    var scene: SCNScene?
    
    static var headsets: [HeadsetModel] = [

        HeadsetModel(name: "iphone15.scn", subName:"airpod2.scn", title: "iPhone 15 Pro", subtitle: "This is a iPhone 15 test", node: "iphone15", scene: SCNScene(named: "iphone15.scn")),
        HeadsetModel(name: "iphone14.scn", subName:"jbl_sound.scn", title: "iPhone 14 Pro", subtitle: "This is a iPhone 14 test", node: "iphone14", scene: SCNScene(named: "iphone14.scn")),
    ]
    
    static func == (lhs: HeadsetModel, rhs: HeadsetModel) -> Bool {
            return lhs.id == rhs.id
        }
}

var headset: [HeadsetModel] = [
    
    

//    HeadsetModel(name: "iphone12.scn", title: "iPhone 12", subtitle: "This is a headset test", node: "iphone12", scene: SCNScene(named: "iphone12.scn") ),
//  HeadsetModel(name: "iphone14.scn", title: "iPhone 14 Pro", subtitle: "This is a headset test", node: "iphone14", scene: SCNScene(named: "iphone14.scn")),
//  HeadsetModel(name: "iphone15.scn", title: "iPhone 15 Pro", subtitle: "This is a headset test", node: "iphone15", scene: SCNScene(named: "iphone15.scn")),
    
    
//    HeadsetModel(name: "Gameboy Challenge", title: "Gameboy Challenge, Lorem Ipsum is not", subtitle: "This is a Gameboy Challenge test", node: "challenge", scene: SCNScene(named: "Game_Boy_Challenge.scn")),
//    
//    HeadsetModel(name: "Gameboy Advanced", title: "Gameboy Advanced, Lorem Ipsum is not", subtitle: "This is a Gameboy Advanced test", node: "advanced", scene: SCNScene(named: "gameboy_advanced.scn")),
//    
//    HeadsetModel(name: "Gameboy Classic", title: "Gameboy Classic, Lorem Ipsum is not", subtitle: "This is a Gameboy Classic test", node: "classic", scene: SCNScene(named: "Gameboy_Classic.scn")),
//    
//    HeadsetModel(name: "Steam Deck", title: "Steam Deck, Lorem Ipsum is not", subtitle: "This is a Steam Deck test", node: "steam", scene: SCNScene(named: "Steam_Deck_console.scn")),
    
    

  

]

var dummytext = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum "


extension HeadsetModel {
    static func model() -> HeadsetModel {
        return HeadsetModel(name: "iphone12.scn", subName:"jbl_sound.scn", title: "Bangs Pro", subtitle: "This is a headset test", node: "iphone12", scene: SCNScene(named: "iphone12")!)
    }
}


