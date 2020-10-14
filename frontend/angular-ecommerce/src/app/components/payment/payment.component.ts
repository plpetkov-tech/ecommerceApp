import { Component, OnInit } from '@angular/core';
import { NgPaymentCardModule } from 'ng-payment-card';

@Component({
  selector: 'app-payment',
  templateUrl: './payment.component.html',
  styleUrls: ['./payment.component.css']
})
export class PaymentComponent implements OnInit {

  constructor(private payment:NgPaymentCardModule) { }

  ngOnInit(): void {
  }

}
