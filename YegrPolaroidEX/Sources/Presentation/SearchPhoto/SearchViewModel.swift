//
//  SearchViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import UIKit
import Alamofire

final class SearchViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputSearchData: Observable<SearchModel?> = Observable(nil)
    var inputSearchText: Observable<String?> = Observable("")
    var isDataCountZero: Observable<Bool> = Observable(false)
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            print("SearchView 뜸!!")
        }
    }
    
    func seachAPIRequest(query: String, page: Int, orderBy: OrderBy) {
        APICall.shared.callRequest(api: .search(query: query, page: page, orderBy: orderBy), model: SearchModel.self) { result in
            if result.results.count < 1 {
                self.isDataCountZero.value = true
                self.inputSearchData.value = result
            } else {
                self.isDataCountZero.value = false
                self.inputSearchData.value = result
            }
        } errorHandler: { error in
            print("Error 발생!!", error)
        }
    }
}
