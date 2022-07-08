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


example(of: "combineLatest") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    
    let observalbe = Observable.combineLatest(left, right) { leftElement, rightElement in
        "\(leftElement) \(rightElement)"
    }
    
    let disposable = observalbe.subscribe(onNext : {value in print(value)})
    
//    print(">Sending a value to Left")
//    left.onNext("hello,")
//    print(">Sending a value to Left")
//    left.onNext("hello???,")
//    print(">Sending a value to right")
//    right.onNext("world")
//    print(">Sending another value to. right")
//    right.onNext("RxSwift")
//    print(">Sending another value to Left")
//    left.onNext("Have a good day,")
    left.onNext("1")
    right.onNext("4")
    right.onNext("5")
    left.onNext("2")
    right.onNext("6")
    left.onNext("3")
    
    left.onCompleted()
    right.onCompleted()
    
    
}
example(of: "COMBINE USER CHOICE AND VALUE") {
    let choice : Observable<DateFormatter.Style> = Observable.of(.short,.long)
    let dates = Observable.of(Date())
    
    let observable = Observable.combineLatest(choice,dates){ format , time -> String in
        let formatter = DateFormatter()
        formatter.dateStyle = format
        return formatter.string(from: time)
    }
    
    observable.subscribe{
        print($0)
    }
}

example(of: "ZIP") {
    enum Weather{
        case cloudy
        case rainny
        case sunny
    }
    let left : Observable<Weather> = Observable.of(.sunny,.cloudy,.rainny,.rainny,.cloudy,.cloudy)
    let right =  Observable.of("KOR","USA","CNA","JPN","TPA")
    let observalbe = Observable.zip(left, right) { weather, country in
        return "It's \(weather) in \(country)"
    }
    observalbe.subscribe(onNext:{
        print($0)
    })
}

example(of: "ZIP - 2") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    
    let observable = Observable.zip(left,right){a,b in
        return a+"-"+b
    }
    observable.subscribe{
        print($0)
    }
    
    left.onNext("sunny")
    right.onNext("lisbon")
    left.onNext("cloudy")
    right.onNext("London")
    left.onNext("cloudy")
    right.onNext("vienna")
    left.onNext("sunny")
}
example(of: "withLatestFrom") {
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()
    
    button.withLatestFrom(textField).subscribe(onNext:{
        print($0)
    })
    
    textField.onNext("App")
    textField.onNext("Appl")
    textField.onNext("Apple")
    button.onNext(())
    textField.onNext("AppleK")
    button.onNext(())
}

example(of: "sample") {
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()
    
    textField.sample(button).subscribe(
        onNext:{print($0)}
    )
    
    textField.onNext("App")
    textField.onNext("Appl")
    textField.onNext("Apple")
    button.onNext(())
    button.onNext(())
    textField.onNext("AppleK")
    button.onNext(())
}
example(of: "amb") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    
    left.amb(right).subscribe(onNext:{print($0)})
    
    // 2
    left.onNext("Lisbon")
    right.onNext("Copenhagen")
    left.onNext("London")
    left.onNext("Madrid")
    right.onNext("Vienna")
    
    left.onCompleted()
    right.onCompleted()
}

example(of: "switchLatest") {
    let one = PublishSubject<String>()
    let two = PublishSubject<String>()
    let three = PublishSubject<String>()
    let source = PublishSubject<Observable<String>>()
    
    source.switchLatest()
        .subscribe(onNext:{
            print($0)
        }).disposed(by: disposeBag)
    //3
    source.onNext(one)
    one.onNext("Some Text from sequence one")
    two.onNext("Some Text from sequence two")
    
    source.onNext(two)
    two.onNext("More Text from sequence two")
    one.onNext("and also from sequence one")
    
    source.onNext(three)
    two.onNext("why don't you see me?")
    one.onNext("I'm alone, help me")
    three.onNext("Hey it's Three i win")
    
    source.onNext(one)
    one.onNext("Nope, It's me, One!")
    
}

example(of: "reduce") {
    let source = Observable.of(1,2,3,4)
    
    source.reduce(0, accumulator: {$0 + $1})
        .subscribe{
            print($0)
        }
}
example(of: "scan") {
    let source = Observable.of(1,2,3,4,5)
    
    source.scan(0, accumulator: {$0+$1})
        .subscribe{
            print($0)
        }
}
