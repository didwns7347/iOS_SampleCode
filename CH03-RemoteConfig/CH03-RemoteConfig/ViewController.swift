//
//  ViewController.swift
//  CH03-RemoteConfig
//
//  Created by yangjs on 2022/03/31.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    var remoteConfig : RemoteConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        //새로운 값을 위한 패치 시간 최소화
        setting.minimumFetchInterval=0
        
        remoteConfig?.configSettings = setting
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNotice()
    }


}
//RemoteConfig
extension ViewController {
    func getNotice(){
        guard let remoteConfig = remoteConfig else {
            return
        }
        remoteConfig.fetch { [weak self] status ,_  in
            if status == .success{
                remoteConfig.activate(completion: nil)
            }else{
                print("ERROR: config not fetched")
            }
            
            guard let self = self else {return}
            
            if !self.isNoticeHidden(remoteConfig){
                let noticeVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                noticeVC.modalPresentationStyle = .custom
                noticeVC.modalTransitionStyle = .crossDissolve
                //remoteConfig.allKeys(from: <#T##RemoteConfigSource#>)
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                noticeVC.noticeContent = (title:title, detail:detail, date:date)
                self.present(noticeVC,animated: true,completion: nil)
                
            }else{
                self.showEventAlert()
            }
        }
    }
    
    func isNoticeHidden(_ remoteConfig: RemoteConfig)->Bool{
        return remoteConfig["isHidden"].boolValue
    }
}
//A/B testing
extension ViewController{
    func showEventAlert(){
        guard let remoteConfig = remoteConfig else {
            return
        }
        remoteConfig.fetch { [weak self] status ,_  in
            if status == .success{
                remoteConfig.activate(completion: nil)
            }else{
                print("ERROR: config not fetched")
            }
            
            guard let self = self else {return}
            
            
            

            let message = (remoteConfig["message"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
            let confirmaction = UIAlertAction(title:"확인하기",style: .default) {_ in
                //Google Analytics
                Analytics.logEvent("promotion_alert", parameters: nil)
                
            }
      
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            let alertController = UIAlertController(title: "깜짝이벤트", message:message, preferredStyle: .alert)
            
            alertController.addAction(confirmaction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
         
        }
    }
}
