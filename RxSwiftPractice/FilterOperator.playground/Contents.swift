import RxSwift
let disposeBag = DisposeBag()
print("--------igonore========== -> onNext 이벤트는 무시하는 구독")
let sleepMode = PublishSubject<String>()


sleepMode.ignoreElements().subscribe{
    print("SUN")
}.disposed(by: disposeBag)

sleepMode.onNext("스피커")
sleepMode.onNext("스피커")
sleepMode.onNext("스피커")

sleepMode.onCompleted()


print("=======elelment at=========== -> 특정 인덱스에 온넥스트만 구독함")

let 두번울리면깨는사람 = PublishSubject<String>()

두번울리면깨는사람.element(at: 2)
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)
두번울리면깨는사람.onNext("스피커") //idx 0
두번울리면깨는사람.onNext("스피커") // idx 1
두번울리면깨는사람.onNext("wake up") //2
두번울리면깨는사람.onNext("스피커")//3


print("======filter===========+ 필터 구문이 트루인 값만 리턴")
Observable.of(1,2,3,4,5,6,7,8) //[1,2,3,4,5,6,7,8]
    .filter{$0 % 2 == 0}
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)


print("skip -> n개의 요소 스킵")

Observable.of(1,2,3,4,5,6,7,8,9).skip(5)
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)
print("skip wihe 해당 조건을 만족한 이후에만 방출함")

Observable.of(1,2,3,4,5,6,7,8,9).skip(while: {$0 != 5})
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)

print("skip Until 설정된 옵저버블이 이벤트를 방출하기 전까지 발생한 이벤트를 무시함")

let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님.skip(until: 문여는시간).subscribe{
    print($0)
}.disposed(by: disposeBag)
손님.onNext("손님 1")
손님.onNext("손님 2")
손님.onNext("손님 3")
문여는시간.onNext("열림")
손님.onNext("손님 4")
손님.onNext("손님 5")


print("take 카운트 이후에 발생하는 방출은 무시함")
Observable.of("금","은","동","4등","5등")
    .take(3)
    .subscribe(
    onNext:{print($0)}
    ).disposed(by: disposeBag)

print("take while 특정 조건이 만족하기 전까지만 skip while과 반대")
Observable.of("금","은","동","4등","5등")
    .take(while: {$0 != "동"})
    .subscribe(
    onNext:{print($0)}
    ).disposed(by: disposeBag)

print("enumerated -> 방출되는 이벤트의 인덱스 값을 참고하고 싶은 경우에 사용됨")
Observable.of("금","은","동","4등","5등")
    .enumerated()
    .takeWhile({
        $0.index < 3
    }).subscribe{
        print($0)
    }.disposed(by: disposeBag)

print("take until =========")
let 고객 = PublishSubject<String>()
let 마감시간 = PublishSubject<String>()

고객.take(until: 마감시간)
    .subscribe{
       print($0)
    }.disposed(by: disposeBag)

고객.onNext("1등")
고객.onNext("2등")
마감시간.onNext("마감됨")
고객.onNext("3등")
고객.onNext("4등")

print("========distinctUntilChanged============-> 연달아 중복되는 값은 무시함")
Observable.of("김철수","김철수","김두환","김두환","김영철","시라노시","김철수")
    .distinctUntilChanged()
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)
