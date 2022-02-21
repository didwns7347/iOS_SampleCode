//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by yangjs on 2022/02/21.
//

import UIKit
protocol DiaryDetailViewDelegate:AnyObject{
    func didSelectDelete(indexPath:IndexPath)
}
class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    weak var delegate:DiaryDetailViewDelegate?
    
    var diary:Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

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
    }
    @IBAction func tapEditBtn(_ sender: Any) {
    }
    
    @IBAction func tapDeleteBtn(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }

        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}
