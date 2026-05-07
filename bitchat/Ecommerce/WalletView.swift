//
//  WalletView.swift
//  Ikoro - ₿ỌFỌ E-commerce
//
//  Bitcoin wallet screen
//

import SwiftUI

struct WalletView: View {
    private let dataStore = EcommerceDataStore.shared

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Balance Card
                balanceCard

                // Action Buttons
                actionButtons

                // Transactions List
                transactionsSection
            }
            .padding()
        }
        .navigationTitle("Wallet")
        .navigationBarTitleDisplayMode(.large)
    }

    private var balanceCard: some View {
        VStack(spacing: 16) {
            Text("Balance")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)

            Text(dataStore.formatBalance(dataStore.walletBalance))
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            Text("₿ Bitcoin ₿ỌFỌ")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(
            LinearGradient(
                colors: [Color.accentColor, Color.accentColor.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button(action: {
                // TODO: Send Bitcoin
            }) {
                HStack {
                    Image(systemName: "arrow.up")
                    Text("Send")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(12)
            }

            Button(action: {
                // TODO: Receive Bitcoin
            }) {
                HStack {
                    Image(systemName: "arrow.down")
                    Text("Receive")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.systemGray6))
                .foregroundColor(.primary)
                .cornerRadius(12)
            }
        }
    }

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Transactions")
                .font(.headline)
                .padding(.horizontal)

            VStack(spacing: 0) {
                ForEach(dataStore.transactions) { transaction in
                    TransactionRow(transaction: transaction)

                    if transaction.id != dataStore.transactions.last?.id {
                        Divider()
                            .padding(.leading, 60)
                    }
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

// MARK: - Transaction Row

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(transaction.type == .receive ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .frame(width: 44, height: 44)

                Image(systemName: transaction.type == .receive ? "arrow.down" : "arrow.up")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(transaction.type == .receive ? .green : .red)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(EcommerceDataStore.shared.formatDate(transaction.timestamp))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Amount
            Text((transaction.type == .receive ? "+" : "-") + String(format: "₿%.8f", transaction.amount))
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(transaction.type == .receive ? .green : .red)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        WalletView()
    }
}