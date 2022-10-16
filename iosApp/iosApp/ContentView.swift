import SwiftUI
import WebKit
import shared

struct ContentView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    let sdk = SpaceXSDK(databaseDriverFactory: DatabaseDriverFactory())
    
    var body: some View {
        
        NavigationView {
            listView()
                .navigationBarTitle("SpaceX Launches")
                .navigationBarItems(trailing:
                                        Button("Reload") {
                    self.viewModel.loadLaunches(forceReload: true)
                })
        }
    }
    private func listView() -> AnyView {
        switch viewModel.launches {
        case .loading:
            return AnyView(Text("Loading...").multilineTextAlignment(.center))
        case .result(let launches):
            return AnyView(List(launches) { launch in
                //                    RocketLaunchRow(rocketLaunch: launch)
                Text(launch.missionName)
            })
        case .error(let description):
            return AnyView(Text(description).multilineTextAlignment(.center))
        }
    }
}

extension ContentView {
    
    enum LoadableLaunches {
        case loading
        case result([RocketLaunch])
        case error(String)
    }
    
    class ViewModel: ObservableObject {
        @Published var text = "Loading..."
        
        let sdk: SpaceXSDK
        @Published var launches = LoadableLaunches.loading
        
        
        init(sdk: SpaceXSDK) {
            self.sdk = sdk
            self.loadLaunches(forceReload: false)
        }
        
        func loadLaunches(forceReload: Bool) {
            self.launches = .loading
            sdk.getLaunches(forceReload: forceReload, completionHandler: { launches, error in
                if let launches = launches {
                    self.launches = .result(launches)
                } else {
                    self.launches = .error(error?.localizedDescription ?? "error")
                }
            })
        }
        
    }
}

extension RocketLaunch: Identifiable { }

//struct ContentView_Previews: PreviewProvider {
//	static var previews: some View {
//        ContentView(viewModel: .cViewModel())
//	}
//}


struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
