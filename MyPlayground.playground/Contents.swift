//: Playground - noun: a place where people can play

import UIKit

class Todo{
    var tempId: UUID?
    var id : Int
    var title: String
    var isCompleted: Bool
    
    init(id:Int, title:String, isCompleted:Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.tempId = id == -1 ? UUID() : nil
    }
}
protocol CachedData{
    var todosInCache:[Todo] { get set }
}
protocol Repository{
    func getTodos()->[Todo]
    func getTodo(id:Int) -> Todo
    func addTodo(todo: Todo) -> Todo
    func updateTodo(todo: Todo) -> Todo
}

class CacheRepository: Repository, CachedData {
    
    var todosInCache:[Todo] = []
    
    func getTodos() -> [Todo] {
        return todosInCache
    }
    
    func getTodo(id: Int) -> Todo {
        return todosInCache.first(where: {$0.id == id})!
    }
    
    func addTodo(todo: Todo) -> Todo{
        todosInCache.append(todo)
        return todo
    }
    func updateTodo(todo: Todo) -> Todo {
        let todoTobeUpdated = todosInCache.first(where: {$0.tempId ==  todo.tempId})
        todoTobeUpdated?.id = todo.id
        todoTobeUpdated?.isCompleted = todo.isCompleted
        return (todoTobeUpdated)!
    }
}
class CloudRepository: Repository{
    private var todos:[Todo] = []
    
    init() {
        todos.append(Todo(id: 1, title: "doing nothing", isCompleted: false))
        todos.append(Todo(id: 2, title: "goto hartono mall", isCompleted: false))
        todos.append(Todo(id: 3, title: "buy a Warkop Reborn 2 ticket", isCompleted: false))
    }
    
    func getTodos() -> [Todo] {
      return todos
    }

    
    func getTodo(id: Int) -> Todo {
        return todos.first(where: {$0.id == id})!
    }
    
    func addTodo(todo: Todo) -> Todo {
        todo.id = todos.count+1
        todos.append(todo)
        return todo
    }
    
    func updateTodo(todo: Todo) -> Todo {
        print("update todo in the cloud")
        let todoTobeUpdated = todos.first(where: {$0.tempId ==  todo.tempId})
        todoTobeUpdated?.id = todo.id
        todoTobeUpdated?.isCompleted = todo.isCompleted
        return (todoTobeUpdated)!

    }
}
//RepositoriesFactory
class DataManager {
    var cacheRepository: Repository&CachedData
    let cloudRepository: Repository
    init() {
        self.cacheRepository = CacheRepository()
        self.cloudRepository = CloudRepository()
    }
    func refreshTodos()->[Todo]{
        
        cacheRepository.todosInCache.removeAll()
        cacheRepository.todosInCache = cloudRepository.getTodos()
        return cacheRepository.todosInCache
    }
    func getTodos()->[Todo]{
        
        if cacheRepository.todosInCache.isEmpty{
            print("requesting to cloud")
            cacheRepository.todosInCache = cloudRepository.getTodos()
        }
        
        print("todos is come from cache")
        return cacheRepository.todosInCache
    }
    
    func addTodo(todoCandidate:Todo){
        cacheRepository.addTodo(todo: todoCandidate)
        cloudRepository.addTodo(todo: todoCandidate)
    }
    
    func getTodo(id:Int) -> Todo {
        let item = cacheRepository.getTodo(id: id)
        return item
    }
    
    func updateTodo(todo:Todo){
        cacheRepository.updateTodo(todo: todo)
        cloudRepository.updateTodo(todo: todo)
    }
}

let dataManager =  DataManager()

//first,  it is should be request to server
dataManager.getTodos()

//second, it is just return from cache
dataManager.getTodos()

//third, let me add a new todo
dataManager.addTodo(todoCandidate: Todo(id: -1, title: "makan", isCompleted: false))
dataManager.getTodos()


let selected = dataManager.getTodo(id: 2)
selected.title
//forth, let me make simple data manipulation
selected.isCompleted = true
dataManager.updateTodo(todo: selected)
dataManager.getTodos()

public enum MFSIPType: Int, Codable, CaseIterable {
    case regular
    case flexi
    case alert
    case stepup
    case inssip
    case design
    case ft_smart
    case ma
    case port
    case powersip
    case ppsip
    case setup
    case smart
    case powersip_active
    case powersip_passive
    
    public var displayName: String {
        switch self {
        case .regular:
            return "Regular"
        case .flexi:
            return "Flexi"
        case .stepup:
            return "Stepup"
        default:
            return ""
        }
    }
}

public struct MFCurrentSIPScheme : Codable {
    public let payment: Bool
    public let amcCode: String
    public let schemeName: String
    public let schemeCode: String
    public let folio: String
    public let units: Double
    public let unitsFormatted: String
    public let goalId: String
    public let sipDate: Int
    public let referenceId: String?
    public let bankId: String?
   
    public let sipType: MFSIPType?
   
    public let tenure: Int
    public let completedInstallments: Int
    public let nextInstallmentOn: String?
    public let nextInstallmentAmount: Double?
    public let nextInstallmentAmountFormatted: String?

    public let tag: String?
    public let description: String?
    public let category: String

    public let currentValue: Double?
    public let currentValueFormatted: String?
    public let totalGain: Double?
    public let totalGainFormatted: String?
    public let stepUpFlag: Bool

    public let bankName: String?
    public let bankAccountNumber: String
    public let holdingProfileName: String
    public let consumerCode: String
    
    public let expireMessage: String?
    public let installmentSkippedMessage: String?
    
    public var actions: [MFSIPAction] = []
}

public enum MFSIPAction : String, Codable {
    case make_payment, change_amount, change_flexi_amount,
         change_scheme, skip_next_installment, pause_sip,
         stop_sip, extend_sip
    
    // display list of schemes
    public var displayName: String {
        switch self {
        case .change_amount:
            return "Change Amount"
        case .change_flexi_amount:
            return "Change Flexi Amount"
        case .change_scheme:
            return "Change Scheme"
        case .skip_next_installment:
            return "Skip Next Installment"
        case .stop_sip:
            return "Stop SIP"
        case .extend_sip:
            return "Extend SIP"
        case .pause_sip:
            return " Pause SIP"
        case .make_payment:
            return "Make Payment"
        }
    }
}



let numbers = [1, 1, 1, 3, 3, 4]

let numberGroups = Set(numbers).map{ value in return numbers.filter{$0==value} }

print(numberGroups)



