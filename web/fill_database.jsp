<%-- 
    Document   : index
    Created on : 27-Apr-2021, 4:52:24 pm
    Author     : Viraj
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Form Submitted</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">FEEDBACK FORMS</span>
        </nav>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
              <li class="breadcrumb-item"><a href="fill.jsp">Fill a Form</a></li>
              <li class="breadcrumb-item active" aria-current="page">Form Submitted</li>
            </ol>
         </nav>
        <div class="d-flex flex-column justify-content-center align-items-center pl-5 pt-2 bg-white">
            <h4>Your form is successfully submitted !!</h4>
        
        <%
            String formID = session.getAttribute("formID").toString();
            int numFields = Integer.parseInt(session.getAttribute("numFields").toString());
            Connection connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/feedbackDB?zeroDateTimeBehavior=CONVERT_TO_NULL","root","");
            Statement statement = connection.createStatement();
            
            String q = "select max(id) id from " + formID + ";";
            ResultSet rs = statement.executeQuery(q);
            String ID = "";
            while (rs.next()) {
                ID = rs.getString("id");
            }
            int id;
            
            ID = ID + "";
            if(ID.equals("null")) {
                id = 1;
            }
            else {
                id = Integer.parseInt(ID);
                id++;
            }

            int q3 = statement.executeUpdate("insert into " + formID + " (id) values(" + id + ");");
            int temp = 1;
            
            for(int i=1; i<=numFields; i++) {
                
                String field = "field" + String.valueOf(i);
                String q1 = "select type from " + formID + "_data where feelds = '" + field + "';";
                ResultSet rs1 = statement.executeQuery(q1);
                String type = "";
                while (rs1.next()) {
                    type = rs1.getString(1);
                }
                
                if(type.equals("text")) {
                    String input = request.getParameter(field).toString();
                    int q2 = statement.executeUpdate("update " + formID + " set " + field + " = '" + input + "' where id = " + id + ";");
                }
                
                if(type.equals("number")) {
                    int input = Integer.parseInt(request.getParameter(field).toString());
                    int q2 = statement.executeUpdate("update " + formID + " set " + field + " = " + input + " where id = " + id + ";");
                }
                
                if(type.equals("radio")) {
                    
                    String input = request.getParameter(field).toString();
                    
                    //--------------------------------
                        int flag = 0;
                        String str1 = input;
                        str1 = str1.toLowerCase();
                        char[] charArray = str1.toCharArray();
                        for (int l=0; l<charArray.length; l++) {
                            char ch = charArray[l];
                            if (ch >= 'a' && ch <= 'z') {
                                flag = 1;
                                break;
                            }
                        }
                        if(flag == 0) {
                            str1 = "0_" + str1;
                            input = str1;
                        }
                    //--------------------------------
                    
                    int q4 = statement.executeUpdate("insert into " + formID + "_radioNum" + String.valueOf(temp) + " (id) values(" + id + ");");
                    int q2 = statement.executeUpdate("update " + formID + "_radioNum" + String.valueOf(temp) + " set " + input + " = true where id = " + id + ";");

                    temp++;
                }
            }
        %>
  
        <br>
        <form id="main" method="post" name="main" action="" onsubmit="redirect(this);">
            <input class="btn btn-primary" type="submit" name="submit" value="Home Page"/> 
        </form>
        
        <script>
            function redirect(elem){
                elem.setAttribute("action","index.jsp");
                elem.submit();
            } 
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    </body>
</html>
