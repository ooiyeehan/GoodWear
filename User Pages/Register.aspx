<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Test2.Register" %>
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" DeleteCommand="DELETE FROM [tblCustomer] WHERE [CID] = @CID" InsertCommand="INSERT INTO [tblCustomer] ([fname], [lname], [email], [password], [date_registered], [active]) VALUES (@fname, @lname, @email, @password, @date_registered, @active)" SelectCommand="SELECT * FROM [tblCustomer]" UpdateCommand="UPDATE [tblCustomer] SET [fname] = @fname, [lname] = @lname, [email] = @email, [password] = @password, [date_registered] = @date_registered, [active] = @active WHERE [CID] = @CID">
                <DeleteParameters>
                    <asp:Parameter Name="CID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="fname" Name="fname" Type="String" />
                    <asp:ControlParameter ControlID="lname" Name="lname" Type="String" />
                    <asp:ControlParameter ControlID="email" Name="email" Type="String" />
                    <asp:ControlParameter ControlID="password" Name="password" Type="String" />
                    <asp:ControlParameter ControlID="dtRegistered" DbType="Date" Name="date_registered" />
                    <asp:ControlParameter ControlID="active" Name="active" Type="Byte" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="fname" Type="String" />
                    <asp:Parameter Name="lname" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="password" Type="String" />
                    <asp:Parameter DbType="Date" Name="date_registered" />
                    <asp:Parameter Name="active" Type="Byte" />
                    <asp:Parameter Name="CID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="myform form ">
                        <div class="col-md-12 mb-3 text-center">
                          <h1 class="font-family-1">Sign Up</h1>
                        </div> 
                        

                             <div class="form-group">
                                <asp:Label ID="Label1" runat="server" Text="First Name"></asp:Label>
                                <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="* First Name is required" Display="Dynamic" ControlToValidate="fname" CssClass="error-message" ValidationGroup="register-form-group" />
                                <asp:TextBox ID="fname" runat="server" Placeholder="Enter First Name" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
                            </div>
                             <div class="form-group">
                                 <asp:Label ID="Label2" runat="server" Text="Last Name"></asp:Label>
                                 <asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Last Name is required" Display="Dynamic" ControlToValidate="lname" CssClass="error-message" ValidationGroup="register-form-group" />
                                 <asp:TextBox ID="lname" runat="server" Placeholder="Enter Last Name" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="Email Address"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Email is required" Display="Dynamic" ControlToValidate="email" CssClass="error-message" ValidationGroup="register-form-group" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="* Invalid email format" Display="Dynamic" ControlToValidate="email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message" ValidationGroup="register-form-group" />
                                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="* Email has already been taken" Display="Dynamic" ControlToValidate="email" OnServerValidate="EmailExist_ServerValidate" CssClass="error-message" ValidationGroup="register-form-group" />
                                <asp:TextBox ID="email" runat="server" Placeholder="Enter Email" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Password is required" Display="Dynamic" ControlToValidate="password" CssClass="error-message" ValidationGroup="register-form-group"  />
                                <asp:TextBox ID="password" runat="server" TextMode="Password" Placeholder="Enter Password" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                 <asp:Label ID="Label5" runat="server" Text="Confirm Password"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Confirm password is required" Display="Dynamic" ControlToValidate="confirmpassword" CssClass="error-message" ValidationGroup="register-form-group" />
                                 <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="* Password does not match" Display="Dynamic" ControlToValidate="confirmpassword" ControlToCompare="password" CssClass="error-message" ValidationGroup="register-form-group" />
                                 <asp:TextBox ID="confirmpassword" runat="server" TextMode="Password" Placeholder="Enter Confirm Password" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mx-auto ">
                                <asp:Button ID="btnRegister" style="font-weight: bold;" CssClass="btn btn-block mybtn btn-primary tx-tfm" runat="server" Text="Register" OnClick="Register_Click" ValidationGroup="register-form-group" />
                            </div>
                            <div class="form-group mt-3">
                                <p class="text-center">Already have an account? <a href="Login.aspx">Login Now</a></p>
                            </div>
                        <asp:Label ID="dtRegistered" runat="server" Text="Label" Visible="false"></asp:Label>
                        <asp:Label ID="active" runat="server" Text="Label" Visible="false"></asp:Label>
                    </div>
                </div>
              </div>
          </div>
    </header>

</asp:Content>




