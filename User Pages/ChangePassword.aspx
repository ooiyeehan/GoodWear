<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Test2.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .profile-form {
        padding: 20px;
        line-height: 35px;
    }

    .profile-form-header {
        padding: 10px;
        border-radius: 4px;
        margin-block-end: 1rem;
        background-color: var(--default-bg);
    }

    .profile-form-inputs {
        width: 100%;
        padding: 10px;
    }

    .profile-inputs > * {
        width: 100%;
    }

    .profile-inputs > input,
    .profile-inputs > textarea {
        width: 100%;
        padding: 10px;
        resize: vertical;
        line-height: 20px;
        border-radius: 2px;
        margin-block-end: 1rem;
        border: var(--default-input-border);
    }

    .profile-inputs > input[type=submit] {
        width: 100%;
        padding: 12px;
        cursor: pointer;
        color: var(--div-bg);
        margin-block-end: unset;
        border: 2px solid transparent;
        transition: ease-in-out 250ms;
        background-color: var(--button-bg);
    }

    .profile-inputs > input[type=submit]:hover {
        color: var(--button-bg);
        background-color: var(--div-bg);
        border: 2px solid var(--button-bg);
    }

    .error-message {
        color: red;
        font-weight: 600;
    }
</style>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" SelectCommand="SELECT * FROM [tblCustomer]"></asp:SqlDataSource>
    <div class="col-md-6 mx-auto">
        <div class="profile-form">
            <div class="col-md-12 mb-3 text-center">
                <h2>Change Password</h2>
            </div> 
            <div class="profile-form-inputs">
                <div class="profile-inputs">
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" Text="Old Password"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Old Password is required" Display="Dynamic" ControlToValidate="txtOldPassword" CssClass="error-message" ValidationGroup="change-password-group"  />
                        <asp:Label ID="lblErrorOldPassword" runat="server" Text="Label" Visible="false" CssClass="error-message">* Incorrect Old Password</asp:Label>
                        <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" Placeholder="Enter Old Password" CssClass="form-control" ValidationGroup="change-password-group"></asp:TextBox>
                        <%--<label for="exampleInputEmail1">Password</label>
                        <input type="password" name="password" class="form-control" aria-describedby="emailHelp" placeholder="Enter Password">--%>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="New Password"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* New Password is required" Display="Dynamic" ControlToValidate="txtNewPassword" CssClass="error-message" ValidationGroup="change-password-group"  />
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Placeholder="Enter New Password" CssClass="form-control" ValidationGroup="change-password-group"></asp:TextBox>
                        <%--<label for="exampleInputEmail1">Password</label>
                        <input type="password" name="password" class="form-control" aria-describedby="emailHelp" placeholder="Enter Password">--%>
                    </div>
                    <div class="form-group">
                            <asp:Label ID="Label5" runat="server" Text="Confirm New Password"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Confirm New Password is required" Display="Dynamic" ControlToValidate="confirmpassword" CssClass="error-message" ValidationGroup="change-password-group" />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="* Password does not match" Display="Dynamic" ControlToValidate="confirmpassword" ControlToCompare="txtNewPassword" CssClass="error-message" ValidationGroup="change-password-group" />
                            <asp:TextBox ID="confirmpassword" runat="server" TextMode="Password" Placeholder="Enter Confirm New Password" CssClass="form-control" ValidationGroup="change-password-group"></asp:TextBox>
                        <%-- <label for="exampleInputEmail1">Confirm Password</label>
                        <input type="password" name="password" class="form-control" aria-describedby="emailHelp" placeholder="Confirm Your Password">--%>
                    </div>

                    <div class="col-md-6 mx-auto ">
                        <asp:Button ID="btnChangePassword" style="font-weight: bold;" CssClass="btn btn-block mybtn btn-primary tx-tfm" runat="server" Text="Change Password" OnClick="ChangePassword_Click" ValidationGroup="change-password-group" />
                        <%--<button id="Button1" type="submit" style="font-weight: bold;" class=" btn btn-block mybtn btn-primary tx-tfm" OnClick="Button1_Click">Register</button>--%>
                    </div>
                </div>
            </div>


        </div>


    </div>

</asp:Content>
