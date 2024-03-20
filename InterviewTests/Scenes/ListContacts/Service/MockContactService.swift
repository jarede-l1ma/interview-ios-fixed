import Foundation
@testable import Interview

class MockContactService: ContactServiceProvider {
    
    enum MockResult {
        case success([Contact])
        case failure(Error)
    }
    
    var mockResult: MockResult?
    
    var delay: TimeInterval = 0
    
    var numberOfCallsToSimulate: Int = 1
    private var simulatedCallCount: Int = 0
    
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.simulatedCallCount += 1
            
            if self.simulatedCallCount > self.numberOfCallsToSimulate {
                completion(.failure(MockError.mockError))
                return
            }
            
            if let mockResult = self.mockResult {
                switch mockResult {
                case .success(let contacts):
                    completion(.success(contacts))
                case .failure(let error):
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MockError.mockError))
            }
        }
    }
}

enum MockError: Error {
    case mockError
}
