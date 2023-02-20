//
//  CLLocationSampleProjectTests.swift
//  CLLocationSampleProjectTests
//
//  Created by yangjs on 2022/08/22.
//

import XCTest
import Nimble
import RxSwift
import RxTest

@testable import CLLocationSampleProject

class CLLocationSampleProjectTests: XCTestCase {
    let bag = DisposeBag()
    
    let stubNetwork = LocalNetworkStub()
    var model: LocationInformationModel!
    var viewModel: LocationInformationViewModel!
    var doc : [KLDocument]!
    
    override func setUp() {
        self.model = LocationInformationModel(locationNetwork: stubNetwork)
        self.viewModel = LocationInformationViewModel(model: model)
        self.doc = cvsList
    }
    
    
  
    
    func testSetMapCenter(){
        let scheduler = TestScheduler(initialClock: 0)
        
        let dummyDataEvent = scheduler.createHotObservable([
            .next(0, cvsList)
        ])
        
        let documentData = PublishSubject<[KLDocument]>()
        dummyDataEvent
            .subscribe(documentData)
            .disposed(by: bag)
        
        //Detaillist Cell tap Event
        let itemSelectedEvent = scheduler.createHotObservable([
            .next(1, 0)
        ])
        
        let itemSelected = PublishSubject<Int>()
        itemSelectedEvent.subscribe(itemSelected).disposed(by: bag)
        //좌표 선택
        let selectedItemMapPoint = itemSelected
            .withLatestFrom(documentData){$1[0]}
            .map(model.documentToMTMapPoint)
        
        //초기 좌표
        let initalMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(37.394225), longitude: Double(127.110341)))!
        
        let currentLocationEvent = scheduler.createHotObservable([.next(0, initalMapPoint)])
        
        let initalCurrrentLocation = PublishSubject<MTMapPoint>()
        
        currentLocationEvent.subscribe(initalCurrrentLocation).disposed(by: bag)
        
        //현재위치 버튼 탭
        let currentLocationButtonTapEvent = scheduler.createHotObservable([.next(2, Void()),.next(3, Void())])
        
        let currentLocationButtonTapped = PublishSubject<Void>()
        
        currentLocationButtonTapEvent.subscribe(currentLocationButtonTapped).disposed(by: bag)
        
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(initalCurrrentLocation)
        
        //Merge
        let currentMapCenter = Observable
            .merge(selectedItemMapPoint,initalCurrrentLocation,moveToCurrentLocation)
        let currentMapCenterOberver = scheduler.createObserver(Double.self)
        
        currentMapCenter
            .map{$0.mapPointGeo().latitude}
            .subscribe(currentMapCenterOberver)
            .disposed(by: bag)
        
        scheduler.start()
        
        let secondMapPoint = model.documentToMTMapPoint(doc[0])
        
        expect(currentMapCenterOberver.events).to(
            equal([
                .next(0, initalMapPoint.mapPointGeo().latitude),
                .next(1, secondMapPoint.mapPointGeo().latitude),
                .next(2, initalMapPoint.mapPointGeo().latitude),
                .next(3, initalMapPoint.mapPointGeo().latitude)
            ])
        )
    }
    

}
