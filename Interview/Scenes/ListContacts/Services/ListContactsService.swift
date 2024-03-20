import Foundation

final class ListContactService: ContactServiceProvider {
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        guard let api = URL(string: APIConstants.apiURL) else {
            completion(.failure(NSError(domain: "InvalidURL",
                                        code: 0)))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { [weak self] (data, response, error) in
            guard self != nil else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response?.isHTTPStatusCodeValid() ?? false else {
                completion(.failure(NSError(domain: "HTTPError", code: 0)))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Contact].self, from: jsonData)
                completion(.success(decoded))
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
