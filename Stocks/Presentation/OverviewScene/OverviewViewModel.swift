//
//  OverviewViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation
import SwiftData

protocol OverviewViewModelInput {

}

protocol OverviewViewModelOutput {
    
}

protocol OverviewViewModel: OverviewViewModelInput, OverviewViewModelOutput { }

final class DefaultOverviewViewModel: OverviewViewModel {
    
}
