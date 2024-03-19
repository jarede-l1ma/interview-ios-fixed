import Foundation

final class ListContactsViewModel {
    private let service: ContactServiceProvider
    
    init(service: ContactServiceProvider = ListContactService()) {
        self.service = service
    }
    
    func loadContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        service.fetchContacts { result in
            switch result {
            case .success(let contacts):
                completion(.success(contacts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func isLegacy(contactID: Int) -> Bool {
        return UserIdsLegacy.isLegacy(id: contactID)
    }
}
