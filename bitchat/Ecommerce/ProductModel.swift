//
//  ProductModel.swift
//  Ikoro - ₿ỌFỌ E-commerce
//
//  Product and E-commerce data models
//

import Foundation

// MARK: - Product Model

struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let price: Double // In Bitcoin (₿)
    let category: String
    let priceFormatted: String
    let image: String?

    init(id: String, name: String, description: String, price: Double, category: String, priceFormatted: String, image: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.priceFormatted = priceFormatted
        self.image = image
    }
}

// MARK: - Order Model

struct Order: Identifiable, Codable {
    let id: String
    let productId: String
    let productName: String
    let quantity: Int
    let totalPrice: Double
    let status: OrderStatus
    let createdAt: Date
    let updatedAt: Date

    enum OrderStatus: String, Codable {
        case pending = "pending"
        case confirmed = "confirmed"
        case shipped = "shipped"
        case delivered = "delivered"
        case cancelled = "cancelled"
    }
}

// MARK: - Transaction Model

struct Transaction: Identifiable, Codable {
    let id: String
    let description: String
    let amount: Double
    let type: TransactionType
    let timestamp: Date

    enum TransactionType: String, Codable {
        case receive = "receive"
        case send = "send"
    }
}

// MARK: - Sample Data

class EcommerceDataStore {
    static let shared = EcommerceDataStore()

    // Sample products
    let products: [Product] = [
        Product(id: "P001", name: "Organic Coffee Beans", description: "Premium Arabica coffee beans from Ethiopia", price: 0.05, category: "Food", priceFormatted: "₿0.05"),
        Product(id: "P002", name: "Handmade Leather Wallet", description: "Handcrafted leather wallet with RFID blocking", price: 0.02, category: "Accessories", priceFormatted: "₿0.02"),
        Product(id: "P003", name: "Smart Watch", description: "Fitness tracker with heart rate monitor", price: 0.15, category: "Electronics", priceFormatted: "₿0.15"),
        Product(id: "P004", name: "Wireless Earbuds", description: "Noise-canceling Bluetooth earbuds", price: 0.08, category: "Electronics", priceFormatted: "₿0.08"),
        Product(id: "P005", name: "Eco-Friendly Tote Bag", description: "Reusable cotton tote bag", price: 0.005, category: "Accessories", priceFormatted: "₿0.005"),
        Product(id: "P006", name: "Solar Power Bank", description: "Portable solar charger for outdoor use", price: 0.03, category: "Electronics", priceFormatted: "₿0.03"),
        Product(id: "P007", name: "Organic Honey", description: "Pure raw honey from local beekeepers", price: 0.01, category: "Food", priceFormatted: "₿0.01"),
        Product(id: "P008", name: "Handmade Soap Set", description: "Natural organic soap collection", price: 0.015, category: "Personal Care", priceFormatted: "₿0.015"),
    ]

    // Sample wallet balance
    var walletBalance: Double = 0.12567890

    // Sample transactions
    let transactions: [Transaction] = [
        Transaction(id: "T001", description: "Received from @alice", amount: 0.05, type: .receive, timestamp: Date(timeIntervalSince1970: 1715097600)),
        Transaction(id: "T002", description: "Sent to @bob", amount: 0.02, type: .send, timestamp: Date(timeIntervalSince1970: 1715184000)),
        Transaction(id: "T003", description: "Received from @charlie", amount: 0.1, type: .receive, timestamp: Date(timeIntervalSince1970: 1715270400)),
    ]

    // Sample orders
    let orders: [Order] = [
        Order(id: "O001", productId: "P001", productName: "Organic Coffee Beans", quantity: 2, totalPrice: 0.10, status: .delivered, createdAt: Date(timeIntervalSince1970: 1715097600), updatedAt: Date(timeIntervalSince1970: 1715184000)),
        Order(id: "O002", productId: "P002", productName: "Handmade Leather Wallet", quantity: 1, totalPrice: 0.02, status: .shipped, createdAt: Date(timeIntervalSince1970: 1715270400), updatedAt: Date(timeIntervalSince1970: 1715356800)),
    ]

    private init() {}

    // Helper methods
    func formatBalance(_ balance: Double) -> String {
        return String(format: "₿%.8f", balance)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}