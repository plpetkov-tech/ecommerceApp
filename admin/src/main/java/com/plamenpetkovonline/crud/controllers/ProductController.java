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

import com.plamenpetkovonline.crud.entities.Product;
import com.plamenpetkovonline.crud.repositories.ProductCategoryRepository;
import com.plamenpetkovonline.crud.repositories.ProductRepository;

@Controller
public class ProductController {

        private final ProductRepository productRepository;
        private final ProductCategoryRepository productCategoryRepository;
    
        @Autowired
        public ProductController(ProductRepository productRepository, ProductCategoryRepository productCategoryRepository) {
            this.productCategoryRepository = productCategoryRepository;
            this.productRepository = productRepository;
        }
        
        @GetMapping("/addProduct")
        public String showSignUpForm(Model model, Product product) {
            model.addAttribute("productCategories", productCategoryRepository.findAll());
            return "add-product";
        }
        
        @GetMapping("/index")
        public String index(Model model) {
            List<Product> products = (List<Product>) productRepository.findAll();
            model.addAttribute("products", products);
            return "index";
        }

        @GetMapping
        public String indexDefault(Model model) {
            List<Product> products = (List<Product>) productRepository.findAll();
            model.addAttribute("products", products);
            return "index";
        }

        @PostMapping("/addproduct")
        public String addProduct(@Valid Product product, BindingResult result, Model model) {
            if (result.hasErrors()) {
                return "add-product";
            }
            
            productRepository.save(product);
            model.addAttribute("products", productRepository.findAll());
            return "redirect:/index";
        }
        
        @GetMapping("/edit/{id}")
        public String showUpdateForm(@PathVariable("id") long id, Model model) {
            Product product = productRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid product Id:" + id));
            model.addAttribute("productCategories", productCategoryRepository.findAll());
            model.addAttribute("product", product);
            return "update-product";
        }
        
        @PostMapping("/update/{id}")
        public String updateProduct(@PathVariable("id") long id, @Valid Product product, BindingResult result, Model model) {
            if (result.hasErrors()) {
                product.setId(id);
                return "update-product";
            }
            
            productRepository.save(product);
            model.addAttribute("products", productRepository.findAll());
            return "redirect:/index";
        }
        
        @GetMapping("/delete/{id}")
        public String deleteProduct(@PathVariable("id") long id, Model model) {
            Product product = productRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid product Id:" + id));
            productRepository.delete(product);
            model.addAttribute("products", productRepository.findAll());
            return "index";
        }
}
