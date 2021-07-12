//
//  Request.swift
//  example
//
//  Created by B1591 on 2021/5/26.
//

import Foundation
import Alamofire
import SHOPSwift
import XCoordinator

class AccessTokenAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        let accessToken = TokenRealm().getAccessToken()
        
        if accessToken != "" {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
}

public typealias RequestRetryCompletion = (_ shouldRetry: Bool, _ timeDelay: TimeInterval) -> Void

class OAuth2Handler: RequestRetrier{
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        let accessToken = TokenRealm().getAccessToken()
        let refreshToken = TokenRealm().getRefreshToken()
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 || response.statusCode == 403 ||
            response.statusCode == 500,
           accessToken != "" || refreshToken != ""{
            let tokenPair = TokenPair(accessToken: accessToken,
                                      refreshToken: refreshToken)
            _ = AuthAPI.refreshJwtUsingPOST(body: tokenPair)
                .take(1)
                .subscribe(onNext: { tokenPair in
                    guard let accessToken = tokenPair.accessToken else { return }
                    guard let refreshToken = tokenPair.refreshToken else { return }
                    TokenRealm().saveToken(accessToken: accessToken,
                                           refreshToken: refreshToken)
                    completion(true, 1.0)
                }, onError: { error in
                    self.backToLogin()
                    completion(false, 0.0)
                })
        } else {
            completion(false, 0.0) // don't retry
        }
    }
    
    func backToLogin() {
        DispatchQueue.main.async {
            let router = AppCoordinator().strongRouter
            router.trigger(.login)
        }
    }
    
}

class MyRequestBuilderFactory: RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        return MyAlamofireRequestBuilder<T>.self
    }
    
    func getBuilder<T>() -> RequestBuilder<T>.Type where T : Decodable {
        return MyAlamofireDecodableRequestBuilder<T>.self
    }
    
    
}


open class MyAlamofireRequestBuilder<T>: AlamofireRequestBuilder<T> {
    
    
}


class MyAlamofireDecodableRequestBuilder<T: Decodable>: AlamofireDecodableRequestBuilder<T> {
    
    open override func createSessionManager() -> Alamofire.SessionManager {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = AccessTokenAdapter()
        sessionManager.retrier = OAuth2Handler()
        return sessionManager
    }
    
}






