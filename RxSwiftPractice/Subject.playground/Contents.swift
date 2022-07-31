//import RxSwift
//
//
//let disposeBag = DisposeBag()
//
////MARK: PublishSubject -> 빈상태로 시작하여 새로운 값만을 구독자에게 방출
//print("=======publishsubject 1==========")
//let publishSubject = PublishSubject<String>()
//
//publishSubject.onNext("헬로우 헬로우")
//let 구독자1 = publishSubject.subscribe(onNext : {print($0)})
//
//publishSubject.onNext("듣고 있나요?????")
//publishSubject.onNext("안듣고 있나요?????")
//
//구독자1.dispose()
//
//
//let sub2 = publishSubject.subscribe(onNext:{
//    print($0)
//}).disposed(by: disposeBag)
//
//publishSubject.onNext("4 여보세요")
//publishSubject.onCompleted()
//publishSubject.onNext("5.끝났어요")
//
//print("BEHAVIOR SUBJECT")
//
//enum SubjectError :Error{
//    case error1
//}
//
//
//let behaviorSubject = BehaviorSubject<String>(value: "초기값")
//behaviorSubject.onNext("첫번째")
//behaviorSubject.subscribe{
//    print("첫번 째 구독 :",$0.element ?? $0)
//}.disposed(by: disposeBag)
//
//
//behaviorSubject.onError(SubjectError.error1)
//
//
//behaviorSubject.subscribe{
//    print("두번째 구독 : ",$0.element ?? $0)
//}.disposed(by: disposeBag)
//
//let value = try? behaviorSubject.value()
//print(value)
//
//
//print("========REPLAY SUBJECT==============")
//let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
//replaySubject.onNext("1. 여러분")
//replaySubject.onNext("2. 힘내세요ㅗ")
//replaySubject.onNext("3. 어렵지만")
//
//replaySubject.subscribe(){
//    print("첫번째 구독",$0.element ?? $0 )
//}.disposed(by: disposeBag)
//
//replaySubject.subscribe(){
//    print("두번째 구독 : ",$0.element ?? $0)
//}
//.disposed(by: disposeBag)
//replaySubject.onNext("4. 할수 있어요")
//replaySubject.onError(SubjectError.error1)
//replaySubject.dispose()
////SYSTEM ERROR
//replaySubject.subscribe{
//    print("3번째 구독", $0.element ?? $0)
//}
//
//
//print("3.1.5">"3.2.0")
let tmp = "<ROOT>\n\t<SERVICE>300</SERVICE>\n\t<USERID>yangjs</USERID>\n\t<PASSWORD>A1s2d3f4g5@@</PASSWORD>\n\t<DEVICE_ID>7ce5e8fa2746628583333dc75c321db4</DEVICE_ID>\n\t<DEVICE_KINDS>Android</DEVICE_KINDS>\n</ROOT>"
print(tmp.count)
