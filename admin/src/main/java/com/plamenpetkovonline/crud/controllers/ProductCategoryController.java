package com.plamenpetkovonline.crud.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.plamenpetkovonline.crud.entities.ProductCategory;
import com.plamenpetkovonline.crud.repositories.ProductCategoryRepository;

@Controller
public class ProductCategoryController {

    private final ProductCategoryRepository productCategoryRepository;

    @Autowired
    public ProductCategoryController(ProductCategoryRepository productCategoryRepository) {
            this.productCategoryRepository = productCategoryRepository;
        }
        
        @GetMapping("/addProductCategory")
        public String showAddCategory(ProductCategory productCategory) {
            return "add-category";
        }
        
        @GetMapping("/categories")
        public String categories(Model model) {
            List<ProductCategory> productCategories = (List<ProductCategory>) productCategoryRepository.findAll();
            model.addAttribute("productCategories", productCategories);
            return "categories";
        }


        @PostMapping("/addcategory")
        public String addCategory(@Valid ProductCategory productCategory, BindingResult result, Model model) {
            if (result.hasErrors()) {
                return "add-category";
            }
            
            productCategoryRepository.save(productCategory);
            model.addAttribute("productCategories", productCategoryRepository.findAll());
            return "redirect:/categories";
        }
        
        @GetMapping("/cat/edit/{id}")
        public String showUpdateFormCategory(@PathVariable("id") long id, Model model) {
            ProductCategory productCategory = productCategoryRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid productCategory Id:" + id));
            model.addAttribute("productCategory", productCategory);
            return "update-category";
        }
        
        @PostMapping("/cat/update/{id}")
        public String updateProductCategory(@PathVariable("id") long id, @Valid ProductCategory productCategory, BindingResult result, Model model) {
            if (result.hasErrors()) {
                productCategory.setId(id);
                return "update-category";
            }
            
            productCategoryRepository.save(productCategory);
            model.addAttribute("productCategories", productCategoryRepository.findAll());
            return "redirect:/categories";
        }
        
        @GetMapping("/cat/delete/{id}")
        public String deleteProductCategory(@PathVariable("id") long id, Model model) {
            ProductCategory productCategory = productCategoryRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid productCategory Id:" + id));
            productCategoryRepository.delete(productCategory);
            model.addAttribute("productCategories", productCategoryRepository.findAll());
            return "categories";
        }
}
