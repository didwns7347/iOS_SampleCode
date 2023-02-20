//
//  SelectRegionViewModel.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import Foundation
import Combine

class SelectRegionViewModel : ObservableObject{
    @Published var centers = [Center.Sido:[Center]]()
    private var cancellable = Set<AnyCancellable>()//disposeBag
    
    init(centerNetwork:CenterNetwork = CenterNetwork()){
        centerNetwork.getCenterList()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {[weak self] in
                    guard case .failure(let error) = $0 else {return}
                    print(error.localizedDescription)
                    self?.centers = [Center.Sido : [Center]]()
                },
                receiveValue: { [weak self] centers in
                    self?.centers = Dictionary(grouping: centers, by: {$0.sido})
                }
            )
            .store(in: &cancellable)//disposed(by:bag) 
    }
}
