//
//  ViewController.swift
//  pomodoro
//
//  Created by yangjs on 2022/03/04.
//

import UIKit
import AudioToolbox
enum TimerStatus{
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var duration = 60
    var timerStatus : TimerStatus = .end
    var timer :DispatchSourceTimer?
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleBtn()
    }
    
    func configureToggleBtn(){
        self.toggleBtn.setTitle("시작", for: .normal)
        self.toggleBtn.setTitle("일시정지", for: .selected)
    }

    @IBAction func tabToggleBtn(_ sender: Any) {
        self.duration = Int(self.datePicker.countDownDuration)
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            self.setTimerInfoVIewVisible(isHidden: false)
            self.datePicker.isHidden = true
            self.toggleBtn.isSelected = true
            self.cancelBtn.isEnabled=true
            self.startTimer()
        case .start:
            self.timerStatus = .pause
            self.toggleBtn.isSelected = false
            self.timer?.suspend()
        case .pause:
            self.timerStatus = .start
            self.toggleBtn.isSelected = true
            self.timer?.resume()
            
        }
            
    }
    
    @IBAction func tabCancelBtn(_ sender: Any) {
        switch self.timerStatus {
        case .start,.pause:
            stopTimer()
        default:
            break
        }
    }
    
    
    func setTimerInfoVIewVisible(isHidden : Bool){
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    func startTimer(){
        if self.timer == nil{
            self.timer = DispatchSource.makeTimerSource(flags: [], queue:DispatchQueue.main)
            self.timer?.schedule(deadline: .now(), repeating: 1.0)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else{return}
                self.currentSeconds -= 1
                let hour = self.currentSeconds/3600
                let minutes = (self.currentSeconds%3600)/60
                let seconds = (self.currentSeconds % 3600)%60
                self.timerLabel.text = String(format: "%02d:%02d:%02d",hour,minutes,seconds)
                self.progressView.progress = Float(self.currentSeconds)/Float(self.duration)
                UIView.animate(withDuration: 0.5, delay: 0) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                }
                UIView.animate(withDuration: 0.5, delay: 0.5) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi*2)
                }
                if self.currentSeconds ?? 0 <= 0 {
                    AudioServicesPlaySystemSound(1005)
                    self.stopTimer()
                 
                }
            })
            self.timer?.resume()
        }
    }
    func stopTimer(){
        if self.timerStatus == .pause{
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.setTimerInfoVIewVisible(isHidden: true)
        self.datePicker.isHidden=false
        self.toggleBtn.isSelected = false
        self.cancelBtn.isEnabled=false
        self.imageView.transform = .identity
        self.timer?.cancel()
        self.timer = nil
        
    }
}

