<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobileNumber = request.getParameter("mobileNumber");
String securityQuestion = request.getParameter("securityQuestion");
String answer = request.getParameter("answer");
String password = request.getParameter("password");
String address = "";
String city = "";
String state = "";
String country = "";


if (email == null || email.trim().isEmpty()) {
    response.sendRedirect("signup.jsp?msg=email_required");
    return;
}

Connection con = null;
PreparedStatement ps = null;

try {
    con = ConnectionProvider.getCon();
    String query = "INSERT INTO users (name, email, mobileNumber, securityQuestion, answer, password, address, city, state, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    ps = con.prepareStatement(query);
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, mobileNumber);
    ps.setString(4, securityQuestion);
    ps.setString(5, answer);
    ps.setString(6, password);
    ps.setString(7, address);
    ps.setString(8, city);
    ps.setString(9, state);
    ps.setString(10, country);
    ps.executeUpdate();
    response.sendRedirect("signup.jsp?msg=valid");
    
} catch (Exception e) {
    System.out.println("Error: " + e.getMessage());
    response.sendRedirect("signup.jsp?msg=invalid");
} finally {
    try {
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException ex) {
        System.out.println("Error closing resources: " + ex.getMessage());
    }
}
%>
