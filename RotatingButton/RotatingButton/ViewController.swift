//
//  ViewController.swift
//  RotatingButton
//
//  Created by Pratik on 01/03/20.
//

import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var knobVolume: RotatingButton!
    @IBOutlet weak var knobPan: RotatingButton!
    
    @IBOutlet weak var lblTextVolume: UILabel!
    @IBOutlet weak var lblTextPan: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        knobVolume.addTarget(self, action:#selector(volumeValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        knobPan.addTarget(self, action:#selector(panVolumeChanged), for: UIControl.Event.valueChanged)
        
    }

    @objc func volumeValueChanged(_ sender: Any) {
        
        lblTextVolume.text = "Volume : \((Double(knobVolume.volume)).rounded(toPlaces: 2))"
        
    }
    
    
    @objc func panVolumeChanged(_ sender: Any) {
        lblTextPan.text = "Pan : \((Double(knobPan.pan)).rounded(toPlaces: 2))"
    }


}

