//
//  HomeUtils.swift
//  FOWalletPlus
//
//  Created by Sleep on 2018/11/15.
//  Copyright © 2018 Sleep. All rights reserved.
//

import UIKit

class HomeUtils: NSObject {
    
    /// 根据字符串的长度获取字体大小
    ///
    /// - Parameter text: 输入字符串
    /// - Returns: 字体大小
    open class func getTextSize(_ text: String) -> CGFloat {
        if (text.count <= 12) {
            return 30
        } else if (text.count <= 15) {
            return 28
        } else if (text.count <= 18) {
            return 26
        } else if (text.count <= 21) {
            return 24
        }
        return 22
    }
    
    
    /// 获取Symbol
    ///
    /// - Parameter text: 输入字符串
    /// - Returns: Symbol
    open class func getSymbol(_ text: String) -> String {
        let split = text.split(separator: " ")
        if split.count > 1 {
            return String(split[1])
        }
        return ""
    }
    
    /// 获取Quantity
    ///
    /// - Parameter text: 输入字符串
    /// - Returns: Quantity
    open class func getQuantity(_ text: String) -> String {
        let split = text.split(separator: " ")
        return String(split[0])
    }
    
    /// 组装通证
    ///
    /// - Parameters:
    ///   - symbol: 通证名
    ///   - contract: 合约名
    /// - Returns: 通证全名
    open class func getExtendSymbol(_ symbol: String, contract: String) -> String {
        return "\(symbol)@\(contract)"
    }
    
    /// 组装通证
    ///
    /// - Parameters:
    ///   - symbol: 通证名
    ///   - contract: 合约名
    /// - Returns: 通证全名
    open class func autoExtendSymbol(_ symbol: String, contract: String) -> String {
        if contract == "eosio" {
            return symbol
        }
        return "\(symbol)@\(contract)"
    }
    
    /// 获取通证的精度
    ///
    /// - Parameter quantity: 数量 (1.0000)
    /// - Returns: 精度的长度
    open class func getTokenPrecision(_ quantity: String) -> Int {
        let split = quantity.split(separator: ".")
        if split.count > 1 {
            return "\(split[1])".count
        }
        return 0
    }
    
    /// 获取通证的精度
    ///
    /// - Parameter q: 数量 (1.0000 FO)
    /// - Returns: 精度的长度
    open class func getTokenPrecisionFull(_ q: String) -> Int {
        let quantity = String(q.split(separator: " ")[0])
        let split = quantity.split(separator: ".")
        if split.count > 1 {
            return "\(split[1])".count
        }
        return 0
    }
    
    /// 组装Quantity
    ///
    /// - Parameters:
    ///   - value: 值
    ///   - symbol: 通证
    /// - Returns: quantity
    open class func getFullQuantity(_ value: String, symbol: String) -> String {
        return "\(value) \(symbol)"
    }
    
    /// 格式化数量
    ///
    /// - Parameter text: 输入字符串
    /// - Returns: 格式化后的数据
    open class func fmtQuantity(_ text: String) -> String {
        let quantity = String(text.split(separator: " ")[0])
        let split = quantity.split(separator: ".")
        let left = String(split[0])
        var chars: [String] = []
        var idx: Int = 0
        for i in (0...(left.count - 1)).reversed() {
            chars.append(left.charAt(index: i))
            if idx % 3 == 2 && i != 0 {
                chars.append(",")
            }
            idx += 1
        }
        let preStr = chars.reversed().joined(separator: "")
        if split.count > 1 {
            return "\(preStr).\(split[1])"
        }
        return String(preStr)
    }
    
    open class func getTokenPrice(_ token: TokenSummary?) -> Decimal {
        if token == nil {
            return 0
        }
        if token!.connector_weight.toDecimal().isZero {
            return 0
        }
        let supply = getQuantity(token!.supply).toDecimal()
        let reserveSupply = getQuantity(token!.reserve_supply).toDecimal()
        let cw = token!.connector_weight.toDecimal()
        let balance = getQuantity(token!.connector_balance)
        let reserveConnectorBalance = getQuantity(token!.reserve_connector_balance)
        let balances = balance.toDecimal() + reserveConnectorBalance.toDecimal()
        let price = balances / (cw * (reserveSupply + supply))
        if token!.symbol == "EOS" && token!.contract == "eosio" {
            return Decimal(1) / price
        }
        return price
    }
    
    open class func generateQRCode(_ value: String, size: CGSize, color: UIColor?) -> UIImage {
        let contentData = value.data(using: String.Encoding.utf8)
        let fileter = CIFilter(name: "CIQRCodeGenerator")
        fileter?.setValue(contentData, forKey: "inputMessage")
        fileter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = fileter?.outputImage
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(cgColor: (color ?? UIColor.black).cgColor), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(cgColor: UIColor.white.cgColor), forKey: "inputColor1")
        let outImage = colorFilter!.outputImage
        let scale = size.width / outImage!.extent.size.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        let transformImage = colorFilter!.outputImage!.transformed(by: transform)
        return UIImage(ciImage: transformImage)
    }
}
