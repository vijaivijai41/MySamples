//
//  FIPickerViewDataSource.swift
//  FICommon
//
//  Created by Sasikumar JP on 04/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import Foundation

// protocal for action sheet datasource
public protocol ActionSheetsDataSource {
    var list: [Any]? { get }
    var list2: [Any]? { get }
    var title: String { get }
    var leftButton :String { get }
    var rightButton: String { get }
    var selectionType: pickerMode { get }
}

// Picker Type Enumerations
public enum pickerMode {
    case content
    case date
    case dateAndTime
    case time
    case mulipleContent
}


/// DataSource Declarations with base of Actionsheet datasource
///
/// - date: Date components
/// - singleElement: singlePicker
/// - multipleElements: multiplePickerElement
/// - time: Time components
/// - dateAndTime: Date and Time components
public enum FIPickerViewDataSource: ActionSheetsDataSource {
    
    case date(title: String)
    case singleElement(array:[Any]?,title:String)
    case multipleElements(array1:[Any]?,array2:[Any]?,title:String)
    case time(title: String)
    case dateAndTime(title: String)
    
    public var leftButton: String {
        let cencelButton = NSLocalizedString("cancel", comment: "")
        switch self {
        case .date(_):
            return cencelButton
        case .dateAndTime(_):
            return cencelButton
        case .singleElement(_,_):
            return cencelButton
        case .time(_):
            return cencelButton
        case .multipleElements(_, _, _):
            return cencelButton
        }
    }
    
    public var rightButton: String {
        let doneButton = NSLocalizedString("Done", comment: "")
        switch self {
        case .date(_):
            return doneButton
        case .dateAndTime(_):
            return doneButton
        case .singleElement(_,_):
            return doneButton
        case .time(_):
            return doneButton
        case .multipleElements(_, _, _):
            return doneButton
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
