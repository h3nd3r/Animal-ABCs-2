//
//  Util.swift
//  Animal ABCs
//
//  Created by Sara Hender on 2/10/17.
//  Copyright © 2017 Sara Hender. All rights reserved.
//

import UIKit
import AVFoundation

class Util: UIView {
    
    var letter = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var letters = ["Aa","Bb","Cc","Dd","Ee","Ff","Gg","Hh","Ii","Jj","Kk","Ll","Mm","Nn","Oo","Pp","Qq","Rr","Ss","Tt","Uu","Vv","Ww","Xx","Yy","Zz"]
    var animals = ["alligator", "bear", "cat", "dog", "elephant", "flamingo", "giraffe", "horse", "iguana", "jaguar", "kangaroo", "llama", "monkey", "numbat", "owl", "pig", "quail", "rabbit", "snake", "tiger", "urial", "vulture", "walrus", "xenops", "yak", "zebra"]
    var pictures = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var colors = ["006633","FF0000","FF9900","FF33FF","669900","3333CC","FFFF33","9933FF","FF3300","33FFCC","33CC00","FFCC00","FF3399","33CCFF","FFFF00","FFCCFF","33FF00","6633FF","FF99CC","CCFF99","FF9900","6699FF","FF0000","FFFF99","CC33FF","FFFF00"]
    var players = [AVAudioPlayer?]()
    var sounds = ["a-alligator","b-bear","c-cat","d-dog","e-elephant","f-flamingo","g-giraffe","h-horse","i-iguana","j-jaguar","k-kangaroo","l-llama","m-monkey","n-numbat","o-owl","p-pig","q-quail","r-rabbit","s-snake","t-tiger","u-urial","v-vulture","w-walrus","x-xenops","y-yak","z-zebra"]
    var thumbs = ["as","bs","cs","ds","es","fs","gs","hs","is","js","ks","ls","ms","ns","os","ps","qs","r","s","t","us","vs","ws","xs","ys","zs"]
    static let sharedInstance: Util = {
        let instance = Util()
        
        // setup code
        
        return instance
    }()
    
    func stop(count: Int) {
        if (players.count != 0) {
            players[count]?.stop()
            players[count]?.currentTime = 0
        }
    }
    
    func play(count: Int) {
        print(#function)

        // lazy init
        if (players.count == 0) {
            var player: AVAudioPlayer?
            for i in 0..<sounds.count {
                if let sound = NSDataAsset(name: sounds[i]) {
                    do {
                        player = try AVAudioPlayer(data: sound.data)
                        guard let player = player else { return }
                        players.append(player)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }

        players[count]?.prepareToPlay()
        players[count]?.play()
    }
    
    func cellSize() -> CGSize {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        print("\(#function) width: \(width), height:\(height)");
        return CGSize(width: 100, height: 100)
    }
}

extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
