//
//  OurTopicViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/25/24.
//

import Foundation
import Alamofire

final class OurTopicViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputGoldenHourData: Observable<[TopicData]> = Observable([])
    
    var outputGoldenHourData: Observable<[TopicData]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.callRequest(id: TopicID.goldHour.rawValue)
        }
    }
    
    func callRequest(id: String) {
        APICall.shared.callRequest(api: .topic(id: id), model: [TopicData].self) { result in
            self.inputGoldenHourData.value = result
        } errorHandler: { error in
            print("Failed!! \(error)")
        }
    }
}
