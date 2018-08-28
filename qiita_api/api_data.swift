//
//  api_data.swift
//  qiita_api
//
//  Created by 村上拓麻 on 2018/08/28.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API_data {
    
    var articles : [[String:String?]] = []

    
    func request(keyword : String,apiResponse: @escaping (_ responseArtivles : [[String:String?]] ) -> () ){
       
        Alamofire.request("https://qiita.com/api/v2/items?query=\(keyword)").responseJSON{ response in
       
            guard let object = response.result.value else{
                apiResponse([])
                return
            }
            
            let json = JSON(object)
            print("JSON",json)
            
            json.forEach{(_,json) in
            let article : [String:String?] = [
                "title" : json["title"].string,
                "url"   : json["url"].string
            ]
                self.articles.append(article)
            }
            apiResponse(self.articles)
        }
    }
}
