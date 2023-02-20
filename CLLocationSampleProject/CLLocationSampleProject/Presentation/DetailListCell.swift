//
//  DetailListCell.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/19.
//

import Foundation


class DetailListCell : UITableViewCell{
    let placeNameLabel = UILabel()
    let addressLabel = UILabel()
    let distanceLabel = UILabel()
    static let id = "detailListCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: DetailListCellData){
        placeNameLabel.text = data.placeName
        addressLabel.text = data.roadAddressName
        distanceLabel.text = data.distance
    }
    
    private func attribute(){
        backgroundColor = .systemBackground
        placeNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray
        
        distanceLabel.font = .systemFont(ofSize: 12, weight: .light)
        distanceLabel.textColor = .darkGray
        
    }
    private func layout(){
        [placeNameLabel,addressLabel,distanceLabel].forEach{
            contentView.addSubview($0)
        }
        
        
        
        placeNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(18)
        }
        
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(placeNameLabel.snp.leading)
            make.bottom.equalToSuperview().inset(12)
        }
        
        distanceLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
        
    }
    
}
