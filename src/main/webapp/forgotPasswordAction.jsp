<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = request.getParameter("email");
String mobileNumber = request.getParameter("mobileNumber");
String securityQuestion = request.getParameter("securityQuestion");
String answer = request.getParameter("answer");
String newPassword = request.getParameter("newPassword");

int check = 0;
try {
    Connection con = ConnectionProvider.getCon();
    
    // Use a PreparedStatement for safer and more efficient queries
    String query = "SELECT * FROM users WHERE email=? AND mobileNumber=? AND securityQuestion=? AND answer=?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, email);
    ps.setString(2, mobileNumber);
    ps.setString(3, securityQuestion);
    ps.setString(4, answer);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        check = 1;
        
        // Use another PreparedStatement for the update operation
        String updateQuery = "UPDATE users SET password=? WHERE email=?";
        PreparedStatement psUpdate = con.prepareStatement(updateQuery);
        psUpdate.setString(1, newPassword);
        psUpdate.setString(2, email);
        psUpdate.executeUpdate();
        
        response.sendRedirect("forgotPassword.jsp?msg=done");
    } else {
        response.sendRedirect("forgotPassword.jsp?msg=invalid");
    }
    
    // Close resources
    rs.close();
    ps.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
