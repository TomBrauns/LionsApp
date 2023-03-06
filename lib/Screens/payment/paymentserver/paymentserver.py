import json
import stripe
import requests
from flask import Flask, request

app = Flask(__name__)

StripePub = 'pk_test_51Mf6KIGgaqubfEkY4mjPoHhaJCcKIl202B51rY22iMrPKfh4mqNREIT0cBn9EmypeyJ92nC7mJpCwWHg1ZexBY8V00BAEi7S8t'
stripe.api_key = 'sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK'
PaypalClient = 'ASWc84JED5XEgNRkOo2_f3JJP94KrXOwcQwig7WQ8HUeGN3Bqwi0xFuHMF1TQ3uEOnNB4IXgFrPw3SKh'
PaypalSec = 'EEXhrXIRxgz5yoyXBNHoSKcXfiZMW0AeNC-YHTjfvRlVDmR-colaC1nZKXW0j3y8sKcdVRzTvNrno-b7'

@app.route('/', methods=['GET','POST'])
def rootresp():
    print('request reached root')
    return {'requestdir': '/',
            'test':'test'}

@app.route('/StripePaymentIntent', methods=['POST'])
def StripePaymentIntent():
    amount = request.form.get('amount')
    currency = request.form.get('currency')
    description = request.form.get('description')

    paymentintent = stripe.PaymentIntent.create(
        amount=amount,
        currency=currency,
        description=description,
        automatic_payment_methods={"enabled": True},
    )
    
    return paymentintent


@app.route('/StripeCreateProduct', methods=['POST'])
def StripeCreateProduct():
    name = request.form.get('name')
    description = request.form.get('description')
    product = stripe.Product.create(
        name=name,
        description=description
    )

    return product

@app.route('/StripeCreatePrice', methods=['POST'])
def StripeCreatePrice():
    currency = request.form.get('currency')
    unit_amount = request.form.get('unit_amount')
    product = request.form.get('product')
    price = stripe.Price.create(
        unit_amount=unit_amount,
        currency=currency,
        product=product,
    )

    return price

@app.route('/StripeUpdateProduct', methods=['POST'])
def StripeUpdateProduct():
    productId=request.form.get('productId')
    price=request.form.get('price')
    
    product=stripe.Product.modify(
        productId,
        price=price
    )
    
    return product

@app.route('/StripeCreateCheckoutSession', methods=['POST'])
def StripeCreateCheckoutSession():
    mode = request.form.get('mode')
    price = request.form.get('price')
    quantity = request.form.get('quantity')
    success_ulr = request.form.get('success_url')
    cancel_url = request.form.get('cancel_url')

    checkoutSession = stripe.checkout.Session.create(
        success_url=success_ulr,
        cancel_url=cancel_url,
        line_items=[
            {
            "price": price,
            "quantity": quantity,
            },
        ],
        mode=mode,
    )
    
    return checkoutSession

@app.route('/PaypalAuthenticate', methods=['POST'])
def PaypalAuthenticate():
    url = '/v1/oauth2/token'
    header = {
        'Accept': 'application/json',
        'Accept-Language': 'en_US',
    }
    body = {
        'grant_type': 'client_credentials'
    }
    auth = (PaypalClient, PaypalSec)
    requestData = requests.post(
                url=url,
                auth=auth,
                header=header,
                body=body
            )
    
    print(requestData.status)
    print(requestData.content)

    return requestData

@app.route('/PaypalPayment', methods=['POST'])
def PaypalPayment():
    auth_token = request.form.get('authToken')
    amount = request.form.get('amount')
    eventId = request.form.get('eventId')
    success_url = request.form.get('success_url')
    cancel_url = request.form.get('cancel_url')
    currency = request.form.get('currency')

    url = '/v1/payments/payment'
    header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + auth_token,
    }
    body = {
        'intent': 'sale',
        'payer': {
            'payment_method': 'paypal',
        },
        'transactions': [
            {
                'amount': {
                'total': amount,
                'currency': currency,
                },
                'description': eventId,
            },
        ],
        'redirect_urls': {
            'return_url': success_url,
            'cancel_url': cancel_url,
        }
    }   
    
    requestData = requests.post(
                url=url,
                header=header,
                body=body
            )
    
    print(requestData.status)
    print(requestData.content)

    return requestData



@app.teardown_request
def show_teardown(exception):
    print('request teardown')