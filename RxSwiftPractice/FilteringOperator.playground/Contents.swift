import RxSwift

func example(of description: String, action: ()->Void){
    print("\n--- Example of:\(description)---")
    action()
}
let disposeBag = DisposeBag()
example(of: "ignoreElements") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes
        .ignoreElements()
        .subscribe{ event in
            print(event,"you are out")
        }.disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("EGGEG")
    strikes.onCompleted()
}

example(of: "element at ") {
    let strikes = PublishSubject<String>()

    
    strikes.element(at: 2)
        .subscribe(
            onNext:{
                print($0)
            }
        ).disposed(by: disposeBag)
    strikes.onNext("first")
    strikes.onNext("second")
    strikes.onNext("third")
}

example(of: "filter") {
    Observable.of(1,2,3,4,5,6,7)
        .filter{ $0%2 == 0}
        .subscribe{
            print($0)
        }.disposed(by: disposeBag)
}


example(of: "skip") {
    Observable.of("A","B","C","D","E","F")
        .skip(3)
        .subscribe{
            print($0)
        }.disposed(by: disposeBag)
}

example(of: "skipWhile") {
    Observable.of(2,3,2,2,2,3,4,4,2)
        .skip { num in
            num % 2 == 0
        }.subscribe{
            print($0)
        }.disposed(by: disposeBag)
}
/*
 prints
 --- Example of:skipWhile---
 next(3)
 next(4)
 next(4)
 next(2)
 completed
 */
example(of: "skipUntil") {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject.skip(until: trigger)
        .subscribe{
            print($0)
        }.disposed(by: disposeBag)
    
    subject.onNext("A")
    subject.onNext("B")
    subject.onNext("C")
    trigger.onNext("TRIGGER ON")
    subject.onNext("D")
    subject.onNext("E")
}


example(of: "take") {
    Observable.of(1,2,3,4,5,6)
        .take(3)
        .subscribe{
            print($0)
        }.disposed(by: disposeBag)
}


example(of: "takeWhile") {
    Observable.of(2,2,4,4,6,6,2)
        .enumerated()
        .takeWhile{ index, element in
            print(index,element)
            return element % 2 == 0 && index<5
        }.map { element in
            element.element
        }.subscribe{
            print($0)
        }.disposed(by: disposeBag)
}

example(of: "takeLast") {
    Observable.of(1,2,3,4,5,6,7,8)
        .takeLast(3)
        .subscribe{
            print($0)
        }.disposed(by: disposeBag)
}

example(of: "distinctUntilChanged") {
    Observable.of("A","A","B","B","C","D","E")
        .distinctUntilChanged()
        .subscribe{
            print($0)
        }
        .disposed(by: disposeBag)
}


example(of: "distinctUntilChaged") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    Observable<NSNumber>.of(10,110,20,200,210,310)
        .distinctUntilChanged { a,b in
            print("a=\(formatter.string(from: a)!), b=\(formatter.string(from: b)!)")
            guard let aword = formatter.string(from: a)? .components(separatedBy: " "),
                  let bword = formatter.string(from: b)?.components(separatedBy: " ")
            else {return false}
            
            var containsMatch = false
            for aword in aword where bword.contains(aword){
                containsMatch = true
                break
            }
            return containsMatch
        }.subscribe{
            print($0)
        }.disposed(by: disposeBag)
}

Observable.of(1,2,3,4,5)
    .filter { num in
        return num != 1
    }.filter { num in
        return num % 2 == 0
    }.subscribe{
        print($0)
    }.disposed(by: disposeBag)


var start = 0
class ShareExample{
    
    var start = 0
    func getStart()->Int
    {
        start += 1
        return start
    }
}
let exp = ShareExample()
let numbers = Observable<Int>.create { observer in
    let start = exp.getStart()
    observer.onNext(start)
    observer.onNext(start+1)
    observer.onNext(start+2)
    observer.onCompleted()
    return Disposables.create()
}
numbers
    .subscribe(
        onNext:{
            print($0)
        }
        ,onCompleted: {print("COMPLETED")}
    )
numbers
    .subscribe(
        onNext: { el in
            print(el)
        },
        onCompleted: {
            print("Completed")
        }
    )
