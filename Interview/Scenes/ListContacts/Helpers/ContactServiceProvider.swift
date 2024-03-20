import Foundation

protocol ContactServiceProvider {
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void)
}
