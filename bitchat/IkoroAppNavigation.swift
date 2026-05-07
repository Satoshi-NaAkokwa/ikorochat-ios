//
//  IkoroAppNavigation.swift
//  Ikoro - ₿ỌFỌ E-commerce
//
//  Main navigation with Chat, Marketplace, Wallet, and Orders tabs
//

import SwiftUI

enum IkoroTab: String, CaseIterable {
    case chat = "Chat"
    case marketplace = "Marketplace"
    case wallet = "Wallet"
    case orders = "Orders"

    var icon: String {
        switch self {
        case .chat:
            return "message.fill"
        case .marketplace:
            return "cart.fill"
        case .wallet:
            return "wallet.pass"
        case .orders:
            return "list.bullet.rectangle"
        }
    }
}

struct IkoroAppNavigation: View {
    @State private var selectedTab: IkoroTab = .chat

    var body: some View {
        TabView(selection: $selectedTab) {
            // Chat Tab
            NavigationView {
                ContentView() // Original BitChat ContentView
                    .navigationTitle("Ikoro")
            }
            .tabItem {
                Label("Chat", systemImage: IkoroTab.chat.icon)
            }
            .tag(IkoroTab.chat)

            // Marketplace Tab
            MarketplaceView()
                .tabItem {
                    Label("Marketplace", systemImage: IkoroTab.marketplace.icon)
                }
                .tag(IkoroTab.marketplace)

            // Wallet Tab
            WalletView()
                .tabItem {
                    Label("Wallet", systemImage: IkoroTab.wallet.icon)
                }
                .tag(IkoroTab.wallet)

            // Orders Tab
            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: IkoroTab.orders.icon)
                }
                .tag(IkoroTab.orders)
        }
        .accentColor(.accentColor)
    }
}

// MARK: - Preview

#Preview {
    IkoroAppNavigation()
}