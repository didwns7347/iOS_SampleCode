//
//  LocalNetwork.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/22.
//

import Foundation
import RxSwift
class LocalNetwork{
    private let session : URLSession
    let api  = localAPI()
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func getLocation(by mapPoint:MTMapPoint) -> Single<Result<LocationData,URLError>>{
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        var requset = URLRequest(url: url)
        requset.httpMethod = "GET"
        requset.setValue("KakaoAK 3610720d008792182010b2dd2ef139a5", forHTTPHeaderField: "Authorization")

        return session.rx.response(request: requset as URLRequest)
            .map{response ,data -> Result<LocationData,URLError> in
                switch response.statusCode{
                case 200:
                    do{
                        let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                        return Result.success(locationData)
                    }catch
                    {
                        print(error.localizedDescription)
                        return Result.failure(URLError(.cannotParseResponse))
                    }
                default:
                    return Result.failure(URLError(.cannotLoadFromNetwork))
                }
            }
            .asSingle()
        
    }
}
