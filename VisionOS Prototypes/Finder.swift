import SwiftUI

struct ContentView2: View {
    @State var selection: Set<Int> = [0]
    @State var search = ""
    
        var body: some View {
            NavigationView {
                List(selection: self.$selection) {
                    Section(header: Text("Favorites")) {
                        Label("Desktop", systemImage: "menubar.dock.rectangle").tag(0)
                        Label("Home", systemImage: "house")
                        Label("Downloads", systemImage: "arrow.down.circle")
                        Label("Recents", systemImage: "clock")
                        Label("AirDrop", systemImage: "airplayaudio")
                        Label("Folder", systemImage: "folder")
                        Label("Documents", systemImage: "doc")
                    }
                    
                    Section(header: Text("iCloud")) {
                        Label("Desktop", systemImage: "icloud")
                        Label("Documents", systemImage: "doc")
                        Label("Desktop", systemImage: "menubar.dock.rectangle")
                    }
                }
                .searchable(text: $search)
                .navigationTitle("Finder")
                .listStyle(SidebarListStyle())
//                .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
                
                Finder()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
}

struct Finder: View {
    let folders = [
        FinderFolder(label: "Applications", icon: "folder.fill"),
        FinderFolder(label: "Desktop", icon: "macwindow")
    ]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 64) {
                    FinderFolder(label: "Apps", icon: "folder.fill")
                    FinderFolder(label: "Desktop", icon: "macwindow")
                    FinderFolder(label: "Documents", icon: "folder.fill")
                    FinderFolder(label: "Downloads", icon: "arrow.down.circle.fill")
                    FinderFolder(label: "Library", icon: "folder.fill")
                    FinderFolder(label: "Music", icon: "music.note")
                    FinderFolder(label: "Movies", icon: "video.fill")
                    FinderFolder(label: "Pictures", icon: "photo.fill")
                    FinderFolder(label: "Public", icon: "folder.fill")
                }
                .padding()
                .padding(.vertical)
            }
        }
//        .background(Color.white)
        .navigationTitle("Desktop")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {}) {
                    Image(systemName: "chevron.backward")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {}) {
                    Image(systemName: "chevron.forward")
                }
                .disabled(true)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "square.grid.2x2")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "ellipsis.circle")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                }
            }
            
        }
    }
}

struct FinderFolder: View {
    @State var label: String
    @State var icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 56))
                .foregroundStyle(.tertiary)
            Text(label)
                .font(.body)
                .foregroundColor(Color(UIColor.label))
        }
        .frame(width: 128)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView2()
}
