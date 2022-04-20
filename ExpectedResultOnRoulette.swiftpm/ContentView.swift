import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $tabSelection) {
                StoryView(tab: $tabSelection)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(AppColors.backgroundDarker)
                    .tabItem {
                        Label("Story", systemImage: "book")
                    }
                    .tag(1)
                
                GameView()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(AppColors.backgroundDarker)
                    .tabItem {
                        Label("Game", systemImage: "gamecontroller.fill")
                    }
                    .tag(2)
            }
            .edgesIgnoringSafeArea(.all)
            .frame(width: geo.size.width, height: geo.size.height)
        }.environment(\.colorScheme, .dark)
        
    }
}
