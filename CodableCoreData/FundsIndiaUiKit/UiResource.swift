//
//  EnumProts.swift
//  FIUIElements
//
//  Created by FIuser on 21/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//

import Foundation
import UIKit


public protocol ActionSheetsDataSource {
    
    var list: [Any]? { get }
    var list2: [Any]? { get }
    var title: String { get }
    var leftButton :String { get }
    var rightButton: String { get }
    var properties: [String: String] { get }
    var selectionType: pickerMode { get }
}

public extension ActionSheetsDataSource {
    var properties: [String: String] {
        return [
            "title": title,
            "rightButtonTitle": rightButton,
            "leftButtonTitle": leftButton
        ]
    }
}

//struct ActionSheetProperties {
//    var title: String?
//    var leftButtonName:String?
//    var rightButtonName: String?
//    var elementList: [String]?
//    var selectionType: pickerMode?
//
//}

public enum pickerMode {
    case content
    case date
    case dateAndTime
    case time
    case mulipleContent
}

public enum DataSource: ActionSheetsDataSource {
    
    case date(title: String)
    case singleElement(array:[Any]?,title:String)
    case multipleElements(array1:[Any]?,array2:[Any]?,title:String)
    case time(title: String)
    case dateAndTime(title: String)
    
    public var leftButton: String {
        switch self {
        case .date(_):
            return "Cancel"
        case .dateAndTime(_):
            return "Cancel"
        case .singleElement(_,_):
            return "Cancel"
        case .time(_):
            return "Cancel"
            
        case .multipleElements(_, _, _):
            return "Cancel"
        }
    }
    
    public var rightButton: String {
        switch self {
        case .date(_):
            return "Done"
        case .dateAndTime(_):
            return "Done"
        case .singleElement(_,_):
            return "Done"
        case .time(_):
            
            return "Done"
        case .multipleElements(_, _, _):
            return "Done"
        }
    }
    
    public var list: [Any]? {
        switch self {
        case .date(_):
            return nil
        case .dateAndTime(_):
            return  nil
        case .singleElement(let arrayList,_):
            return arrayList
        case .multipleElements(let array1, _, _):
            return array1
            
        case .time(_):
            return nil
        }
    }
    
    public var list2: [Any]? {
        switch self {
        case .date(_):
            return nil
        case .dateAndTime(_):
            return  nil
        case .singleElement( _, _):
            return nil
        case .multipleElements(_,let array2, _):
            return array2
        case .time(_):
            return nil
        }
    }
    
    
    public var title: String {
        switch self {
        case .date(let title):
            return title
        case .dateAndTime(let title):
            return title
        case .singleElement(_,let title):
            return title
        case .multipleElements(_, _, let title):
            return title
        case .time(let title):
            return title
        }
    }
    
    public var selectionType: pickerMode {
        switch self {
        case .date(_):
            return .date
        case .dateAndTime(_):
            return .dateAndTime
        case .time(_):
            return .time
        case .singleElement(_ ,_ ):
            return .content
        case .multipleElements(_ ,_ ,_):
            return .mulipleContent
            
        }
    }
}
