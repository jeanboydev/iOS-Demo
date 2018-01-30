//
//  NetManager.swift
//
//  Created by jeanboy on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import Alamofire

public class NetManager: NSObject {
    
    /// 基本地址
    public var baseURLString = ""
    
    /// 基本Http headers
    public var baseHeaders: [String: String]?
    
    public static let shareInstance = NetManager()
    private override init() {}
    
}

public extension NetManager {
    
    /// get请求
    ///
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - headers: The http headers
    ///   - parameters: The parameters
    ///   - completion: 结束后的回调
    func get(urlString: String!, parameters: Parameters? = nil,
             headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default,
             completion: @escaping (_ responseData: Any?, _ error: Error?) -> Void) {
        self.request(urlString: urlString, method: .get, parameters: parameters, headers: headers, encoding: encoding, completion: completion)
    }
    
    /// post请求
    ///
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - headers: The http headers
    ///   - parameters: The parameters
    ///   - completion: 结束后的回调
    func post(urlString: String!, parameters: Parameters? = nil,
              headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default,
              completion: @escaping (_ responseData: Any?, _ error: Error?) -> Void) {
        self.request(urlString: urlString, method: .post, parameters: parameters, headers: headers, encoding: encoding, completion: completion)
    }
    
    /// 发起网络请求
    private func request(urlString: String!, method: HTTPMethod, parameters: Parameters? = nil,
                         headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default,
                         completion: @escaping (_ responseData: Any?, _ error: Error?) -> Void) {
        
        var requestHeaders = (nil != baseHeaders) ? baseHeaders! : [String: String]()
        if let headers = headers {
            for value in headers{
                requestHeaders[value.key] = headers[value.key]
            }
        }
        
        let requestURLString = baseURLString + urlString
        Alamofire.SessionManager.default.requestWithoutCache(requestURLString, method: method, parameters: parameters, encoding: encoding, headers: requestHeaders).responseJSON { (response) in
            
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
    
    /// 请求结果不缓存
    @discardableResult func requestWithoutCache(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest
    {
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
