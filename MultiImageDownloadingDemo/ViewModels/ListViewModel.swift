//
//  ListViewModel.swift
//  MultiImageDownloadingDemo
//
//  Created by Yiyin Shen on 29/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation

class ListViewModel {
    private var cellViewModels: [ListCellViewModel] {
        return [
            ListCellViewModel(title: "1", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA9SDF-9z4PPy6agcrDVmOgvR_t6U9pIw2PXhJmDCVSECHsURM5A"),
            ListCellViewModel(title: "2", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIl98lxav6HouP0PEofwP97QUe7SqItsU-L26eBx1u8-TyDyJt"),
            ListCellViewModel(title: "3", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyOQKlcRAfISQDqwkckKf3zX3jnRsIE35QeLPCG8ba-3ijofbv"),
            ListCellViewModel(title: "4", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjbNUDTlYRwGHFqDgBIKYrWRprbRPPg2KG9-lMaQ8UVqgehjCBnQ")
        ]
    }

    func cellViewModel(at index: Int) -> ListCellViewModel? {
        guard cellViewModels.indices.contains(index) else { return nil }
        return cellViewModels[index]
    }

    var numberOfRows: Int {
        return cellViewModels.count
    }
}
