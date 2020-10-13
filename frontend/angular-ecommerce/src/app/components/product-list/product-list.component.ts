import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Product } from 'src/app/common/product';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list-card.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  products: Product[] = [];
  currentCategoryId: number = 1;
  previousCategoryId: number = 1;
  searchMode: boolean = false;

  // new properties for pagination
  thePageNumber: number = 1;
  thePageSize: number = 5;
  theTotalElements: number = 0;

  constructor(private productService: ProductService, 
              private route: ActivatedRoute) { }

  ngOnInit() {
    this.route.paramMap.subscribe(()=> {
      this.listProducts();
    });
 
  }

  listProducts(){

    this.searchMode = this.route.snapshot.paramMap.has('keyword');

    if(this.searchMode){
      this.handleSearchProducts();
    } 
    else {
      this.handleListProducts();
    }

  }

  handleListProducts(){
    // check if "id" param is available
    const hasCategoryId: boolean = this.route.snapshot.paramMap.has('id');

    if(hasCategoryId){
      //get the id param string, convert string to a number using + symbol
      this.currentCategoryId = +this.route.snapshot.paramMap.get('id');
    } else {
      // not category id available ... default to category id 1
      this.currentCategoryId = 1;
    }

    //
    // Check if we have a different category than the previous
    // Note: Angular will reuse a component if it is currently being viewed
    //

    // if we have a different category id than the previous
    // then set the page number (thePageNumber) back to 1
    if (this.previousCategoryId != this.currentCategoryId) {
      this.thePageNumber = 1;
    }

    this.previousCategoryId = this.currentCategoryId;
    console.log(`currentCategoryId= ${this.currentCategoryId}, thePageNumber= ${this.thePageNumber}`);



    // now get the products for given category

    // the pagination in Spring is 0 based and in Angular are 1 based, thats why we have -1 and +1
    this.productService.getProductListPaginate( this.thePageNumber - 1,
                                                this.thePageSize,
                                                this.currentCategoryId)
                                                .subscribe(this.processResult());
  }
  
  processResult() {
    return data => {
      this.products = data._embedded.products;
      this.thePageNumber = data.page.number + 1;
      this.thePageSize = data.page.size;
      this.theTotalElements = data.page.totalElements;
    }
  }

  handleSearchProducts() {
    const theKeyword: string = this.route.snapshot.paramMap.get('keyword');

    // now search for products given that keyword
    this.productService.searchProducts(theKeyword).subscribe(
      data => {
        this.products = data;
      }
    );
  }

  updatePageSize(pageSize:number){
    this.thePageSize = pageSize;
    this.thePageNumber = 1;
    this.listProducts();
  }

}
