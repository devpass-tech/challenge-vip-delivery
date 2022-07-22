
import Foundation

enum UserDefaultsManager {
    struct UserInfos {
        static let shared = UserInfos()

        func save(session: Session, user: User?) {
            let userDefaults = UserDefaults.standard
            if let encodedSession = try? JSONEncoder().encode(session) {
                userDefaults.set(encodedSession, forKey: "sessionNewData")
            }
            if let user = user,
               let encodedUser = try? JSONEncoder().encode(user){
                userDefaults.set(encodedUser, forKey: "userNewData")
            }
            userDefaults.set(session.id, forKey: "userID")
        }

        func readSesion() -> Session? {
            if let value = UserDefaults.standard.value(forKey: "sessionNewData") as? Data,
               let decodedValue = try? JSONDecoder().decode(Session.self, from: value) {
                return decodedValue
            } else {
                return nil
            }
        }

        func readUserInfos() -> User? {
            if let value = UserDefaults.standard.value(forKey: "userNewData") as? Data,
               let decodedValue = try? JSONDecoder().decode(User.self, from: value) {
                return decodedValue
            } else {
                return nil
            }
        }

        func delete() {
            UserDefaults.standard.set(nil, forKey: "sessionNewData")
            UserDefaults.standard.set(nil, forKey: "userNewData")
            UserDefaults.standard.set(nil, forKey: "userID")
        }
    }
}
