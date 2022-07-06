import RxSwift

func example(of description: String, action: ()->Void){
    print("\n--- Example of:\(description)---")
    action()
}
example(of: "just"){
    let one = 1
    let two = 2
    let tree = 3
    
    _ = Observable<Int>.just(one).subscribe{
        let sub = $0
        print(sub)
    }
    
    Observable<[Int]>.just([one,tree,two]).subscribe{
        let sub = $0
        print($0)
    }
}


example(of: "of") {
    let one = 1
    let two = 2
    let tree = 3
    
    Observable.of(one,two,tree).subscribe{
        print($0)
    }
    Observable.of([one,two,tree]).subscribe{
        print($0)
    }
    
    //타입을 맞추지 않으면 애러가 발생
//    Observable.of(one,"two",tree).subscribe{
//        print($0)
//    }
}


example(of: "from") {
    Observable.from([1,2,4,5,3]).subscribe{
        print($0)
    }
    Observable.from([1,"2","3"]).subscribe{
        print($0)
    }
}


example(of: "CREATE") {
    let disposeBag = DisposeBag()
    
    let observable = Observable<String>.create { (observer)-> Disposable in
        observer.onNext("1")
        observer.onCompleted()
        observer.onNext("?")
        
        return Disposables.create()
    }
    observable.subscribe{print($0)}.disposed(by: disposeBag)
    
}
example(of: "SUBSCRIBE") {
    let observable = Observable.of(1,2,3)
    
    //구독
    observable.subscribe{
        print($0)
    }
}

example(of: "empty") {
    let observable = Observable<Void>.empty()
    observable.subscribe{
        print($0)
    }

}

example(of: "NEVER") {
    Observable<Void>.never()
        .subscribe{
            print($0)
        }
}

example(of: "RANGE") {
    Observable<Int>.range(start: 1, count: 10).subscribe{
        print($0)
    }
}
example(of: "dispose") {
    let observable = Observable.of("A","B","C")
    let subscription = observable.subscribe{
        print($0)
    }
    
    subscription.dispose()
}


enum MyError : Error{
    case anError
}

example(of: "Craete") {
    let dispose = DisposeBag()
    Observable<String>.create { (observer) -> Disposable  in
        observer.onNext("1")
        observer.onError(MyError.anError)
        observer.onCompleted()
        observer.onNext("?")
        
        return Disposables.create()
    }
    .subscribe { str in
        print(str)
    } onError: { error in
        print(error)
    } onCompleted: {
        print("COMPLETED")
    } onDisposed: {
        print("DISPOSED")
    }.disposed(by: dispose)

}


example(of: "DEFFERD") {
    let disposeBag = DisposeBag()
    var flip = false
    let factory : Observable<Int> = Observable.deferred {
        flip = !flip
        if flip{
            return Observable.of(1,2,3)
        }
        else{
            return Observable.of(4,5,6)
        }
    }
    for _ in 0...3{
        factory.subscribe(
            onNext: {print($0, terminator: "")}
        ).disposed(by: disposeBag)
        print()
    }
}


example(of: "TRAITS-single") {
    let disposeBag = DisposeBag()
    
    enum FileReadError :Error{
        case fileNotFound , unreadable, encodingFailed
    }
    
    func loadText(from name:String)-> Single<String>{
        return Single.create{ single in
            let dispoable = Disposables.create()
            
            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else{
                single(.failure(FileReadError.fileNotFound))
                return dispoable
            }
            guard let data = FileManager.default.contents(atPath: path) else{
                single(.failure(FileReadError.unreadable))
                return dispoable
            }
            
            guard let contents = String(data: data, encoding: .utf8) else{
                single(.failure(FileReadError.encodingFailed))
                return dispoable
            }
            
            single(.success(contents))
            return dispoable
        }
    }
    
    loadText(from: "myFile")
        .subscribe{
            switch $0{
            case .success(let contents):
                print(contents)
            case.failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
}

example(of: "never") {
    let observable = Observable<Any>.never()
    
    let disposeBag = DisposeBag()
    
    observable.do(
        onSubscribe:{print("subscribed")}
    ).subscribe(
        onNext:{print($0)},
        onCompleted: {print("COMPLETED")}
    ).disposed(by: disposeBag)

}
example(of: "never") {
    let observable = Observable<Any>.never()
    let disposeBag = DisposeBag()
    
    observable.debug("NEVER CHECK")
        .subscribe().disposed(by: disposeBag)
}
