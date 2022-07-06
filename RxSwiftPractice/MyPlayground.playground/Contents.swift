import Foundation
import RxSwift
public func example(of description: String, action: ()->()){
    print("\n ---- Example of : \(description) ------")
    action()
}

example(of: "Create") {
    let disposeBag = DisposeBag()
    
    let observable = Observable<String>.create{ observer -> Disposable in
        observer.onNext("1")
        observer.onCompleted()
        observer.onNext("?")
        return Disposables.create()
    }
    observable.subscribe{event in
        print(event)
    }
}
