//
//  LocalNetworkStub.swift
//  CLLocationSampleProjectTests
//
//  Created by yangjs on 2022/08/22.
//

import Foundation
import RxSwift
import Stubber


@testable import CLLocationSampleProject

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
  
