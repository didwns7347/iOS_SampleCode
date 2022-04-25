//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by yangjs on 2022/03/29.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore

class CardListViewController: UITableViewController{
    var creditCardList : [CreditCard] = []
 //   var ref: DatabaseReference! //firebase rdb
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TableViewCell Register
        let nibName = UINib(nibName: "CardListCellTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCellTableViewCell")
        //실시간 데이터 베이스 읽기
//        ref = Database.database().reference()
//        ref.observe(.value){ snapshot in
//            guard let value = snapshot.value as? [String:[ String:Any]] else {return}
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String:CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//                self.creditCardList = cardList.sorted{$0.rank<$1.rank}
//                //화면 관련 작업은 메인 쓰레드에서 처리해 주어야한다.
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            }catch let error{
//                print("ERROR JSON parsing: \(error.localizedDescription)")
//            }
//
//        }
        
        //파이어스토어 읽기
        db.collection("creditCardList").addSnapshotListener{snapshot, error in
            guard let document = snapshot?.documents else{
                print("ERROR Firestroe fetching document \(String(describing: error))")
                return
            }
            
            self.creditCardList = document.compactMap{ doc-> CreditCard? in
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                }catch let error{
                    print("ERROR JSON parsing \(error)")
                    return nil
                }
                
            }.sorted{$0.rank<$1.rank}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCellTableViewCell", for: indexPath) as? CardListCellTableViewCell else {return UITableViewCell()}
        cell.rankLabel.text = "\(self.creditCardList[indexPath.row].rank)위"
        cell.craditNameLabel.text = "\(self.creditCardList[indexPath.row].name)"
        cell.promotionLabel.text = "\(self.creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        let imageURL = URL(string:creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        return cell
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세 화면으로 전달
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "CardDetailViewConrtoller") as? CardDetailViewConrtoller else {return}
        detailVC.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailVC, sender: nil)
        //Option1
        let cardID = creditCardList[indexPath.row].id
//        ref.child("Item\(cardID)/isSelected").setValue(true)
//
//        //Option2
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value){[weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String : [String:Any]],
//            let key = value.keys.first else{return}
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
        ///파이어 스토어 데이터 쓰기
        //Option1
        //db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected" : true])
        //Option2 경로 모를때
        db.collection("creditCardList").whereField("id",isEqualTo: cardID).getDocuments { snapshot, error in
            guard let document = snapshot?.documents.first else {return}
            document.reference.updateData(["isSelected" : true])
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //실시간 DB삭제
//            //Option1 경로를 알고 있을때
//            let cardID = creditCardList[indexPath.row].id
//            ref.child("Item\(cardID)").removeValue()
//
//            //Option2 경로를 찾아서 들어갈떄
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value){[weak self] snapshot in
//                guard let self = self, let value = snapshot.value as? [String:[String:Any]], let key = value.keys.first else {return}
//                self.ref.child("\(key)").removeValue()
//
//            }
            /// Firestore 삭제
            //option - 경로알떄
            let cardID = creditCardList[indexPath.row].id
//            db.collection("creditCardList").document("card\(cardID)").delete()
            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, error in
                guard let document = snapshot?.documents.first else{return}
                document.reference.delete()
            }
        }
    }
}
/*
 snapshot 데이터 예시
  
 */
