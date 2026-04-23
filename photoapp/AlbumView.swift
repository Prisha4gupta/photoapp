import SwiftUI

struct AlbumView: View {
    @State private var showFriends = false
    @State private var showPhotoPicker = false
    var memory: Memory
    var body: some View {
    
        ZStack {
            VStack {
                ZStack {
                    
                    Image(memory.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 420)
                        .clipped()
                        
                    Color.black.opacity(0.4)
                        .frame(height: 420)
                    
                    
                    
                    VStack(spacing: 12) {
                        Spacer()
                        Text(memory.title.uppercased())
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)

                        Text("2 Mar 2026 - 6 Mar 2026")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Capsule())
                        
                        Spacer()
                    }
                }
                .frame(height: 420)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 1) {
                        ForEach(memory.items) { item in
                            
                            GeometryReader { geo in
                                
                                let midX = geo.frame(in: .global).midX
                                let screenMid = UIScreen.main.bounds.width / 2
                                let distance = abs(screenMid - midX)
                                
                                let scale = max(0.75, 1 - (distance / 1200))
                                
                                VStack(spacing: 4) {
                                    
                                    Image(item.fileName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 300)
                                        .clipped()
                                        .cornerRadius(16)
                                        .scaleEffect(scale)
                                        .animation(.easeOut(duration: 0.2), value: scale)
                                }
                            }
                            .frame(width: 200, height: 300)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 12)
                }
                .scrollTargetBehavior(.viewAligned)
               // Spacer()
                
                Button {
                    showPhotoPicker = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .sheet(isPresented: $showPhotoPicker) {
                    PhotoPickerView { selectedImage in
                        print("Selected:", selectedImage.fileName)
                        showPhotoPicker = false
                    }
                    .presentationDetents([ .large])
                    .presentationDragIndicator(.visible)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .ignoresSafeArea(edges: .top)

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showFriends = true
                } label: {
                    Image(systemName: "person.3.fill")
                }
            }
        }
        .toolbarTitleDisplayMode(.inlineLarge)
        .sheet(isPresented: $showFriends) {
            FriendsView()
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
        }

    }
    
}

#Preview {
    AlbumView(memory: mockMemories[0])
}
