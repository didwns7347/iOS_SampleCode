//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by yangjs on 2022/02/21.
//

import UIKit
enum DiaryEditMode{
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate:AnyObject{
    func didSelectRegister(diary:Diary)
}

class WriteDiaryViewController: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIBarButtonItem!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    private let datePicker = UIDatePicker()
    private var diaryDate : Date?
    weak  var delegate : WriteDiaryViewDelegate?
    var diaryEditMode : DiaryEditMode = .new

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.confirmBtn.isEnabled = false
        self.configureInputField()
        self.configureEditMode()
    }
    private func dateToString(date:Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureEditMode(){
        switch self.diaryEditMode{
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmBtn.title = "수정"
            
        default:
            break
        }
    }
    private func configureContentsTextView(){
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentTextView.layer.borderColor = borderColor.cgColor
        self.contentTextView.layer.borderWidth = 0.5
        self.contentTextView.layer.cornerRadius = 5.0
        
    }
    
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector( datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR")
        self.dateTextField.inputView = self.datePicker
    }
    
    @IBAction func tappedConfrimButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentTextView.text else {return}
        guard let date = self.diaryDate else {return}
        
        switch self.diaryEditMode {
        case .new:
            let diary = Diary(
                uuidString: UUID().uuidString,
                title: title,
                contents: contents,
                date: date,
                isStar: false
            )
            self.delegate?.didSelectRegister(diary: diary)
           
        case let .edit(indexPath, diary):
            let diary = Diary(
                uuidString: diary.uuidString,
                title: title,
                contents: contents,
                date: date,
                isStar: diary.isStar
            )
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"), object: diary, userInfo: nil)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    @objc private func titleTextFieldDidChange( _ textField: UITextField){
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textFeild:UITextField){
        self.validateInputField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func configureInputField(){
        self.contentTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func validateInputField(){
        self.confirmBtn.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentTextView.text.isEmpty)
    }
}
extension WriteDiaryViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
