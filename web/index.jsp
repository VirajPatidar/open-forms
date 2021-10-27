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
        <title>Feedback Form</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">FEEDBACK FORMS</span>
        </nav>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item active" aria-current="page">Home</li>
            </ol>
        </nav>
        <div class="d-flex flex-column justify-content-center jumbotron bg-white">
            <h5 class="text-center">Create a New Form</h5>
            <form class="d-flex align-items-center justify-content-center" action = "create.jsp" method = "POST">
                <td><input type="button" class="btn btn-outline-primary mr-3" value="Create a Form" onclick="handleNum()"></td>
                <input type="text" class="form-control col-4 mr-3" placeholder="Enter number of fields..." 
                               name="formNum" id="formNum" style="display:none">
                <input class="btn btn-success btn-sm mr-3" type="submit" value="GO" id="formNumGo" style="display:none">
            </form>
            <br><br>
            <h5 class="text-center">Fill a Form</h5>
            <form class="d-flex align-items-center justify-content-center" action = "fill.jsp" method = "POST">
                <td><input type="button" class="btn btn-outline-primary mr-3" value="Fill a Form" onclick="handleID1()"></td>
                <input type="text" class="form-control col-4 mr-3" placeholder="Enter the form ID..." 
                               name="formID" id="formID1" style="display:none">
                <input class="btn btn-success btn-sm mr-3" type="submit" value="GO" id="formIDGO1" style="display:none">
            </form>
            <br><br>
            <h5 class="text-center">View Responses</h5>
            <form class="d-flex align-items-center justify-content-center" action = "display.jsp" method = "POST">
                <td><input type="button" class="btn btn-outline-primary mr-3" value="Display Records" onclick="handleID2()"></td>
                <input type="text" class="form-control col-4 mr-3" placeholder="Enter the form ID..." 
                               name="formID" id="formID2" style="display:none">
                <input class="btn btn-success btn-sm mr-3" type="submit" value="GO" id="formIDGO2" style="display:none">
            </form>
        </div>
        <script>
            function handleNum() {
                document.getElementById("formNum").style.display = 'inline';
                document.getElementById("formNumGo").style.display = 'inline';
            }
            function handleID1() {
                document.getElementById("formID1").style.display = 'inline';
                document.getElementById("formIDGO1").style.display = 'inline';
            }
            function handleID2() {
                document.getElementById("formID2").style.display = 'inline';
                document.getElementById("formIDGO2").style.display = 'inline';
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    </body>
</html>
