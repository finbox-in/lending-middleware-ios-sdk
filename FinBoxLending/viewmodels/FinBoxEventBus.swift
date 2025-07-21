//
//  FinBoxEventBus.swift
//  FinBoxLending
//
//

import Combine

public class FinBoxEventBus {
    public static let shared = FinBoxEventBus()

    private init() {}

    public let publisher = PassthroughSubject<FinBoxEventResult, Never>()

    func send(_ event: FinBoxEventResult) {
        publisher.send(event)
    }
}


