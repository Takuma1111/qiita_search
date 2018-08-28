//
//  error_api.swift
//  qiita_api
//
//  Created by 村上拓麻 on 2018/08/28.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import Foundation

enum error : Error{
    case search_error
    case notext_error
}

extension error : LocalizedError{
    var error_description : String? {
        switch self {
        case .search_error:
            return "記事を取得できませんでした"
        case .notext_error:
            return "入力されていません"
        }
    }
}
