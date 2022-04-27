//
//  NetworkService.swift
//  AlamofireTutorial
//
//  Created by 이태현 on 2022/04/28.
//

import Alamofire
import Foundation

struct ResponseBody: Codable, Hashable{
    let page, perPage, total, totalPages: Int
    let data: [Datum]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Datum: Codable, Hashable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable, Hashable {
    let url: String
    let text: String
}


class userListViewModel: ObservableObject {
    @Published var userList = [ResponseBody]()
    
    func getUsers() {
        AF.request("https://reqres.in/api/users?page=2", method: .get)
            .validate()
            .responseDecodable(of: ResponseBody.self) { response in
                switch response.result {
                case .success(let value):
                    self.userList.append(value)
                case .failure(let error):
                    print("\(error)")
                }
            }
    }
}
