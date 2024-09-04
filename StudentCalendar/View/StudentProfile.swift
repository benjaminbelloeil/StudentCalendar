import SwiftUI

struct StudentProfile: View {
    @State private var showingImagePicker = false
    @State private var profileImage: Image? = Image("Profile1")
    @State private var name: String = "Benjamin Belloeil"
    @State private var email: String = "A00838158@tec.mx"
    @State private var phone: String = "+123 456 7890"
    @State private var location: String = "Monterrey, Mexico"
    @State private var showingEditProfileView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    profileHeader
                    
                    VStack(alignment: .leading, spacing: 10) {
                        profileRow(iconName: "envelope.fill", text: email)
                        profileRow(iconName: "phone.fill", text: phone)
                        profileRow(iconName: "location.fill", text: location)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    NavigationLink(destination: EditProfileView(name: $name, email: $email, phone: $phone, location: $location), isActive: $showingEditProfileView) {
                        Button(action: {
                            showingEditProfileView = true
                        }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingImagePicker, content: {
                ImagePicker(image: $profileImage)
            })
        }
    }
    
    // MARK: Profile Header
    private var profileHeader: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            
            profileImage?
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .onTapGesture {
                    showingImagePicker = true
                }
            
            TextField("Name", text: $name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Student | Computer Science")
                .font(.subheadline)
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            TextField("Student | Computer Science", text: $location)
                .font(.subheadline)
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        
                
            
            Divider()
                .padding(.horizontal, 50)
        }
    }
    
    // MARK: Profile Row
    private func profileRow(iconName: String, text: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(.blue)
            Text(text)
                .font(.subheadline)
        }
        .padding(.vertical, 5)
    }
}

// Dummy EditProfileView
struct EditProfileView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var location: String

    var body: some View {
        Form {
            Section(header: Text("Profile Information")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                TextField("Phone", text: $phone)
                TextField("Location", text: $location)
            }
        }
        .navigationTitle("Edit Profile")
    }
}

struct StudentProfile_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfile()
    }
}
