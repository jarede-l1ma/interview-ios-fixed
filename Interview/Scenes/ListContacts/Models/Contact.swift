import Foundation

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  }
]
*/

struct Contact: Decodable, Equatable {
    let id: Int
    let name: String
    let photoURL: String
    
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.photoURL == rhs.photoURL
    }
}
