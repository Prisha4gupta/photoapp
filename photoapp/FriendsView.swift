import SwiftUI
import Combine
struct FriendModel: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

let localMockFriends = [
    FriendModel(name: "Willy", color: .gray),
    FriendModel(name: "Daffa", color: .yellow),
    FriendModel(name: "Abe", color: .cyan),
    FriendModel(name: "Farrel", color: .green),
    FriendModel(name: "Calvin", color: .purple)
]

struct FriendsView: View {
    var friends = localMockFriends
    @Environment(\.dismiss) var dismiss
    @State private var rotation: Double = 0
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .frame(width: 36, height: 36)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Friends")
                        .font(.headline)
                    Spacer()
                    Color.clear.frame(width: 36, height: 36)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                        .frame(width: 240, height: 240)

                    Button {
                        print("Add friend")
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(width: 70, height: 70)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    ForEach(friends.indices, id: \.self) { index in
                        
                        let friend = friends[index]
                        
                        let baseAngle = Double(index) / Double(friends.count) * 2 * .pi
                        let animatedAngle = baseAngle + (rotation * .pi / 180)
                        
                        let radius: CGFloat = 110
                        let x = cos(animatedAngle) * radius
                        let y = sin(animatedAngle) * radius
                        
                        VStack(spacing: 6) {
                            Circle()
                                .fill(friend.color)
                                .frame(width: 54, height: 54)
                            Text(friend.name)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .offset(x: x, y: y)
                        
                        .scaleEffect(1.1)
                        .opacity(0.8)
                    }
                }
                .frame(height: 280)
                
                Spacer()
            }
        }
        
        .onReceive(timer) { _ in
            rotation += 0.3
        }
    }
}

#Preview {
    FriendsView()
}
