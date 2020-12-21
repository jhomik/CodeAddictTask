//
//  Error.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 13/12/2020.
//

import Foundation

enum CustomErrors: String, Error {
    case invalidRequest = "This repository have invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    case noRepositoriesSearch = "There is no repositories available with that name, try again."
}
