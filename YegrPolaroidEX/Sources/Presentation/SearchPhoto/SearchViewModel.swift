//
//  SearchViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import UIKit
import Alamofire

final class SearchViewModel {    
    // input
    var inputSearchData: CustomObservable<[SearchModel.Results]> = CustomObservable([])
    var inputSearchText: CustomObservable<String?> = CustomObservable("")
    var inputCurrentSortType: CustomObservable<OrderBy> = CustomObservable(.relevant)
    var inputTotalCount: CustomObservable<Int?> = CustomObservable(nil)
    var inputStatisticData: CustomObservable<StatisticsData?> = CustomObservable(nil)
    
    var isDataCountZero: CustomObservable<Bool> = CustomObservable(false)
    var index: Int?
    
    init() {
        inputCurrentSortType.bind { sortType in
            guard let text = self.inputSearchText.value else { return }
            self.seachAPIRequest(query: text, page: 1, orderBy: self.inputCurrentSortType.value)
        }
    }
    
    func seachAPIRequest(query: String, page: Int, orderBy: OrderBy) {
        APICall.shared.callRequest(api: .search(query: query, page: page, orderBy: orderBy), model: SearchModel.self) { result in
            self.inputSearchData.value = result.results
            self.inputTotalCount.value = result.total
            self.isDataCountZero.value = result.results.count < 1
        } errorHandler: { error in
            print("Error 발생!!", error)
        }
    }
    
    func statisticCallRequest(imageID: String, index: Int?) {
        // statistic
        APICall.shared.callRequest(api: .statistics(imageID: imageID), model: StatisticsData.self) { result in
            self.index = index
            self.inputStatisticData.value = result
        } errorHandler: { error in
            self.index = nil
            print("Error 발생!!", error)
        }
    }
}
