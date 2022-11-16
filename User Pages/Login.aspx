<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Test2.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
.myform {
    position: relative;
    display: -ms-flexbox;
    display: flex;
    padding: 1rem;
    /* align-items: center; */
    -ms-flex-direction: column;
    flex-direction: column;
    /* width: 100%; */
    pointer-events: auto;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #9D85BE;
    border-radius: 1.1rem;
    outline: 0;
    /* max-width: 500px; */
}
.login-or {
    position: relative;
    color: #aaa;
    margin-top: 10px;
    margin-bottom: 10px;
    padding-top: 10px;
    padding-bottom: 10px;
}
.hr-or {
    height: 1px;
    margin-top: 0px !important;
    margin-bottom: 0px !important;
}
.span-or {
    display: block;
    position: absolute;
    left: 50%;
    top: -2px;
    margin-left: -25px;
    background-color: #fff;
    width: 50px;
    text-align: center;
}
.font-family-1 {
    font-family: 'Kaushan Script', cursive;
    color: blue;
}
.error-message {
    color: red;
    font-weight: 600;
}
</style>
    <header class="container-fluid" style="margin-top:15px; margin-bottom:15px;">
        <div class="container">
<%--            <div class="row">--%>
              <div class="col-md-6 mx-auto">
                <div class="myform form ">
                    <div class="col-md-12 mb-3 text-center">
                      <h1 class="font-family-1">Login</h1>
                    </div>
    
                                          
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Email Address"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Email is required" Display="Dynamic" ControlToValidate="txtEmail" CssClass="error-message" ValidationGroup="login-form-group" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="* Invalid email format" Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message" ValidationGroup="login-form-group" />
                        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Enter Email" CssClass="form-control" ValidationGroup="login-form-group"></asp:TextBox>
                      <%--<label for="exampleInputEmail1">Email address</label>
                      <input type="email" name="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter Email">--%>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Password is required" Display="Dynamic" ControlToValidate="txtPassword" CssClass="error-message" ValidationGroup="login-form-group" />
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Enter Password" CssClass="form-control" ValidationGroup="login-form-group"></asp:TextBox>
                     <%-- <label for="exampleInputEmail1">Password</label>
                      <input type="password" name="password" class="form-control" aria-describedby="emailHelp" placeholder="Enter Password">--%>
                    </div>
                    <div class="col-md-6 mx-auto ">
                        <asp:Button ID="btnLogin"  style="font-weight: bold;" CssClass="btn btn-block mybtn btn-primary tx-tfm" runat="server" Text="Login" OnClick="Login_Click" ValidationGroup="login-form-group" />
                      <%--<button type="submit" style="font-weight: bold;" class=" btn btn-block mybtn btn-primary tx-tfm">Login</button> --%>
                    </div>
<%--                    <div class="col-md-12 ">
                    <div class="login-or">
                    <hr class="hr-or">
                    <span class="span-or">or</span>
                    </div>
                    </div>
                    <div class="form-group mt-3">
                      <p class="text-center"><a href="/forgot-password">Forgot Password?</a></p>
                    </div>--%>
                    <div class="form-group mt-3">
                      <p class="text-center">Don't have an account? <a href="Register.aspx">Sign up here</a></p>
                    </div>
                  
          
                </div>
              </div>
            </div>
          <%--</div>--%>
       </header>

<%--<script>
    $("#btnLogin").click(function (e) {
        $.ajax({
            type: "POST",
            data: { email: $("#txtEmail").val().trim(), password: $("#txtPassword").val().trim() },
            dataType: 'json', // similar to JSON.parse(data)
            url: "Login.aspx/checkLogin",
            async: false,
            success: function (data) {
                console.log(data.status);
                if (data.status == "fail") {
                    $("#verifyError").text(data.message);
                    return false;
                }
                if (data.status == "success") {
                    swal({
                        title: "Good Job!",
                        text: data.message,
                        icon: "success",
                        button: "OK",
                    }).then(function () {
                        window.location.reload();
                    }
                    );
                }
            }

        });

    });  
</script>--%>

</asp:Content>
