//
//  OurTopicViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/25/24.
//

import Foundation
import Alamofire

final class OurTopicViewModel {
    // Trigger
    var inputViewDidLoadTrigger: CustomObservable<Void?> = CustomObservable(nil)
    var inputCallRequestCompleteTrigger: CustomObservable<Void?> = CustomObservable(nil)
    
    // input
    var inputGoldenHourData: CustomObservable<[TopicData]> = CustomObservable([])
    var inputBusinessData: CustomObservable<[TopicData]> = CustomObservable([])
    var inputInteriorData: CustomObservable<[TopicData]> = CustomObservable([])
    var inputStatisticData: CustomObservable<StatisticsData?> = CustomObservable(nil)
    var inputGoldenHourDetailData: CustomObservable<TopicData?> = CustomObservable(nil)
    var inputGolendHourId: CustomObservable<String> = CustomObservable("")
    
    // output
    var outputGoldenHourData: CustomObservable<StatisticsData?> = CustomObservable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.topicDataCallRequest()
        }
        
        inputGolendHourId.bind { id in
            APICall.shared.callRequest(api: .statistics(imageID: id), model: StatisticsData.self) { result in
                self.outputGoldenHourData.value = result
            } errorHandler: { error in
                print("APICall Failed!! \(error)")
            }
        }
    }
    
    func topicDataCallRequest() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            // goldenHour
            APICall.shared.callRequest(api: .topic(id: TopicID.goldHour.rawValue), model: [TopicData].self) { result in
                self.inputGoldenHourData.value = result
                group.leave()
            } errorHandler: { error in
                print("APICall Failed!! \(error)")
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { 
            // business
            APICall.shared.callRequest(api: .topic(id: TopicID.business.rawValue), model: [TopicData].self) { result in
                self.inputBusinessData.value = result
                group.leave()
            } errorHandler: { error in
                print("APICall Failed!! \(error)")
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            // interior
            APICall.shared.callRequest(api: .topic(id: TopicID.interior.rawValue), model: [TopicData].self) { result in
                self.inputInteriorData.value = result
                group.leave()
            } errorHandler: { error in
                print("APICall Failed!! \(error)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.inputCallRequestCompleteTrigger.value = ()
        }
    }
    
    func statisticCallRequest(imageID: String) {
        // statistic
        APICall.shared.callRequest(api: .statistics(imageID: imageID), model: StatisticsData.self) { result in
            self.inputStatisticData.value = result
        } errorHandler: { error in
            print("APICall Failed!! \(error)")
        }
    }
}
