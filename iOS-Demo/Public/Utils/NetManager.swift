//
//  NetManager.swift
//  FotoableProject
//
//  Created by jeanboy on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import Alamofire

class NetManager: NSObject {
    
    var baseURLString: String = ""              // 基本地址
    var baseHeaders: [String: String]?          // 基本Http headers
    
    static let shareInstance = NetManager()
    private override init() {}
}

extension NetManager {
    
    /**
     get请求
     
     @param urlString 请求地址
     @param headers The http headers
     @param parameters The parameters
     @param completion 结束后的回调
     */
    func get(urlString: String!, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default, completion:
        @escaping (_ responseData: Any?, _ error: Error?) -> Void) {
        
        self.request(urlString: urlString, method: .get, parameters: parameters, headers: headers, encoding: encoding, completion: completion)
    }
    
    /**
     post请求
     
     @param urlString 请求地址
     @param headers The http headers
     @param parameters The parameters
     @param completion 结束后的回调
     */
    func post(urlString: String!, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default, completion:
        @escaping (_ responseData: Any?, _ error: Error?) -> Void) {
        
        self.request(urlString: urlString, method: .post, parameters: parameters, headers: headers, encoding: encoding, completion: completion)
    }
    
    private func request(urlString: String!, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default, completion:
        @escaping (_ responseData: Any?, _ error: Error?) -> Void) {
        
        var requestHeaders = (nil != baseHeaders) ? baseHeaders! : [String: String]()
        if let headers = headers {
            for value in headers{
                requestHeaders[value.key] = headers[value.key]
            }
        }
        
        let requestURLString = baseURLString + urlString
        Alamofire.SessionManager.default.requestWithoutCache(requestURLString, method: method, parameters: parameters, encoding: encoding, headers: requestHeaders).responseJSON { (response) in
            
            DLog("\(requestURLString), parameters=\(String(describing: parameters)), result=\(response)")
            
            if let error = response.error {
                completion(nil, error);
            } else if let json = response.result.value {
                completion(json, nil);
            } else {
                completion([:], nil)
            }
        }
    }
    
}

extension Alamofire.SessionManager{
    
    // 请求结果不缓存
    @discardableResult open func requestWithoutCache(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        }
    }
}
