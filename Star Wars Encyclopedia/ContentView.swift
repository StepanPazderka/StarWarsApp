//
//  ContentView.swift
//  Star Wars Encyclopedia
//
//  Created by Štěpán Pazderka on 10.07.2024.
//

import SwiftUI
import Apollo
import Swapi

struct ContentView: View {
	@State private var films: [FetchFilmsQuery.Data.AllFilms.Film?] = []
	@State private var networkError: Bool = false
	
    var body: some View {
        NavigationSplitView {
			ZStack {
				ProgressView()
				List(films, id: \.self) { film in
					NavigationLink {
						if let film {
							MovieDetailView(film: film)
						}
					} label: {
						Text(film?.title ?? "")
					}
				}
				.listStyle(.insetGrouped)
			}
			.background(.thinMaterial)

			Button {
				self.networkError.toggle()
			} label: {
				Text("Simulate no network")
			}
		} detail: {
			
		}
		.overlay(alignment: .top) {
			Group {
				Text("Problem with network connection")
				.frame(maxWidth: .infinity)
				.colorInvert()
			}
			.padding(20)
			.padding([.top], 10)
			.background(.red)
			.ignoresSafeArea(.all, edges: .top)
			.opacity(networkError ? 1 : 0)
			.animation(.easeInOut, value: networkError)
		}
		.onAppear {
			Network.shared.apollo.fetch(query: FetchFilmsQuery()) { result in
				switch result {
				case .success(let result):
					films = result.data?.allFilms?.films ?? []
				case .failure(let error):
					self.networkError = true
				}
			}
		}
    }
}

#Preview {
    ContentView()
}
