//
//  ViewController.swift
//  Diary
//
//  Created by yangjs on 2022/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var diaryList = [Diary](){
        didSet{
            self.saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
    }
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        //10 좌우위아래 간격생성
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeViewController = segue.destination as? WriteDiaryViewController{
            writeViewController.delegate = self
        }
    }
    
    private func dateToString(date:Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func saveDiaryList(){
        let date = self.diaryList.map{["title": $0.title,
                                       "contents":$0.contents,
                                       "date" : $0.date,
                                       "isStar": $0.isStar
                                    ]}
        let uerDefaults = UserDefaults.standard
        uerDefaults.set(date, forKey: "diaryList")
    }
    private func loadDiaryList(){
        let userDefaults = UserDefaults.standard
        guard let date = userDefaults.object(forKey: "diaryList") as? [[String:Any]] else {return}
        self.diaryList = date.compactMap{
            guard let title = $0["title"] as? String else{ return nil }
            guard let contents = $0["contents"] as? String else{return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStar = $0["isStar"] as? Bool else{return nil}
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }
        self.diaryList.sort{$0.date>$1.date}
    }
    


}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCollectionViewCell else{return UICollectionViewCell()}
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DiaryViewController") as? DiaryDetailViewController else {return}
        vc.diary = self.diaryList[indexPath.row]
        vc.indexPath = indexPath
        vc.delegate=self
        self.navigationController?.pushViewController(vc , animated: true)
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    //Cell의 사이즈를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2)-20, height: 200)
    }
}

extension ViewController : WriteDiaryViewDelegate{
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.collectionView.reloadData()
    }
    
}

extension ViewController : DiaryDetailViewDelegate{
    func didSelectDelete(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.reloadData()
    }
}
