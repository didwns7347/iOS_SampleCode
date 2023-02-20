//
//  RxBlokingSample.swift
//  CLLocationSampleProjectTests
//
//  Created by yangjs on 2022/11/21.
//

import XCTest
import RxBlocking
import RxSwift
import Nimble

final class RxBlokingSample: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //rxbloking -> observable event -> array 전환
    func testExample() throws {
        //Observable -> BlokingObservable (옵저버블이 컴플리트 되지않아도 타임아웃설정가능함)
        let obervable = Observable.of("1","2","3").toBlocking(timeout: 2)
        
        //Observable의 .next 이벤트를 Array로 전환
        let values = try! obervable.toArray()
        //Nimble의 문법을 활용한
        expect(values).to(equal(["1","2","3"]))
    }
    
    func testCase2() throws{
        expect(1).to(equal(1))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
