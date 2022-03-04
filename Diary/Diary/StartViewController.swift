//
//  StartViewController.swift
//  Diary
//
//  Created by yangjs on 2022/02/21.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var diaryList  = [Diary]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: NSNotification.Name("starDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteDiaryNotification(_:)), name: NSNotification.Name("deleteDiary"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.configureCollectionView()
        self.loadStarDiaryList()
    }
    private func dateToString(date:Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    private func loadStarDiaryList(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String:Any]] else {return}
        self.diaryList = data.compactMap{
            guard let uuidString = $0["uuidString"] as? String else {return nil}
            guard let title = $0["title"] as? String else{return nil}
            guard let contents = $0["contents"] as? String else{return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStart = $0["isStar"] as? Bool else{return nil}
            return Diary(uuidString:uuidString ,title: title, contents: contents ,date: date, isStar: isStart)
        }.filter{$0.isStar}.sorted(by: {$0.date>$1.date})
        self.collectionView.reloadData()
    }
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else{return}
        guard let idx = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else {return}
        self.diaryList[idx] = diary
        self.diaryList.sort(by: {$0.date>$1.date})
        self.collectionView.reloadData()
    }
    @objc func starDiaryNotification(_ notification:Notification){
        guard let starDiary = notification.object as? [String:Any] else{return}
        guard let diary = starDiary["diary"] as? Diary else {return}
        guard let isStar = starDiary["isStar"] as? Bool else {return}
    
        if !isStar {
            guard let idx = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else {return}
            self.diaryList.remove(at: idx)
            self.collectionView.deleteItems(at: [IndexPath(row: idx, section: 0)])
        }else{
            self.diaryList.append(diary)
            self.diaryList.sort(by: {$0.date>$1.date})
            self.collectionView.reloadData()
        }
    }
    @objc func deleteDiaryNotification(_ notification: Notification){
        guard let uuidString = notification.object as? String else{return}
        guard let idx = self.diaryList.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaryList.remove(at: idx)
        self.collectionView.deleteItems(at: [IndexPath(row: idx, section: 0)])
    }
}
extension StartViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"starCell", for: indexPath) as? StarCollectionViewCell else {return UICollectionViewCell()}
        cell.titleLabel.text = self.diaryList[indexPath.row].title
        cell.dateLabel.text = self.dateToString(date:  self.diaryList[indexPath.row].date)
        
        return cell
                
    }
}
extension StartViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-20, height: 80)
    }
    
}
extension StartViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DiaryViewController") as? DiaryDetailViewController else {return}
        vc.diary = self.diaryList[indexPath.row]
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
