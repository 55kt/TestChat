import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

//MARK: - Firebase Manager Properties
class FirebaseManager: NSObject, ObservableObject {
    
    //MARK: - Properties
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    var user: User
    
//    let didCompletedLoginProcess: () -> ()
    
    @Published var isLoginMode = false
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
        
        self.user = User.init(email: "", password: "", nickname: "")
        
        super.init()
    }
    
    //MARK: - Methods
    
    // Login Function
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
//            self.didCompletedLoginProcess()
        }
    }
    
    // Register Function
    func createNewAccount(user: User, image: UIImage?) {
        auth.createUser(withEmail: user.email, password: user.password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            self.persistImageToStorage(user: user, image: image)
        }
    }
    
    // Image Saving in Firebase Storage
    func persistImageToStorage(user: User, image: UIImage?) {
        guard let uid = auth.currentUser?.uid else { return }
        let ref = storage.reference(withPath: uid)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
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
                self.storeUserInformation(user: user, imageProfileUrl: url)
            }
        }
    }
    
    // Saving User Data Collection in Firestore Database
    func storeUserInformation(user: User, imageProfileUrl: URL) {
        guard let uid = auth.currentUser?.uid else {
            print("Failed to get current user uid")
            return
        }
        print("Storing user information for user: \(uid)")
        let userData: [String: Any] = ["email": user.email,"nickname": user.nickname,"password": user.password, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        firestore.collection("users").document(uid).setData(userData) { err in
            if let err = err {
                print("Failed to store user information:", err)
                self.loginStatusMessage = "Failed to store user information: \(err)"
                return
            }
            print("Successfully stored user information")
            self.loginStatusMessage = "Successfully stored user information"
        }
    }
}
