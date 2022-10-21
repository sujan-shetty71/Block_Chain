**Project: Logistics Tracing application with Ethereum and Ganache**
=======
 
**Project Status** : 
   -------------

   >completed and working as expected.
------------------
**Deployment Summary** :
   -----------------

> Total deployments:   5

> Final cost:          0.12000652 ETH
---------------------------------

 >**Application flow Example**:
 
    -> Seller       -      addProduct
    -> Buyer        -      chooseSeller (Seller_Contract_Address)
    -> Buyer        -      requestProductQuotes by using product ID
    -> Buyer        -      Buy product by providing (product_ID, Buyer_Name, Buyer_Phone,location, Buyer_EmailID,freight forwarder address which he interested recieve order , amount)
    ->Buyer         -      Book Freight Forwarder by sending appropriate wei(in our application 100 wei) then your will get confirmed at seller.
    -> Seller       -      View Orders (Order details and buyer details)
    -> Seller       -      viewBuyerDetails (only Seller authorized)
    -> seller       -     set logistic address which you recived from customer.
    ->seller        -      approve this order [which means it sent to appropriate Freight forwarder]
------------------------------------
    ->Frieght Forwarder - set 3 addrese(seller , buyer , port clearence) beacuse this contract has to be contat with remaining 3 contracts (to track,send request to port clearence etc)
    ->Frieght Forwarder - enter oid click on received order from seller
    ->`Frieght Forwarder - enter oid and click on send to port clearence
    --> now you can track your order by enetering valid oid
    --> other functionality implemented at ff (optional).
-------------------------------------------
    --> port clearence - set logistic address to receive port clearence request from FF.
    --> port clearence - enetr the oid and click on export clearence.
    --> port clearence - enetr the oid and click on import clearence.

after completing above steps tracking will show out for delivary. 

--------
>**NOTE** : 

1.You can tarck your order at any stage you will get proper response in console.

2.if you missed any steps you will get proper error message .

--------------------
>**Application flow**:

> 1.Selller

* Add Product

* view product

*  View orders [step 2 is required]

* set logistic address [step 2 is required]

* approve order [step 2 is required]

* Buyer Details [step 2 is required]

>2.Buyer

* Set seller

* set logistic

* view products

* Buy products [if it is availabl]

* Book Freight Forwarder to confirm your order

* Track Order 

* Order received[when it delivered to the customer, he wiil update]

>3.Freight Forwarder 

*  set 3 addrese(seller , buyer , port clearence) beacuse this contract has to be contat with remaining 3 contracts (to track,send request to port clearence etc)

* once packing is done from seller(approve order) it will allow you to confirm order recieved at ff .

* once you confirm order recieved at ff, now you can able to send request to port clearence .

* tracking

>4.Port clearence 

* set logistic address to start import clearence

* import clearence

* export clearence

-----------

>**Author Details** :

`Name : Sujan Shetty`

`Email : sujanshetty777@gmail.com`