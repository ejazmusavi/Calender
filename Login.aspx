<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CTA_NEW_PORTAL.Modules.Home.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="../../Images/Icons/favicon.ico" />
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <!--===============================================================================================-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha256-eZrrJcwDc/3uDhsdt61sL2oOBY362qM3lon1gyExkL0=" crossorigin="anonymous" />
    
    <link href="../../CSS/Plugin/font-awesome-animation.css" rel="stylesheet" />
    <!--===============================================================================================-->
    <link href="Content/util.css" rel="stylesheet" type="text/css" />
    <link href="Content/main.css" rel="stylesheet" type="text/css" />
    <!--===============================================================================================-->
    <style>
        .login100-form {
            /*width: 560px;
            min-height: 100vh;*/
            min-width: 360px;
            /*display: block;*/
            background-color: #f7f7f7;
            padding: 20px 55px 55px 55px !important;
        }
    </style>
</head>
<body>
     <%--<form id="form1" runat="server">--%>
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <form class="login100-form validate-form" >

                    <span class="login100-form-title p-b-43"><img src="Content/Markazia-brands.png" width="452" height="242" alt="Markazia" /></span>

                    <div id="tabsContainer">
                        
                        <div id="tabs-1" class="panel1">

                            <span class="login100-form-title p-b-43">Login to continue</span>

                            <div class="wrap-input100 validate-input" data-validate="Valid email is required: ex@abc.xyz">
                                <input id="txtEmail" class="input100" type="text" name="email" />
                                <%-- Add 'TextMode' property to Asp textbox control unlike html control to run the Regex Validation of JavaScript --%>
                                <%--<asp:TextBox ID="txtEmail" runat="server" class="input100 inputval" name="email" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                <span class="focus-input100"></span>
                                <span class="label-input100">User Name</span>
                            </div>

                            <div class="wrap-input100 validate-input" data-validate="Password is required">
                                <input id="txtPassword" class="input100" type="password" name="pass" />
                                <%--<asp:TextBox ID="txtPassword" runat="server" class="input100 inputval" name="pass" TextMode="Password"></asp:TextBox>--%>
                                <span class="focus-input100"></span>
                                <span class="label-input100">Password</span>
                            </div>

                            <div>
                                <label id="response"> </label>
                            </div>

                            <div class="container-login100-form-btn">
                                <button id="btnLogin" type="button" class="login100-form-btn" onclick="login();">
                                Login
                            </button> 

                                <%--<asp:LinkButton ID="lbtnLogin" runat="server" CssClass="login100-form-btn" OnClientClick="javascript:return login();" Text="Login" OnClick="btnLogin_OnClick" />--%>
                            
                            </div>
                            
                            

                            <div class="text-center p-t-46 p-b-20">
                                <%--<span class="txt2">or sign up using
                            </span>--%>
                                <%--<a href="#" class="txt1">Register</a>--%>
                            </div>

                        </div>

                       
                        <div class="login100-form-social flex-c-m m-top">
                            <a href="https://www.facebook.com/ToyotaJordan" class="login100-form-social-item flex-c-m bg1 m-r-5" target="_blank">
                                <i class="fa fa-facebook-f" aria-hidden="true"></i>
                            </a>

                            <a href="https://twitter.com/ToyotaJordan" class="login100-form-social-item flex-c-m bg2 m-r-5" target="_blank">
                                <i class="fa fa-twitter" aria-hidden="true"></i>
                            </a>

                            <a href="https://www.pinterest.com/toyotajordan" class="login100-form-social-item flex-c-m bg3 m-r-5" target="_blank">
                                <i class="fa fa-pinterest" aria-hidden="true"></i>
                            </a>

                            <a href="https://jo.linkedin.com/pub/toyota-jordan/a6/85a/924" class="login100-form-social-item flex-c-m bg4 m-r-5" target="_blank">
                                <i class="fa fa-linkedin" aria-hidden="true"></i>
                            </a>

                            <a href="https://instagram.com/toyotajo/" class="login100-form-social-item flex-c-m bg5 m-r-5" target="_blank">
                                <i class="fa fa-instagram" aria-hidden="true"></i>
                            </a>

                            <a href="https://www.youtube.com/user/ToyotaCTAJordan" class="login100-form-social-item flex-c-m bg6 m-r-5" target="_blank">
                                <i class="fa fa-youtube" aria-hidden="true"></i>
                            </a>
                        </div>

                    </div>
                    
                </form>

                <div class="login100-more" style="background-image: url('Content/bg.jpg');">
                </div>
                
            </div>
        </div>
    </div>



    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <!--===============================================================================================-->
    
    <script type="application/javascript">


        var base = 'http://api.markaziasystems.com/api/v1/';
        //base = 'http://apis.markazia.jo/api/v1/';
        //base ='http://localhost:4500/api/v1/'
        //base = 'http://localhost:4500/api/v1/';

        $('.input100').on('change', function () {
            if ($(this).val().trim() != "") {
                $(this).addClass('has-val');
            } else {
                $(this).removeClass('has-val');
            }
        })
        $(function(){
setTimeout(function () {
            //$('#txtEmail').val('');
            //$('#txtPassword').val('')
            $('.input100').trigger('change');
        }, 10);
        $('.input100').trigger('change');
        })
        
        function login() {

            var mybutton = document.getElementById("btnLogin");
            $(mybutton).css("opacity", "0.5");
            $(mybutton).css("cursor", "default");
            $(mybutton).attr("disabled", "disabled");
            mybutton.innerHTML = "Login &nbsp;<i style='font-size:20px;' class='fa fa-spinner faa-spin animated'></i>";

            var options = {};
            options.url = base +"Accounts/login";

            options.type = "POST";

            var obj = {};

            obj.userName = $('#txtEmail').val();
            obj.password = $('#txtPassword').val();

            options.data = JSON.stringify(obj);
            options.contentType = "application/json; charset=utf8";
            options.dataType = "json";

            options.success = function (obj) {
                //start Service Center
                $.ajax({
                    type: "GET",
                    url: base + "ServiceCenters/SC_GetServiceCenters",
                    headers: {
                        'Access-Control-Allow-Headers': 'Authorization',
                        'Authorization': 'Bearer ' + obj.Data.Token
                    },
                    dataType: 'json',
                    success: function (result, status, xhr) {
                        if (!result.Success) {
                            resetBtn()
                            $("#response").html("<h5 class='text-danger my-2' >You have no service center assigned.</h5>");
                            return false;
                        }
                        if (result.Data.length == 0) {
                            resetBtn()
                            $("#response").html("<h5 class='text-danger my-2' >You have no service center assigned.</h5>");
                            return false;
                        }

                        localStorage.setItem("token", obj.Data.Token);
                        localStorage.setItem("BusinessAreaId", obj.Data.User.BusinessAreaId);
                        resetBtn()
                        $("#response").html("<h5 class='text-info my-2' >User successfully logged in.</h5>");
                        $(location).attr("href", '/Default');

                    },
                    error: function (xhr, status, error) {
                        //alert(xhr);
                        scheduleObj.hideSpinner();
                        resetBtn()
                        $("#response").html("<h5 class='text-danger my-2' >Error in Service Center data.</h5>");
                    }
                });
                //End Service center

            };
            options.error = function () {
                $("#response").html("<h4 class='text-danger my-2' >Error while trying to login!</h4> ");
                resetBtn()

            };
            $.ajax(options);
        }

        function resetBtn() {
            var mybutton = document.getElementById("btnLogin");
            $(mybutton).css("opacity", "1");
            $(mybutton).css("cursor", "pointer");
            $(mybutton).removeAttr("disabled");
            mybutton.innerHTML = "Login";
        }
    </script>

    <%--<script type="application/javascript" src="https://api.ipify.org?format=jsonp&callback=getIP"></script>--%>


    <%--</form>--%>

</body>
</html>
