package com.plamenpetkovonline.springbootecommerce.dao;

import com.plamenpetkovonline.springbootecommerce.entity.Product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin
public interface ProductRepository extends JpaRepository<Product, Long> {
    
}
