//
//  StopWatchViewController.swift
//  Plus.
//
//  Created by Yongyang Nie on 10/23/17.
//  Copyright © 2017 Yongyang Nie. All rights reserved.
//

import UIKit
import GoogleMobileAds

class StopWatchViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var banner: GADBannerView!
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    @IBAction func startTimer(_ sender: AnyObject) {
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pauseTimer(_ sender: AnyObject) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func resetTimer(_ sender: AnyObject) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
    }
    
    func setupShadow(view: UIView){
        
        view.layer.cornerRadius = 6
        view.layer.shadowRadius = 2.0
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize.init(width: -1.0, height: 3.0)
        view.layer.masksToBounds = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(counter)
        pauseButton.isEnabled = false
        
        setupShadow(view: self.startButton)
        setupShadow(view: self.pauseButton)
        setupShadow(view: self.clearButton)
        
        let adsRemoved = UserDefaults.standard.bool(forKey: "areAdsRemoved")
        if(adsRemoved){
            banner.isHidden = true
        }else{
            banner.adUnitID = "ca-app-pub-7942613644553368/1714159132";
            banner.rootViewController = self;
            banner.load(GADRequest())
        }
    }
    
    @objc
    func UpdateTimer() {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


