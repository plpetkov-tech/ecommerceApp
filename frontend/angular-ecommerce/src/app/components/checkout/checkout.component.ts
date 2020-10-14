import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {

  checkoutFormGroup: FormGroup;

  totalPrice: number = 0;
  totalQuantity: number = 0;

  constructor(private router: Router,private formBuilder: FormBuilder) { }

  ngOnInit(){
    this.checkoutFormGroup = this.formBuilder.group({
      customer: this.formBuilder.group({
        firstName: [''],
        lastName: [''],
        email: ['']
      }),
      shippingAddress: this.formBuilder.group({
        street: [''],
        country: [''],
        state: [''],
        zipCode: [''],
        city: ['']
      }),
      billingAddress: this.formBuilder.group({
        street: [''],
        country: [''],
        state: [''],
        zipCode: [''],
        city: ['']
      })
    });
  }

  onSubmit(){
    this.router.navigateByUrl('/payment');
  }

  copyShippingAddressToBillingaddress(event:any){
    if(event.target.checked){
      this.checkoutFormGroup.controls.billingAddress
          .setValue(this.checkoutFormGroup.controls.shippingAddress.value);
    }
    else {
      this.checkoutFormGroup.controls.billingAddress.reset();
    }
  }



}
