<%-- 
    Document   : index
    Created on : 27-Apr-2021, 4:52:24 pm
    Author     : Viraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Create Form</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">FEEDBACK FORMS</span>
        </nav>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Create a Form</li>
            </ol>
        </nav>
        <%
            int num = Integer.parseInt(request.getParameter("formNum"));
            session.setAttribute("num", num);
        %>
        <div class="d-flex flex-column justify-content-center pl-5 pt-2 bg-white">
            <h4>Enter the feedback questions and type of input required :</h4>
            <br>
            <form action="create_database.jsp" method="POST">
                <% for(int i=1; i<=num; i++) { 
                    String ques = "question" + String.valueOf(i);
                    String input = "input_type" + String.valueOf(i);
                    String radio_id = "radioNum" + String.valueOf(i);
                    String radio_go = "radioGo" + String.valueOf(i);
                    String label = "label" + String.valueOf(i);
                %>
                <input type="text" class="form-control col-4 mr-3 mb-2" placeholder="Enter the question..." name=<%=ques%> required>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="text" name=<%=input%> onchange="handleRadio(<%=i%>)" value="text" required>
                        <label class="form-check-label" for="text">Text</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="number" name=<%=input%> onchange="handleRadio(<%=i%>)" value="number" required>
                        <label class="form-check-label" for="number">Integer</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" name=<%=input%> onchange="handleRadio(<%=i%>)" value="radio" required>
                        <label class="form-check-label" for="radio">Radio 
                            <input type="number" class="form-control col-auto mr-3 pl-2" placeholder="Enter the number of options..." 
                                   name=<%=radio_id%> id=<%=radio_id%> style="display:none">
                        </label>
                        <input type="button" value="GO" id=<%=radio_go%> style="display:none"
                            onclick="addLabel(<%=i%>)">                            
                        <div id=<%=label%>></div>
                    </div>
                    <br>
                <% } %>
                <input class="btn btn-success" type="submit" value="Create">
            </form>
        </div>
        <script>
            function handleRadio(x) {
                var y = document.getElementsByName("input_type" + x.toString());
                var n = document.getElementById("radioNum" + x.toString());
                var g = document.getElementById("radioGo" + x.toString());
                
                if(y[2].checked) {
                    n.style.display = 'inline';
                    g.style.display = 'inline';
                }
                if(y[0].checked || y[1].checked) {
                    n.style.display = 'none';
                    g.style.display = 'none';
                }
            }
            function addLabel(x1) {
                var y1 = document.getElementById("label" + x1.toString());
                var n1 = document.getElementById("radioNum" + x1.toString()).value;
                //alert(n1);
                var str = "";
                var i;
                for(i=1; i<=n1; i++) {
                    var s = "label" + x1.toString() + i.toString();
                    str += "<input class=\"form-control col-2\" type=\"text\" name=" + s + ">"; 
                }
                y1.innerHTML = str;
            }
        
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    </body>
</html>
