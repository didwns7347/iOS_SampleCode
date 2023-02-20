//
//  RxTestSample.swift
//  CLLocationSampleProjectTests
//
//  Created by yangjs on 2022/11/21.
//

import XCTest
import Nimble
import RxSwift
import RxTest
//@testable import CLLocationSampleProject
final class RxTestSample: XCTestCase {
    let bag = DisposeBag()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let scheduler = TestScheduler(initialClock: 0)
        //let coldObservalbe = scheduler.createColdObservable([.next(1, "A"), .next(2, "B"), .next(3, "C")])
        let hotObservable = scheduler.createHotObservable([.next(1,"A"), .next(2, "B"), .next(3, "C")])
        
        let observer = scheduler.createObserver(String.self)
        
        
        hotObservable.subscribe(observer).disposed(by: bag)
        scheduler.start()
        
        expect(observer.events).to(equal([.next(1,"A"),.next(2,"B"), .next(3,"C")]))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
