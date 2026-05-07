//
//  MarketplaceView.swift
//  Ikoro - ₿ỌFỌ E-commerce
//
//  Marketplace screen for browsing products
//

import SwiftUI

struct MarketplaceView: View {
    @State private var searchQuery: String = ""
    @State private var selectedCategory: String = "All"

    private let dataStore = EcommerceDataStore.shared
    private let categories = ["All", "Food", "Electronics", "Accessories", "Personal Care"]

    var filteredProducts: [Product] {
        dataStore.products.filter { product in
            let matchesSearch = searchQuery.isEmpty ||
                product.name.localizedCaseInsensitiveContains(searchQuery) ||
                product.description.localizedCaseInsensitiveContains(searchQuery)
            let matchesCategory = selectedCategory == "All" || product.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                searchSection

                // Category Filter
                categoryFilterSection

                // Product List
                if filteredProducts.isEmpty {
                    emptyState
                } else {
                    productList
                }
            }
            .navigationTitle("Marketplace")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var searchSection: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)

                TextField("Search products...", text: $searchQuery)
                    .textFieldStyle(.plain)
                    .autocapitalization(.none)

                if !searchQuery.isEmpty {
                    Button(action: { searchQuery = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }

    private var categoryFilterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    CategoryChip(
                        category: category,
                        isSelected: selectedCategory == category,
                        action: { selectedCategory = category }
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }

    private var productList: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {
                ForEach(filteredProducts) { product in
                    ProductCard(product: product)
                }
            }
            .padding()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "cube.box")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("No products found")
                .font(.headline)

            Text("Try a different search or category")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Category Chip

struct CategoryChip: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(category)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

// MARK: - Product Card

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product Image Placeholder
            Rectangle()
                .fill(Color(.systemGray5))
                .frame(height: 120)
                .cornerRadius(12)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(1)

                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                Text(product.priceFormatted)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }

            Spacer()

            // Add to Cart Button
            Button(action: {
                // TODO: Add to cart functionality
            }) {
                HStack {
                    Spacer()
                    Text("Add to Cart")
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview {
    MarketplaceView()
}