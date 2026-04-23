import SwiftUI

struct MemoriesView: View {
    
    @State var memories: [Memory] = mockMemories
    @State private var showMenu = false
    @State private var selectedMemory: Memory? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(memories) { memory in
                            NavigationLink {
                                if memory.type == .album {
                                    AlbumView(memory: memory)
                                } else {
                                    VideoMemoryView(memory: memory)
                                }
                            } label: {
                                MemoryCard(memory: memory)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                
                NavigationLink(
                    destination: destinationView(),
                    isActive: Binding(
                        get: { selectedMemory != nil },
                        set: { if !$0 { selectedMemory = nil } }
                    )
                ) {
                    EmptyView()
                }
                
                if showMenu {
                    
                    Color.black.opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showMenu = false
                            }
                        }
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            CreateMemoryMenu { type in
                                addMemory(type: type)
                                withAnimation {
                                    showMenu = false
                                }
                            }
                            .padding(.trailing, 16)
                            .transition(.scale.combined(with: .opacity))
                        }
                        Spacer()
                    }
                }
            }
            
            .navigationTitle("Memories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person.crop.circle.fill")
                }
            }
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
    @ViewBuilder
    func destinationView() -> some View {
        if let memory = selectedMemory {
            if memory.type == .album {
                AlbumView(memory: memory)
            } else {
                VideoMemoryView(memory: memory)
            }
        }
    }
    
    func addMemory(type: MemoryType) {
        let newMemory = Memory(
            title: type == .album ? "New Album" : "New Video",
            coverImage: "photo_10",
            type: type,
            participants: mockFriends,
            items: imagesMock.shuffled()
        )
        
        memories.insert(newMemory, at: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            selectedMemory = newMemory
        }
    }
}

#Preview {
    MemoriesView()
}
