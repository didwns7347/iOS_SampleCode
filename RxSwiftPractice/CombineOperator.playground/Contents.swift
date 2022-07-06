import RxSwift

let disposeBag = DisposeBag()
func example(of description: String, action: ()->Void){
    print("\n--- Example of:\(description)---")
    action()
}

example(of: "Start with") {
    let numbers = Observable.of(2,3,4)
    
    let observable = numbers.startWith(100)
    observable.subscribe{
        print($0)
    }.disposed(by: disposeBag)
}


example(of: "Observerble.concet") {
    let first = Observable.of(1,2,3,4)
    let second = Observable.from([5,6,7])
    Observable.concat([first,second]).subscribe{
        print($0)
    }.disposed(by: disposeBag)
}

example(of: "merge") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    
    let source = Observable.of(left.asObserver(), right.asObserver())
    
    source.merge().subscribe{
        print($0)
    }
    
    var lValue = ["A","B","C"]
    var rValue = ["C","D","E"]
    
    repeat{
        switch Bool.random() {
        case true where !lValue.isEmpty:
            left.onNext("Left: " + lValue.removeFirst())
        case false where !rValue.isEmpty:
            right.onNext("RIGHT: " + rValue.removeFirst())
        default:
            break
        }
        
    }while !lValue.isEmpty || !rValue.isEmpty
    
    left.onCompleted()
    right.onCompleted()
}
