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
    var inputBusinessData: Observable<[TopicData]> = Observable([])
    var inputInteriorData: Observable<[TopicData]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.goldenCallRequest(id: TopicID.goldHour.rawValue)
            self.businessCallRequest(id: TopicID.business.rawValue)
            self.interiorCallRequest(id: TopicID.interior.rawValue)
        }
    }
    
    func goldenCallRequest(id: String) {
        APICall.shared.callRequest(api: .topic(id: id), model: [TopicData].self) { result in
            self.inputGoldenHourData.value = result
        } errorHandler: { error in
            print("Failed!! \(error)")
        }
    }
    
    func businessCallRequest(id: String) {
        APICall.shared.callRequest(api: .topic(id: id), model: [TopicData].self) { result in
            self.inputBusinessData.value = result
        } errorHandler: { error in
            print("Failed!! \(error)")
        }
    }
    
    func interiorCallRequest(id: String) {
        APICall.shared.callRequest(api: .topic(id: id), model: [TopicData].self) { result in
            self.inputInteriorData.value = result
        } errorHandler: { error in
            print("Faild!! \(error)")
        }
    }
}
