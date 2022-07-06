import UIKit
import RxSwift
let disposeBag = DisposeBag()

func example(of description: String, action: ()->Void){
    print("\n--- Example of:\(description)---")
    action()
}

example(of: "toArray") {
    Observable.of(1,2,3,4,6)
        .toArray()
        .subscribe{
            print($0)
        }.disposed(by: disposeBag)
}


example(of :"map")
{
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    Observable.of(123,4,56,78)
        .map{
            formatter.string(from: $0 as! NSNumber)!
        }.subscribe{
            print($0)
        }.disposed(by: disposeBag)
}

example(of: "map + enumereated") {
    Observable.of(1,2,3,4,5,6,7,8)
        .enumerated()
        .map { (index: Int, element: Int)   in
            if index % 3 == 0{
                return (index,element)
            }
            return (index,0)
        }.subscribe(
            onNext:{print($0)}
        ).disposed(by: disposeBag)
}


struct Student{
    var score : BehaviorSubject<Int>
}

example(of: "flatMap") {
    let henrry = Student(score: BehaviorSubject(value: 80))
    let drogba = Student(score: BehaviorSubject(value: 90))
    
    let student = PublishSubject<Student>()
    
    student
        .flatMap{
            $0.score
        }
        .subscribe(
            onNext:{print($0)}
        ).disposed(by: disposeBag)
    
//    student
//        .map{
//            $0.score
//        }.subscribe(
//            onNext:{print($0)}
//        ).disposed(by: disposeBag)
    student.onNext(henrry)
    henrry.score.onNext(85)
    
    student.onNext(drogba)
    henrry.score.onNext(95)
    
    drogba.score.onNext(100)
}

example(of: "flatMap vs Map") {
    Observable<Int>.just(10)
        .map{ element in
            String(element)
        }.subscribe{
            print($0)
        }.disposed(by: disposeBag)
    
    Observable<Int>.just(10)
        .flatMap { element in
            Observable<String>.just(String(element))
        }.subscribe{
            print($0)
        }.disposed(by: disposeBag)
}

example(of :"faltMapLatest"){
    let js = Student(score: BehaviorSubject(value: 80))
    let jh = Student(score: BehaviorSubject(value: 90))
    
    let student = PublishSubject<Student>()
    
    student
        .flatMapLatest{
            $0.score
        }.subscribe(
            onNext:{print($0)}
        ).disposed(by: disposeBag)
    
    student.onNext(js)
    js.score.onNext(85)
    student.onNext(jh)
    
    js.score.onNext(95)
    jh.score.onNext(100)
}

example(of: "meterialize and dematerialize") {
    enum MyError:Error{
        case anError
    }
    let lol = Student(score: BehaviorSubject(value: 80))
    let pubg = Student(score: BehaviorSubject(value: 100))
    
    let student = BehaviorSubject(value: lol)
    
//    let studentScore = student
//        .flatMap { student in
//            student.score
//        }
    
    let studentScore = student
        .flatMap { student in
            student.score.materialize()
        }
    studentScore.subscribe{
        print($0)
    }.disposed(by: disposeBag)
    
    lol.score.onNext(85)
    lol.score.onError(MyError.anError)
    lol.score.onNext(90)
    student.onNext(pubg)
    
}
