import RxSwift

let disposeBag = DisposeBag()
let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap{
        //$0.asObserver()
        $0
    }
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)
subject.onNext(a)
subject.onNext(b)

