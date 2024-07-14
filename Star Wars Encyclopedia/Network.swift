//
//  Network.swift
//  Star Wars Encyclopedia
//
//  Created by Štěpán Pazderka on 13.07.2024.
//

import Foundation
import Apollo

class Network {
	static let shared = Network()
	
	lazy var apollo: ApolloClient = {
		let url = URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!
		return ApolloClient(url: url)
	}()
}
