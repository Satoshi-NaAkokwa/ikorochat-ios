//
//  OrdersView.swift
//  Ikoro - ₿ỌFỌ E-commerce
//
//  Order history screen
//

import SwiftUI

struct OrdersView: View {
    private let dataStore = EcommerceDataStore.shared

    var body: some View {
        ScrollView {
            if dataStore.orders.isEmpty {
                emptyState
            } else {
                VStack(spacing: 16) {
                    ForEach(dataStore.orders) { order in
                        OrderCard(order: order)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.large)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "cube.box")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("No orders yet")
                .font(.headline)

            Text("Start shopping to see your orders here")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Order Card

struct OrderCard: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Order #\(order.id.suffix(6))")
                        .font(.headline)

                    Text(EcommerceDataStore.shared.formatDate(order.createdAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                // Status Badge
                statusBadge(for: order.status)
            }

            Divider()

            // Product Info
            HStack(spacing: 12) {
                // Product Icon
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .overlay(
                        Image(systemName: "cube.box")
                            .font(.system(size: 24))
                            .foregroundColor(.secondary)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(order.productName)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Text("Quantity: \(order.quantity)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(String(format: "₿%.8f", order.totalPrice))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
            }

            Divider()

            // Footer Actions
            HStack {
                Button(action: {
                    // TODO: Track order
                }) {
                    Text("Track Order")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }

                Spacer()

                Button(action: {
                    // TODO: View details
                }) {
                    Text("View Details")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Status Badge

struct StatusBadge: View {
    let status: Order.OrderStatus

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)

            Text(statusText)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(statusColor)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(statusColor.opacity(0.1))
        .cornerRadius(20)
    }

    private var statusColor: Color {
        switch status {
        case .pending:
            return .orange
        case .confirmed:
            return .blue
        case .shipped:
            return .purple
        case .delivered:
            return .green
        case .cancelled:
            return .red
        }
    }

    private var statusText: String {
        switch status {
        case .pending:
            return "Pending"
        case .confirmed:
            return "Confirmed"
        case .shipped:
            return "Shipped"
        case .delivered:
            return "Delivered"
        case .cancelled:
            return "Cancelled"
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        OrdersView()
    }
}