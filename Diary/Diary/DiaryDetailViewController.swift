//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by yangjs on 2022/02/21.
//

import UIKit


class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var diary:Diary?
    var indexPath: IndexPath?
    var starBtn:UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(starDiaryNotficifcaiton(_:)),
                                               name: NSNotification.Name("starDiary"),
                                               object: nil)
      
    }
    @objc func starDiaryNotficifcaiton(_ notification:Notification){
        guard let starDiary = notification.object as? [String:Any] else{return}
        guard let isStar = starDiary["isStar"] as? Bool else {return}
        guard let uuidString = starDiary["uuidString"] as? String else {return}
        guard let diary = self.diary else {return}
        if diary.uuidString == uuidString{
            self.diary?.isStar = isStar
            self.configureView()
        }
        
    }
    private func dateToString(date:Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureView(){
        guard let diary = self.diary else{return}
        self.titleLabel.text = diary.title
        self.contentsLabel.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
        self.starBtn = UIBarButtonItem(image: nil, style: .plain, target:self , action: #selector(tapStarBtn(_:)))
        self.starBtn?.image = diary.isStar ? UIImage(systemName: "star.fill"):UIImage(systemName: "star")
        self.starBtn?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starBtn
    }
    
    @objc func tapStarBtn(_ sender:Any){
        guard let isStar = self.diary?.isStar else { return }
        guard let indexPath = indexPath else {
            return
        }
        //self.delegate?.didSelectStar(indexPath: indexPath, isStar: isStar)
        if isStar{
            self.starBtn?.image = UIImage(systemName: "star")
        }else{
            self.starBtn?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        NotificationCenter.default.post(name: NSNotification.Name("starDiary"),
                                        object:[
                                            "diary":self.diary,
                                            "isStar":self.diary?.isStar ?? false,
                                            "uuidString":self.diary?.uuidString
                                            ] ,
                                        userInfo: nil
        )
    }
    @IBAction func tapEditBtn(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {
            return
        }
        guard let indexPath = self.indexPath else {
            return
        }
        guard let diary = diary else {
            return
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification),
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        vc.diaryEditMode = DiaryEditMode.edit(indexPath, diary)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @objc func editDiaryNotification(_ notification:NSNotification){
        guard let diary = notification.object as? Diary else {return}
        self.diary = diary
        self.configureView()
    }
    @IBAction func tapDeleteBtn(_ sender: Any) {
        guard let uuidString = self.diary?.uuidString else {
            return
        }

        NotificationCenter.default.post(name: NSNotification.Name("deleteDiary"), object: uuidString, userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
