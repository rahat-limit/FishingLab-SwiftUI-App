import SwiftUI

struct TabsView: View {
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @EnvironmentObject var tabViewManager : TabViewManager
    @State var isOpenSideMenu: Bool = false
    @State var text = "Hello, World!"
     
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 122 / 255, green: 146 / 255, blue: 92 / 255, alpha: 10) // Задаем цвет фона Navigation Bar
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Задаем цвет текста заголовка
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Цвет для большого заголовка
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        UINavigationBar.appearance().prefersLargeTitles = false
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    switch tabViewManager.currentTab {
                    case .profile:
                        ProfileTabView()
                    case .googleMap(var onAppearAction, var locationButtonVisible):
                        GoogleMapTabView(onAppearAction: onAppearAction, locationButtonVisible: locationButtonVisible)
                    case .points:
                        PointsTabView()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(tabViewManager.currentTabAppBarTitle)
                            .h1Small()
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.isOpenSideMenu.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                                .foregroundStyle(Color.primaryColor)
                        }
                    }
                    
                }
            }
            SideMenuView(isOpen: $isOpenSideMenu, text: $text)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    TabsView()
        .environmentObject(AuthViewModelImpl(errorManager: ErrorManager.shared, appLoadingManager: AppLoadingManager.shared, navigationManager: NavigationManager.shared, userDefaultStorageManager: UserDefaultStorageManager.shared))
        .environmentObject(TabViewManager())
}
