import UIKit
import RxSwift
import os

print("-------just-------")
Observable<Int>.just(1)
    .subscribe(onNext :{
        print($0)
    })

print("-------of-------")
Observable<Int>.of(1,2,3,4,5,6)
    .subscribe(onNext :{
        print($0)
    })


print("-------of2-------")//타입추론가능
Observable.of([1,2,3,4,5])
    .subscribe(onNext :{
        print($0)
    })


print("-------from-------")//array 원소 방출
Observable.from([1,2,3,4,5])
    .subscribe(onNext :{
        print($0)
    })


print("========subscribe========")
Observable.of(1,2,3)
    .subscribe{
        print($0)
    }
print("========subscribe========")
Observable.of(1,2,3)
    .subscribe{
        if let element = $0.element{
            print(element)
        }
    }


print("========subscribe========")
Observable.of(1,2,3)
    .subscribe(onNext:{
        print($0)
    })

print("========empty========")
Observable.empty()
    .subscribe{
        print($0)
    }
print("========empty VOid========")
Observable<Void>.empty()
    .subscribe{
        print($0)
    }


print("========never========")
Observable.never()
    .subscribe(onNext : {
        print($0)
    },
               onCompleted: {
        print("completed")
    }
    )


print("========range========")
Observable.range(start:1 ,count:9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })


print("==========dispose========")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("==========disposeBag ========")
let disposBag = DisposeBag()
Observable.of(1,2,3)
    .subscribe{
        print($0)
    }
    .disposed(by: disposBag)


print("========CREATE 1=============")
Observable.create{ observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposBag)


print("========CREATE 2=============")
enum MyError : Error{
    case anError
}

Observable.create {observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {print($0)},
    onError: {print($0.localizedDescription)},
    onCompleted: {print("completed")},
    onDisposed: {print("disposed")}
)
.disposed(by: disposBag)


print("-------defferd1------------")
Observable.deferred{
    Observable.of(1,2,3)
}
.subscribe{
    print($0)
}
.disposed(by: disposBag)


print("-------defferd2------------")
var 뒤집기 = false
let factory : Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    if 뒤집기{
        return Observable.of("☝️")
    }else{
        return Observable.of("👎")
    }
}

for _ in 0...3{
    factory.subscribe(onNext:{print($0)}).disposed(by: disposBag)
}
