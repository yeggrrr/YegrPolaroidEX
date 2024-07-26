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
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            print("SearchView 뜸!!")
            self.seachAPIRequest()
        }
    }
    
    func seachAPIRequest() {
        APICall.shared.callRequest(api: .search(query: "바다", page: 20), model: SearchModel.self) { result in
            self.inputSearchData.value = result
        } errorHandler: { error in
            print("Error 발생!!", error)
        }
    }
}
