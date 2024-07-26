//
//  SearchViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import UIKit
import Alamofire

final class SearchViewModel {
    // Trigger
    var viewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    // input
    var inputSearchData: Observable<[SearchModel.Results]> = Observable([])
    var inputSearchText: Observable<String?> = Observable("")
    var inputCurrentSortType: Observable<OrderBy> = Observable(.relevant)
    var inputTotalCount: Observable<Int?> = Observable(nil)
    
    var isDataCountZero: Observable<Bool> = Observable(false)
    
    
    init() {
        viewDidLoadTrigger.bind { _ in
            print("SearchView 뜸!!")
        }
        
        inputCurrentSortType.bind { sortType in
            guard let text = self.inputSearchText.value else { return }
            self.seachAPIRequest(query: text, page: 1, orderBy: self.inputCurrentSortType.value)
        }
    }
    
    func seachAPIRequest(query: String, page: Int, orderBy: OrderBy) {
        APICall.shared.callRequest(api: .search(query: query, page: page, orderBy: orderBy), model: SearchModel.self) { result in
            if result.results.count < 1 {
                self.isDataCountZero.value = true
                self.inputSearchData.value = result.results
                self.inputTotalCount.value = result.total
            } else {
                self.isDataCountZero.value = false
                self.inputSearchData.value = result.results
                self.inputTotalCount.value = result.total
            }
        } errorHandler: { error in
            print("Error 발생!!", error)
        }
    }
}
