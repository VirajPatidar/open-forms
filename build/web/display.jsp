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
        <title>Responses</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">FEEDBACK FORMS</span>
        </nav>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Responses</li>
            </ol>
         </nav>
        <div class="d-flex flex-column justify-content-center align-items-center pl-5 pt-2 bg-white">
            <%
                String formID = request.getParameter("formID").toString();
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/feedbackDB?zeroDateTimeBehavior=CONVERT_TO_NULL","root","");
                Statement statement = connection.createStatement();

                String q = "select count(*) count from " + formID + "_data;";
                ResultSet rs = statement.executeQuery(q);
                String str = "";
                while (rs.next()) {
                    str = rs.getString("count");
                }
                int numFields = Integer.parseInt(str);

                String q1 = "select count(*) count from " + formID + ";";
                ResultSet rs1 = statement.executeQuery(q1);

                String str1 = "";
                while (rs1.next()) {
                    str1 = rs1.getString("count");
                }
                int numRecords = Integer.parseInt(str1);
            %>
            <h4>Responses of Form: <span class="bg-warning"><%=formID%></span></h4>
            <br>
            <table class="table table-bordered col-8">
                <thead class="thead-dark">
                    <tr>
            <%
                    ResultSet rs2;
                    String q2 = "select question from " + formID + "_data;";
                    rs2 = statement.executeQuery(q2);
                    String ques = "";
                    while(rs2.next()) {
                        ques = rs2.getString("question");
            %>              
                        <th scope="col"><%=ques%></th>
            <%
                        }
            %>
                    </tr>
                </thead>
                <tbody>
            <%        
                ResultSet rs3, rs4, rs5, rs6;
                for(int i=1; i<=numRecords; i++) {
            %>
                    <tr>
            <%
                        int temp = 1;
                        for(int j=1; j<=numFields; j++) {    
                            String field = "field" + String.valueOf(j);
                            rs3 = statement.executeQuery("select type from " + formID + "_data where feelds = '" + field + "';");
                            String type = "";
                            while(rs3.next()) {
                                type = rs3.getString("type");
                            }

                            if(!type.equals("radio")) {
                                rs4 = statement.executeQuery("select " + field + " from " + formID + " where id = " + i + ";");
                                String value = "";
                                while(rs4.next()) {
                                    value = rs4.getString(field);
                                }
            %>
                                <td><%=value%></td>
            <%                    
                            }
                            if(type.equals("radio")) {

                                rs6 = statement.executeQuery("SELECT count(*) count FROM information_schema.columns WHERE table_name='" + formID + "_radioNum" + String.valueOf(temp) + "'; ");
                                String number = "";
                                while(rs6.next()) {
                                    number = rs6.getString("count");                                    
                                }
                                int numOptions = Integer.parseInt(number) - 1;


                                rs4 = statement.executeQuery("select * from " + formID + "_radioNum" + String.valueOf(temp) + " where id = " + i + ";");
                                boolean value = false;
                                int k1 = 0;
                                while(rs4.next()) {
                                    for(int k=2; k<=numOptions+1; k++) { 
                                        value = rs4.getBoolean(k);
                                        if(value) {
                                            k1 = k;
                                            break;
                                        }    
                                    }     
                                }
                                rs5 = statement.executeQuery("SELECT column_name FROM information_schema.columns WHERE table_name='" + formID + "_radioNum" + String.valueOf(temp) + "'; ");
                                String option = "";
                                int k2 = 1;
                                while(rs5.next()) {
                                    if(k2 == k1) {
                                        option = rs5.getString("column_name");
                                        break;
                                    }
                                    k2++;
                                }
                                //-----------------------------------
                                int flag = 0;
                                String str0 = option;
                                str0 = str0.toLowerCase();
                                char[] charArray = str0.toCharArray();
                                for (int l = 0; l < charArray.length; l++) {
                                    char ch = charArray[l];
                                    if (ch >= 'a' && ch <= 'z') {
                                        flag = 1;
                                        break;
                                    }
                                }
                                if(flag == 0) {
                                    String[] arrOfStr = str0.split("_", 2);
                                    option = arrOfStr[1];
                                }
                                //-----------------------------------
            %>
                                <td><%=option%></td>
            <%
                                temp++;
                            }
                        }
            %>
                    </tr>
            <%        
                }
            %>                            
                </tbody>
            </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>       
    </body>
</html>
