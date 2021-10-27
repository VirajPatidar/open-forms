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
        <title>Fill Form</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">FEEDBACK FORMS</span>
        </nav>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Fill a Form</li>
            </ol>
        </nav>
        <%
            String formID = request.getParameter("formID").toString();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/feedbackDB?zeroDateTimeBehavior=CONVERT_TO_NULL","root","");
            Statement statement = connection.createStatement();
            
            String q1 = "select count(*) count from " + formID + "_data;";
            ResultSet rs1 = statement.executeQuery(q1);
            String countrow = "";
            while (rs1.next()) {
                countrow = rs1.getString(1);
            }
            int numFields = Integer.parseInt(countrow);
            session.setAttribute("formID", formID);
            session.setAttribute("numFields", numFields);
            
            ResultSet rs2, rs3, rs4;
            int temp1 = 1;
            int temp2 = 1;
            
        %>
        <div class="d-flex flex-column justify-content-center pl-5 pt-2 bg-white">
            <h4>Displaying Form: <span class="bg-warning"><%=formID%></span></h4>
            <form class="m-4 p-4 bg-light text-dark" action="fill_database.jsp" method="POST">
            <%
                for(int i=1; i<=numFields; i++) {

                    String field = "field" + String.valueOf(i);
                    String q2 = "select question from " + formID + "_data where feelds = 'field" + String.valueOf(i) + "';";
                    rs2 = statement.executeQuery(q2);
                    String question = "";
                    while (rs2.next()) {
                        question = rs2.getString("question");

            %>
                        <h5 class="mt-4"><%=question%></h5>
            <%      }

                    String q3 = "select type from " + formID + "_data where feelds = 'field" + String.valueOf(i) + "';";
                    rs3 = statement.executeQuery(q3);
                    String type = "";
                    while (rs3.next()) {
                        type = rs3.getString("type");
                    }
                    if(!type.equals("radio")) {
            %>          <input class="form-control col-4 mr-3" type=<%=type%> name=<%=field%>>

            <%      }
                    if(type.equals("radio")) {            
                        String q4 = "SELECT column_name FROM information_schema.columns where table_name = '" + formID + "_radioNum" + String.valueOf(temp1) + "';";
                        rs4 = statement.executeQuery(q4);
                        String label = "";
                        //
                        int flag = 0;
                        //
                        while (rs4.next()) {
                            label = rs4.getString("column_name");
                            if(!label.equals("id")) {

                                //-------------------------------------
                                flag = 0;
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
                                    String[] arrOfStr = str1.split("_", 2);
                                    label = arrOfStr[1];
                                }
                                //-------------------------------------


                                String labelID = "label" + String.valueOf(temp1) + String.valueOf(temp2);
            %>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" name=<%=field%> id=<%=labelID%> value=<%=label%>>
                                <label class="form-check-label" for=<%=labelID%>><%=label%></label>
                            </div>
            <%                  temp2++;
                            }
                        }
                        temp1++;             
                    }
                }
            %>
                <br>
                <input class="btn btn-success" type="submit" value="Submit">
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    </body>
</html>
