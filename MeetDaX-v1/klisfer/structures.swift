
import Foundation


class dataToPost {
    var stylistName: String = ""
    var customerId: String = ""
    var stylistId: String = ""
    var imgUrl: String = ""
    var duration : Int = 0
    var startDate : Date? = nil
    var endDate : Date? = nil
    var price : Int = 0
    var services : [String] = []
    var servicesNames : [String] = []
    var switchToEventFlag : Bool = false
  
    
    
    var updateId: String? = nil
    var updateIndex: Int? = 0
    
   
    
    class var sharedManager: dataToPost {
        struct Static {
            static let instance = dataToPost()
        }
        return Static.instance
    }

}


class customerDetails {
    var firstName: String = ""
    var lastName: String = ""
    var mobileNumber: String = ""
    var imgUrl: String = ""
    var gender : String = ""
    var age : Date? 
    var uid : String = ""
    var docID : String = ""
    
    
    
    class var sharedManager1: customerDetails {
        struct Static {
            static let instance = customerDetails()
        }
        return Static.instance
    }
    
}
struct stylist{
    var id = String()
    var imageUrl = String()
    var name = String()
    var services = [String]()
    

}

struct services_common {
    var id = String()
    var name = String()
    var price =  Int()
    var services = [[String]]()
}


struct bookings{
    var stylistName = String()
    var customerId = String()
    var stylistId = String()
    var imgUrl = String()
    var duration = Int()
    var date = String()
    var startTime = String()
    var endTime = String()
    
    var price = Int()
    var services = [String]()
    var servicesNames = [String]()
    var updateId = String()
    var docId = String()
    
    
}



