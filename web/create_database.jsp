<%-- 
    Document   : index
    Created on : 27-Apr-2021, 4:52:24 pm
    Author     : Viraj
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import=" java.lang.Math" %>
<%@ page import="java.util.UUID" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Created Form</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">FEEDBACK FORMS</span>
        </nav>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
              <li class="breadcrumb-item"><a href="create.jsp">Create a Form</a></li>
              <li class="breadcrumb-item active" aria-current="page">Created Form</li>
            </ol>
         </nav>
        <div class="d-flex flex-column justify-content-center pl-5 pt-2 bg-white">
            <%
                int num = Integer.parseInt(session.getAttribute("num").toString());
                String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        + "0123456789"
                                        + "abcdefghijklmnopqrstuvxyz";

                StringBuilder uniqueID = new StringBuilder(6);

                for (int i = 0; i < 6; i++) {
                    int index = (int)(AlphaNumericString.length() * Math.random());
                    uniqueID.append(AlphaNumericString.charAt(index));
                }

                String formName = uniqueID.toString();
            %>
            <h4>Your form has been successfully created. Please note this unique ID for all future operations: <span class="bg-warning">" <%=formName%> "</span></h4>
            <%
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/feedbackDB?zeroDateTimeBehavior=CONVERT_TO_NULL","root","");
                Statement statement = connection.createStatement();
                int q1 = statement.executeUpdate("create table " + formName + " (id int PRIMARY KEY);");
                int q2 = statement.executeUpdate("create table " + formName + "_data (feelds varchar(10) PRIMARY KEY, question text, type text);");
                int temp = 1;

                for(int i=1; i<=num; i++) {
                    String input = request.getParameter("input_type" + String.valueOf(i));
                    String question = request.getParameter("question" + String.valueOf(i));
                    if(input.equals("number")) {
                        int q3 = statement.executeUpdate("alter table " + formName + " add field" + String.valueOf(i) + " int;");
                         int q7 = statement.executeUpdate("insert into " + formName + "_data values ('field" + String.valueOf(i) + "', '" + question + "', '" + input + "');");
                    }

                    if(input.equals("text")) {
                        int q4 = statement.executeUpdate("alter table " + formName + " add field" + String.valueOf(i) + " text;");
                        int q8 = statement.executeUpdate("insert into " + formName + "_data values ('field" + String.valueOf(i) + "', '" + question + "', '" + input + "');");
                    }

                    if(input.equals("radio")) {
                        String str = request.getParameter("radioNum" + String.valueOf(i));
                         int q9 = statement.executeUpdate("insert into " + formName + "_data values ('field" + String.valueOf(i) + "', '" + question + "', '" + input + "');");
                        int num_labels = 0; 
                        int n = str.length(); 
                        for(int l=0; l<n; l++) 
                            num_labels = num_labels * 10 + ((int)str.charAt(l) - 48);
                        int q5 = statement.executeUpdate("create table " + formName + "_radioNum" + String.valueOf(temp) + " (id int, FOREIGN KEY (id) REFERENCES " + formName + "(id));");
                        for(int j=1; j<=num_labels; j++) {
                            String label = request.getParameter("label" + String.valueOf(i) + String.valueOf(j));
                            
                            // for int handle
                            int flag = 0;
                            String str1 = label;
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
                                label = str1;
                            }
                            //_______________
                            
                            int q6 = statement.executeUpdate("alter table " + formName +  "_radioNum" + String.valueOf(temp) + " add " + label + " boolean default false;"); 
                        }
                        temp++;
                    }
                }

            %>

            <h4>The generated form is :</h4>
            <div class="m-4 p-4 bg-light text-dark">
                <% for(int a=1; a<=num; a++) { 
                        String question = request.getParameter("question" + String.valueOf(a));
                        String input = request.getParameter("input_type" + String.valueOf(a));
                %>
                <h5 class="mt-3"><%=question%></h5>
                <%      if(input.equals("radio")) {

                            String str = request.getParameter("radioNum" + String.valueOf(a)).toString();

                            int num_labels = 0; 
                            int n = str.length(); 
                            for(int l=0; l<n; l++) 
                                num_labels = num_labels * 10 + ((int)str.charAt(l) - 48);

                            String name = "radioNum" + String.valueOf(a);
                            for(int b=1; b<=num_labels; b++) {
                                String id = "labelNum" + String.valueOf(a) + String.valueOf(b);
                                String label = request.getParameter("label" + String.valueOf(a) + String.valueOf(b)).toString();                       
                    %>          
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" name=<%=name%> id=<%=id%>>
                                    <label class="form-check-label" for=<%=id%>><%=label%></label>
                                </div>
                <%          }
                        }
                        else {
                %>          <input class="form-control col-4 mr-3" type=<%=input%>>
                <%      }
                    }
                %>
            </div>
            <form id="main" method="post" name="main" action="" onsubmit="redirect(this);">
                <input class="btn btn-primary" type="submit" name="submit" value="Home Page"/> 
            </form>
        </div>
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

