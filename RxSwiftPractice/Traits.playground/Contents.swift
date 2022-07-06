import UIKit
import RxSwift


let disposeBag = DisposeBag()

enum TraitsError : Error{
    case single
    case mabe
    case completable
}

/*
 SINGLE
 .success -> disposed  OR .error->disposed
 Maybe
 .success-> disposed OR .complete-> disposed OR .error-> disposed
 COMPLETABLE
 .completed -> disposed OR .error->disposed
 */
print("-------single1-----")
Single<String>.just("🦷")
    .subscribe(
        onSuccess: {
            print($0)
        }, onFailure: {
            print($0)
        }, onDisposed: {
            print("disposed")
        }
    ).disposed(by: disposeBag)

print("------single2--------")
Observable<Result<String,TraitsError>>.just(.failure(.single))
    .asSingle()
    .subscribe { result in
        print(result)
    } onFailure: { error in
        print(error)
    } onDisposed: {
        print("disposed")
    }.disposed(by: disposeBag)

print("---------Maybe1----------")
Maybe<Result<String,TraitsError>>.just(.success("👊🏿"))
    .subscribe(onSuccess: {print("success: \($0)")},
               onError: {print("error = \($0)")},
               onCompleted: {print("completed")},
               onDisposed: {print("disposed")}).disposed(by: disposeBag)

print("-------MayBE2-----------")
Observable<Result<String,TraitsError>>.just(.failure(.mabe)).asMaybe()
    .subscribe { result in
        print(result)
    } onError: { error in
        print(error)
    } onCompleted: {
        print("COmpleted")
    } onDisposed: {
        print("disposed")
    }.disposed(by: disposeBag)

print("-------Completable1-------")
Completable.create { completable in
    completable(.error(TraitsError.completable))
    return Disposables.create()
}
.subscribe(onCompleted: {
    print("completed")
}, onError: {
    print("error: \($0.localizedDescription)")
}, onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)

print("-------Completable2-------")
Completable.create { completable in
    completable(.completed)
    return Disposables.create()
}
.subscribe(onCompleted: {
    print("completed")
}, onError: {
    print("error: \($0.localizedDescription)")
}, onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)

