import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    double totalPrice = 0;
    currentUser.cart.forEach(
      (Order order)=> totalPrice += order.quantity + order.food.price
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart (${currentUser.cart.length})"
        ),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 140),
        itemCount: currentUser.cart.length,
        itemBuilder: (context, index){
          Order order = currentUser.cart[index];
          return _buildCartItem(order);
        },
        separatorBuilder: (context, index){
          return Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total items:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                  ),
                ),
                Text(
                  "${currentUser.cart.length}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Estimated delivery time:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                  ),
                ),
                Text(
                  "25 min",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total cost:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0
                  ),
                ),
                Text(
                  "\$$totalPrice",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    titlePadding: EdgeInsets.only(top: 0.0),
                    contentPadding: EdgeInsets.only(bottom: 20.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    title: Container(
                      alignment: Alignment.topRight,
                      child: IconButton(icon: Icon(Icons.close), onPressed: (){ Navigator.pop(context); })
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Select Payment Method",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10.0),
                        MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){

                          },
                          child: Text("Cash on Delivery", style: TextStyle(color: Colors.white),),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){

                          },
                          child: Text("Online Payment", style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Container(
                height: 60.0,
                width: 220.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor
                ),
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(Order order) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 140.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        order.food.imageUrl
                      ),
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          order.food.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          order.restaurant.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(width: 0.8, color: Colors.black54)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Text(
                                order.quantity.toString()
                              ),
                              SizedBox(width: 15.0),
                              GestureDetector(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            "\$${order.quantity * order.food.price}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}