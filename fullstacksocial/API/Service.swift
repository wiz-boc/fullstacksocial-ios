//
//  Service.swift
//  fullstacksocial
//
//  Created by wizz on 10/10/21.
//

import Alamofire
import Combine

class Service: NSObject {
    
    static let shared = Service()
    
    let baseUrl = "https://cc-fullstacksocial.herokuapp.com"
    
    func searchForUsers(completion: @escaping (Result<[User],Error>) -> ()) {
        let url = "\(baseUrl)/search"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResponse) in
                if let err = dataResponse.error {
                    completion(.failure(err))
                    return
                }
                
                do {
                    let data = dataResponse.data ?? Data()
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Data,Error>) -> ()) {
        print("Performing login")
        let params = ["emailAddress": email, "password": password]
        let url = "\(baseUrl)/api/v1/entrance/login"
        AF.request(url, method: .put, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                } else {
                    completion(.success(dataResp.data ?? Data()))
                }
        }
    }
    
    func fetchPosts(completion: @escaping (Result<[Post],Error>) -> ()) {
        let url = "\(baseUrl)/post"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                
                guard let data = dataResp.data else { return }
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    
    func signUp(fullName: String, emailAddress: String, password: String, completion: @escaping (Result<Data,Error>) -> ()) {
        let params = ["fullName": fullName, "emailAddress": emailAddress, "password": password]
        let url = "\(baseUrl)/api/v1/entrance/signup"

        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300).responseData{ (dataResp) in
            
            if let err = dataResp.error {
                completion(.failure(err))
                return
            }
            completion(.success(dataResp.data ?? Data()))
        }
    }
    
}
