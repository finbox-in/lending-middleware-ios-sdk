//
//  ContentViewModel.swift
//  FinBoxLending
//
//

import Foundation
import Combine
import FinBoxLending

class ContentViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    init() {
        FinBoxEventBus.shared.publisher
            .sink { event in
                debugPrint("Event Received in ContentViewModel")
                debugPrint("Event:", event.event ?? "")
                debugPrint("Title:", event.title ?? "")
                // You can update published properties or trigger logic here
            }
            .store(in: &cancellables)
    }
}
