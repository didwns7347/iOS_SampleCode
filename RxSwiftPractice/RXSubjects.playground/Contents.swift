import RxSwift

var greeting = "Hello, playground"
func example(of description: String, action: ()->Void){
    print("\n--- Example of:\(description)---")
    action()
}
example(of: "PublisSubject") {
    let subject = PublishSubject<String>()
    subject.onNext("Is anyone Listening?")
    let subscriptionOne = subject.subscribe(
        onNext: {print($0)}
    )
    subject.on(.next("1"))
    subject.onNext("2")
    
    let subTwo = subject.subscribe{
        print("2)",$0)
    }
    
    subject.onNext("3")
    subscriptionOne.dispose()
    subject.onNext("4")
    
    subject.onCompleted()
    
    subject.onNext("5")//none print
    subTwo.dispose()
    
    let disposeBag = DisposeBag()
    
    subject.subscribe{
        print("3)",$0.element ?? $0)
    }.disposed(by: disposeBag)
    subject.onNext("?")//nonprint
}



enum MyError:Error{
    case anError
}
example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value:"Initial value")
    let disposeBag = DisposeBag()
    
    subject.onNext("X")
    
    subject.subscribe{
        print("1)",$0)
    }.disposed(by: disposeBag)
    
    subject.onError(MyError.anError)
    
    subject.subscribe{
        print("2)",$0)
    }.disposed(by: disposeBag)
}



example(of: "replaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    
    subject.subscribe{
        print("1)",$0)
    }.disposed(by: disposeBag)
    
    subject.subscribe{
        print("2)",$0)
    }.disposed(by: disposeBag)
    
    subject.onNext("4")
    subject.onError(MyError.anError)
    //subject.dispose()
    
    subject.subscribe{
        print("3)",$0)
    }.disposed(by: disposeBag)
}
