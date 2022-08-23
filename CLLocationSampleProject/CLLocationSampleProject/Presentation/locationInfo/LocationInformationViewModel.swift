//
//  LocationInformationViewModel.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/19.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa


struct LocationInformationViewModel{
    
    let bag = DisposeBag()
    //subviewModel
    let detailListBackgroundViewModel = DetailListBackgroundViewModel()
    
  
    
    
    //viewModel -> view
    let setMapCenter : Signal<MTMapPoint>
    let errorMessage : Signal<String>
    let detailListCellData :Driver<[DetailListCellData]>
    let scrollToSelectedLoaction : Signal<Int>
    
    //view-> ViewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    private let documentData = PublishSubject<[KLDocument]>()
    
    init(model: LocationInformationModel = LocationInformationModel()){
        //MARK: 네트워크 통신으로 데이터 불러오기
        let cvsLocationDataResult = mapCenterPoint
            .flatMapLatest(model.getLocation)
            .share()
        
        let cvsLocationDataValue = cvsLocationDataResult
            .compactMap { data -> LocationData? in
                guard case let .success(value) = data else {
                    return nil
                }
                return value
            }
        
        let cvsLocationDataErrorMessage = cvsLocationDataResult
            .compactMap { data -> String? in
                switch data{
                case let .success(data) where data.documents.isEmpty:
                    return """
                            500m 근처에 이용할 수 있는 편의점이 없습니다.
                            """
                case let .failure(error):
                    return error.localizedDescription
                default:
                    return nil
                }
            }
        
        cvsLocationDataValue
            .map{$0.documents}
            .bind(to: documentData)
            .disposed(by: bag)
        
        
        //MARK: 지도 중심점 설정
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData){$1[$0]}
            .map{ data -> MTMapPoint in
                guard
                      let longtitue = Double(data.x),
                      let latitude = Double(data.y)
                else{
                    return MTMapPoint()
                }
                let geoCoord = MTMapPointGeo(latitude: latitude, longitude: longtitue)
                return MTMapPoint(geoCoord: geoCoord)
            }
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        //리스트 선택, 최초 받아온값, 버튼 현재위치로 이동할 경우 맵이 이동.
        let currentMapCenter = Observable
            .merge(
                currentLocation.take(1),
                moveToCurrentLocation,
                selectDetailListItem
            )
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = Observable.merge(
            mapViewError.asObservable(),
            cvsLocationDataErrorMessage)
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요")

        
        detailListCellData = documentData
            .map(model.docmuentsToCellData)
            .asDriver(onErrorJustReturn: [])
        
        documentData
            .map{!$0.isEmpty}
            .bind(to: detailListBackgroundViewModel.sholdHideStatusLabel)
            .disposed(by: bag)
        
        scrollToSelectedLoaction = selectPOIItem
            .map{$0.tag}
            .asSignal(onErrorJustReturn: 0)
    }
    
}
