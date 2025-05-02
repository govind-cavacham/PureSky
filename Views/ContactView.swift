import SwiftUI
import MessageUI

struct ContactView: View {
    @State private var subject = ""
    @State private var message = ""
    @State private var showingMailError = false
    @State private var showingMailSuccess = false
    
    var body: some View {
        Form {
            Section(header: Text("Contact Information")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                    Text(Config.supportEmail)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Send Message")) {
                TextField("Subject", text: $subject)
                TextEditor(text: $message)
                    .frame(height: 150)
            }
            
            Section {
                Button(action: sendEmail) {
                    HStack {
                        Spacer()
                        Text("Send Message")
                            .bold()
                        Spacer()
                    }
                }
                .disabled(subject.isEmpty || message.isEmpty)
            }
        }
        .navigationTitle("Contact Us")
        .alert("Error", isPresented: $showingMailError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Could not send email. Please try again later.")
        }
        .alert("Success", isPresented: $showingMailSuccess) {
            Button("OK", role: .cancel) {
                subject = ""
                message = ""
            }
        } message: {
            Text("Your message has been sent successfully.")
        }
    }
    
    private func sendEmail() {
        let email = Config.supportEmail
        let urlString = "mailto:\(email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                showingMailSuccess = true
            } else {
                showingMailError = true
            }
        }
    }
}

#Preview {
    NavigationView {
        ContactView()
    }
} 