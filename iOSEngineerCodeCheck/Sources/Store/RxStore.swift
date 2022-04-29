//
//  RxStore.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import ReSwift
import RxSwift
import RxCocoa

final class RxStore<State>: StoreSubscriber {

    typealias StoreSubscriberStateType = State

    private let store: Store<State>

    private let rxStateRelay: BehaviorRelay<State>
    var rxState: State { rxStateRelay.value }
    var rxStateDriver: Driver<State> { rxStateRelay.asDriver() }

    init(store: Store<State>) {
        self.store = store
        self.rxStateRelay = BehaviorRelay(value: store.state)
        self.store.subscribe(self)
    }

    deinit {
        self.store.unsubscribe(self)
    }

    func newState(state: State) {
        rxStateRelay.accept(state)
    }

    func dispatch(_ action: Action) {
        store.dispatch(action)
    }
}
