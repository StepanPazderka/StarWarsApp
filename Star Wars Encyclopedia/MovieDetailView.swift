//
//  MovieDetail.swift
//  Star Wars Encyclopedia
//
//  Created by Štěpán Pazderka on 14.07.2024.
//

import SwiftUI
import Swapi

struct MovieDetailView: View {
	
	let film: FetchFilmsQuery.Data.AllFilms.Film
	@State var releaseDate: Date?
	
	init(film: FetchFilmsQuery.Data.AllFilms.Film) {
		self.film = film
		
		let inputDateFormatter = DateFormatter()
		inputDateFormatter.dateFormat = "yyyy-MM-dd"
		
		guard let releaseDate = film.releaseDate else { return }
		let date = inputDateFormatter.date(from: releaseDate)
		self._releaseDate = State(wrappedValue: date)
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(film.title ?? "")
				.font(.largeTitle)
			Text(releaseDate?.formatted(date: .complete, time: .omitted) ?? "")
				.font(.callout)
			Spacer()
				.frame(maxHeight: 20)
			HStack {
				Text("Director")
					.foregroundStyle(.secondary)
				Text(film.director ?? "")
			}
		}
		.containerRelativeFrame(.horizontal)
		.padding(20)
    }
}

#Preview {
	MovieDetailView(film: FetchFilmsQuery.Data.AllFilms.Film(_dataDict: DataDict(data: ["__typename": "Film", "title" : "Preview title of a movie", "director" : "Stepan Pazderka", "releaseDate" : "2016-10-08"], fulfilledFragments: Set<ObjectIdentifier>())))
}
