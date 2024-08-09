<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@include file="footer.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/addressPaymentForOrder-style.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Home</title>
<script>
if(window.history.forward(1) !=null)
	window.history.forward(1);
</script>
</head>
<body>
<br>
<table>
<thead>
<%
String email = session.getAttribute("email").toString();
int total = 0;
int sno = 0;
String address = "";
String city = "";
String state = "";
String country = "";
String mobileNumber = "";

try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    ResultSet rs1 = st.executeQuery("select sum(total) from cart where email='" + email + "' and address is NULL");
    if (rs1.next()) {
        total = rs1.getInt(1);
    }
    rs1.close();
%>
<tr>
    <th scope="col"><a href="myCart.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></th>
    <th scope="col" style="background-color: yellow;">Total: <i class="fa fa-inr"></i><%= total %></th>
</tr>
</thead>
<thead>
<tr>
    <th scope="col">S.No</th>
    <th scope="col">Product Name</th>
    <th scope="col">Category</th>
    <th scope="col"><i class="fa fa-inr"></i> price</th>
    <th scope="col">Quantity</th>
    <th scope="col">Sub Total</th>
</tr>
</thead>
<tbody>
<%
    ResultSet rs = st.executeQuery("select * from product inner join cart on product.id=cart.product_id and cart.email='" + email + "' and cart.address is NULL");
    while (rs.next()) {
%>
<tr>
    <td><%= ++sno %></td>
    <td><%= rs.getString(2) %></td>
    <td><%= rs.getString(3) %></td>
    <td><i class="fa fa-inr"></i> <%= rs.getString(4) %></td>
    <td><%= rs.getString(8) %></td>
    <td><i class="fa fa-inr"></i> <%= rs.getString(10) %></td>
</tr>
<%
    }
    rs.close();

    ResultSet rs2 = st.executeQuery("select * from users where email='" + email + "'");
    if (rs2.next()) {
        address = rs2.getString(7);
        city = rs2.getString(8);
        state = rs2.getString(9);
        country = rs2.getString(10);
        mobileNumber = rs2.getString(3);
    }
    rs2.close();
    st.close();
    con.close();
%>
</tbody>
</table>

<hr style="width: 100%">
<form action="addressPaymentForOrderAction.jsp" method="post">
<div class="left-div">
<h3>Enter Address</h3>
<input class="input-style" type="text" name="address" value="<%= address %>" placeholder="Enter address" required>
</div>

<div class="right-div">
<h3>Enter city</h3>
<input class="input-style" type="text" name="city" value="<%= city %>" placeholder="Enter city" required>
</div> 

<div class="left-div">
<h3>Enter State</h3>
<input class="input-style" type="text" name="state" value="<%= state %>" placeholder="Enter state" required>
</div>

<div class="right-div">
<h3>Enter country</h3>
<input class="input-style" type="text" name="country" value="<%= country %>" placeholder="Enter country" required>
</div>
<h3 style="color: red">*If there is no address it means that you did not set your address!</h3>
<h3 style="color: red">*This address will also be updated to your profile</h3>
<hr style="width: 100%">
<div class="left-div">
<h3>Select way of Payment</h3>
 <select class="input-style" name="paymentMethod">
     <option value="Cash on delivery">Cash on delivery</option>
     <option value="online payment">Online payment</option>
 </select>
</div>

<div class="right-div">
<h3>Pay online on this abinash3020003@pay.com</h3>
<input class="input-style" type="text" name="transactionId" placeholder="Enter transactionId" required>
<h3 style="color: red">*If you select online Payment then enter your transaction ID here otherwise leave this blank</h3>
</div>
<hr style="width: 100%">

<div class="left-div">
<h3>Mobile Number</h3>
<input class="input-style" type="text" name="mobileNumber" value="<%= mobileNumber %>" placeholder="Enter Mobile Number" required>
<h3 style="color: red">*This mobile number will also be updated to your profile</h3>
</div>
<div class="right-div">
<h3 style="color: red">*If you enter the wrong transaction ID then your order may be canceled!</h3>
<button class="button" type="submit">Proceed to generate bill & save <i class='far fa-arrow-alt-circle-right'></i></button>
<h3 style="color: red">*Fill the form correctly</h3>
</div>
</form>
<% 
}
catch(Exception e){
	System.out.println(e);
}%>
<br>
<br>
<br>

</body>
</html>
