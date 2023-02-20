//
//  CenterNetwork.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import Foundation
import Combine

class CenterNetwork{
    private let session : URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCenterList() -> AnyPublisher<[Center], URLError> {
        guard let url = api.getCenterListComponents().url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url:url)
        request.setValue("Infuser CReHH2W1xapqQuf/tNNAm2XM2mF4/kMqtlWBrhtbtUDeCePTUgTkpba/RRMc4+lSz5cfhchkHo0x0D2xhU/Q3A==", forHTTPHeaderField:"Authorization")
        
        return session.dataTaskPublisher(for: request)
            .tryMap({ data,response in
                guard let httpResponse = response as? HTTPURLResponse else{
                    throw URLError(.unknown)
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 400..<500:
                    throw URLError(.clientCertificateRejected)
                case 500..<600:
                    throw URLError(.badServerResponse)
                default:
                    throw URLError(.unknown)
                }
            })
            .decode(type: CenterAPIResponse.self, decoder: JSONDecoder())
            .map{$0.data}
            .mapError { error in
                error as! URLError
            }
            .eraseToAnyPublisher()
           
    }
}
