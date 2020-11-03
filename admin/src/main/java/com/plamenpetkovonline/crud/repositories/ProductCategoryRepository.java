package com.plamenpetkovonline.crud.repositories;

import com.plamenpetkovonline.crud.entities.ProductCategory;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductCategoryRepository extends CrudRepository<ProductCategory, Long> {
    
}
