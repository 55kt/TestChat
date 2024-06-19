import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

//MARK: - Firebase Manager Properties
class FirebaseManager: NSObject, ObservableObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    @Published var isLoginMode = false
    @Published var email = ""
    @Published var password = ""
    @Published var nickname = ""
    @Published var shouldShowImagePicker = false
    @Published var image: UIImage?
    @Published var loginStatusMessage = ""
    @Published var currentUser: User?
    
    static let shared = FirebaseManager()
    
    //MARK: - Initializer
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
    //MARK: - Methods
    
    // Login Function
    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            self.fetchUser(uid: result?.user.uid)
        }
    }
    
    // Register Function
    func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            self.persistImageToStorage()
        }
    }
    
    // Image Saving in Firebase Storage
    func persistImageToStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    // Saving User Data Collection in Firestore Database
    func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Failed to get current user uid")
            return
        }
        print("Storing user information for user: \(uid)")
        let userData = ["email": self.email,"nickname": nickname,"password": password, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { err in
            if let err = err {
                print("Failed to store user information:", err)
                self.loginStatusMessage = "Failed to store user information: \(err)"
                return
            }
            print("Successfully stored user information")
            self.loginStatusMessage = "Successfully stored user information"
        }
    }
    
    // Fetching User Data from Firestore Database
    func fetchUser(uid: String?) {
        guard let uid = uid else { return }
        let docRef = firestore.collection("users").document(uid)
        docRef.getDocument { document, error in
            if let error = error {
                print("Failed to fetch user: ", error)
                self.loginStatusMessage = "Failed to fetch user: \(error)"
                return
            }
            do {
                self.currentUser = try document?.data(as: User.self)
            } catch let error {
                print("Failed to decode user: ", error)
                self.loginStatusMessage = "Failed to decode user: \(error)"
            }
        }
    }
}
