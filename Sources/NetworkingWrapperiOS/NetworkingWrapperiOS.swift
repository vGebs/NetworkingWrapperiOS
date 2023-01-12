import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingError
    case unexpectedError(Error)
}

class NetworkWrapper {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    public func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unexpectedError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unexpectedError(NSError())))
                return
            }

            completion(.success(data))
        }.resume()
    }

    public func request<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        request(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
