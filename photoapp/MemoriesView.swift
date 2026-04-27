import SwiftUI

struct MemoriesView: View {
    
    @State var memories: [Memory] = mockMemories
    @State private var showMenu = false
    @State private var selectedMemoryID: UUID? = nil
    @State private var showNewMemoryAlert = false
    @State private var newMemoryTitle = ""
    @State private var newMemorySubtitle = ""
    @State private var pendingMemoryType: MemoryType = .album
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach($memories) { $memory in
                            NavigationLink {
                                if memory.type == .album {
                                    AlbumView(memory: $memory)
                                } else {
                                    VideoMemoryView(memory: $memory)
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
                        get: { selectedMemoryID != nil },
                        set: { if !$0 { selectedMemoryID = nil } }
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
                                triggerNewMemoryAlert(for: type)
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
            .alert("Create New Memory", isPresented: $showNewMemoryAlert) {
                TextField("Title (e.g. Canggu Vibes)", text: $newMemoryTitle)
                TextField("Subtitle (e.g. April 2026)", text: $newMemorySubtitle)
                
                Button("Cancel", role: .cancel) { }
                Button("Create") {
                    confirmAddMemory()
                }
            }
        }
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        if let id = selectedMemoryID,
           let index = memories.firstIndex(where: { $0.id == id }) {
            if memories[index].type == .album {
                AlbumView(memory: $memories[index])
            } else {
                VideoMemoryView(memory: $memories[index])
            }
        }
    }
    func triggerNewMemoryAlert(for type: MemoryType) {
            pendingMemoryType = type
            newMemoryTitle = ""
            newMemorySubtitle = ""
            withAnimation { showMenu = false }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                showNewMemoryAlert = true
            }
        }
        
    func confirmAddMemory() {
            let finalTitle = newMemoryTitle.isEmpty ? (pendingMemoryType == .album ? "New Album" : "New Video") : newMemoryTitle
            let finalSubtitle = newMemorySubtitle.isEmpty ? "No dates added" : newMemorySubtitle
            
            let randomCover = imagesMock.randomElement()?.fileName ?? "photo_10"
            
            let newMemory = Memory(
                title: finalTitle,
                subtitle: finalSubtitle,
                coverImage: randomCover,
                type: pendingMemoryType,
                participants: mockFriends,
                items: []
            )
                
            memories.insert(newMemory, at: 0)
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                selectedMemoryID = newMemory.id
            }
        }
    }
#Preview {
    MemoriesView()
}
