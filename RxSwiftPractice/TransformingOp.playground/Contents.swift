import RxSwift
import Foundation

let disposeBag = DisposeBag()

print("toArray")
Observable.of("A","B","C")
    .toArray()
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)

print("=====map======")
Observable.of(Date())
    .map{ date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(
    onNext: { print($0)
        
    }
    )
    .disposed(by: disposeBag)


print("flatMap 중첩된 Observable 에서 원하는 값을 얻기 위해 사용")
protocol player{
    var point : BehaviorSubject<Int>{get}
}
struct ArrowPlayer:player{
    var point : BehaviorSubject<Int>
}


let KOR = ArrowPlayer(point: BehaviorSubject<Int>(value: 10))
let USA = ArrowPlayer(point: BehaviorSubject<Int>(value: 8))

let match = PublishSubject<player>()

match.flatMap { player in
    player.point
}.subscribe(
    onNext:{print($0)}
).disposed(by: disposeBag)

match.onNext(KOR)
KOR.point.onNext(10)

match.onNext(USA)
USA.point.onNext(8)

print("flatMapLatest 가장 최신의 구독한 구독자의 이벤트만 추적함")
struct 높이뛰기선수 : player{
    var point: BehaviorSubject<Int>
}

let seoul = 높이뛰기선수(point: BehaviorSubject<Int>(value: 10))
let suwon = 높이뛰기선수(point: BehaviorSubject<Int>(value: 11))

let 전국체전 = PublishSubject<player>()
전국체전
    .flatMapLatest { 선수 in
        선수.point
    }
    .subscribe(
        onNext:{print($0)}
    )
    .disposed(by: disposeBag)

전국체전.onNext(seoul)
seoul.point.onNext(13)

전국체전.onNext(suwon)
seoul.point.onNext(22)

suwon.point.onNext(25)


print("전화번호 11자리")
let input = PublishSubject<Int?>()

let list  = [1]

input
    .flatMap { number in
        number == nil ? Observable.empty() : Observable.just(number!)
    }
    .skip(while: { $0 != 0})
    .take(11)
    .toArray()
    .asObservable()
    .map{
        $0.map{
            "\($0)"
        }
    }
    .map{ numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }.subscribe(
        onNext: { print($0)}
    )
    .disposed(by: disposeBag)
