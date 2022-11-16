<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="Test2.ProfilePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 <style>
    :root {
        --div-bg: #FFFFFF;
        --button-bg: #337ab7;
        --default-bg: #f3f3f3;
        --bgColor: rgb(255,99,50);
        --default-border: 2px solid rgba(0, 0, 0, .14);
        --default-bs: 1px 2px 2px 1px rgba(0, 0, 0, 0.2);
        --default-input-border: 2px solid rgba(0, 0, 0, .14);
    }

    .header2, .tab-switches {
        width: 850px; /*45%*/
        margin: 0 auto;
        border-radius: 4px;
        box-shadow: var(--default-bs);
        background-color: var(--div-bg);
    }

    .header2 {
        display: flex;
        align-items: center;
        margin-block-end: 1rem;
        margin-block-start: 1rem;
    }

    .header2 > * {
        padding: 10px;
    }

    .header2 > img {
        width: 70px;
        height: 70px;
        filter: drop-shadow(0 0 0.5rem var(--div-bg));
    }

    .button-switches-parent {
        display: flex;
        border-radius: 4px 4px 0px 0px;
        background-color: var(--button-bg);
    }

    .button-switches {
        width: 100%;
        color: white;
        padding: 16px;
        font-size: 18px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
    }

    .left-radius {
        border-top-left-radius: 4px;
        border-bottom: 4px solid rgb(255,99,50);
    }

    .right-radius {
        border-top-right-radius: 4px;
    }

    .right-radius:hover {
        border-top-left-radius: 4px;
        border-bottom: 4px solid rgb(255,99,50);
    }

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

    .profile-image {
        width: 170px;
        margin: 0 auto;
        min-height: 250px;
    }

    .profile-image > img {
        width: 100%;
        height: 170px;
        border-radius: 50%;
        border: var(--default-input-border);
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

    .profile-inputs > textarea {
        resize: none;
        height: 200px;
    }

    .profile-inputs > input[type=date] {
        resize: none;
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

    .error-box {
        border: 2px solid red;
    }

    .gender tbody {
        display: flex;
        margin-block-end: 1rem;
    }

    .gender tr {
        width: 150px;
    }

    .gender input {
        display: none;
    }

    .gender input:checked + label {
        border: 2px solid var(--bgColor);
    }

    .gender label {
        padding: 12px 50px;
        cursor: pointer;
        min-width: 308px;
        margin-left: -4px;
        border-radius: 2px;
        text-align: center;
        transition: ease-in-out 250ms;
        border: var(--default-border);
    }

    .gender label:hover {
        background-color: rgba(0,0,0,0.1);
    }

</style>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" DeleteCommand="DELETE FROM [tblCustomer] WHERE [CID] = @CID" InsertCommand="INSERT INTO [tblCustomer] ([fname], [lname], [email], [password], [date_registered], [active]) VALUES (@fname, @lname, @email, @password, @date_registered, @active)" SelectCommand="SELECT * FROM [tblCustomer]" UpdateCommand="UPDATE [tblCustomer] SET [fname] = @fname, [lname] = @lname, [email] = @email, [password] = @password, [date_registered] = @date_registered, [active] = @active WHERE [CID] = @CID">
        <DeleteParameters>
            <asp:Parameter Name="CID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="fname" Type="String" />
            <asp:Parameter Name="lname" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter DbType="Date" Name="date_registered" />
            <asp:Parameter Name="active" Type="Byte" />
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
        <div class="col-md-6 mx-auto">
            <div class="profile-form">
                <div class="col-md-12 mb-3 text-center">
                    <h2>My Profile</h2>
                </div>

                <div class="profile-form-inputs">
                    <div class="profile-inputs">
                        <asp:Label ID="Label1" runat="server" Text="First Name" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtFName" ErrorMessage="* First Name is required" CssClass="error-message" ValidationGroup="btnEditGroup" />
    <%--                    <asp:CustomValidator ID="CustomValidator2" runat="server" Display="Dynamic" ControlToValidate="username" ErrorMessage="* Username is already taken" CssClass="error-message" OnServerValidate="UsernameExist_ServerValidate" ValidationGroup="btnEditGroup" />--%>
                        <asp:TextBox ID="txtFName" runat="server" Placeholder="First Name" MaxLength="16" ValidationGroup="btnEditGroup" />

                        <asp:Label ID="Label4" runat="server" Text="Last Name" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ControlToValidate="txtLName" ErrorMessage="* Last Name is required" CssClass="error-message" ValidationGroup="btnEditGroup" />
    <%--                    <asp:CustomValidator ID="CustomValidator2" runat="server" Display="Dynamic" ControlToValidate="username" ErrorMessage="* Username is already taken" CssClass="error-message" OnServerValidate="UsernameExist_ServerValidate" ValidationGroup="btnEditGroup" />--%>
                        <asp:TextBox ID="txtLName" runat="server" Placeholder="First Name" MaxLength="16" ValidationGroup="btnEditGroup" />

                        <asp:Label ID="Label2" runat="server" Text="Email:" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="txtEmail" ErrorMessage="* Email is required" CssClass="error-message" ValidationGroup="btnEditGroup" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="* Invalid email" CssClass="error-message" ValidationGroup="btnEditGroup" />
                         <%--<asp:Label ID="lblErrorEmailExist" runat="server" Text="Label" Visible="false" CssClass="error-message">* Email has already been taken</asp:Label>--%>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="* Email is already taken" Display="Dynamic" ControlToValidate="txtEmail" CssClass="error-message" OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="btnEditGroup" />
                        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email..." ValidationGroup="btnEditGroup" />

                        <asp:Label ID="Label8" runat="server" Text="Delivery Address" />
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Placeholder="Delivery Address" ValidationGroup="btnEditGroup"></asp:TextBox>

                        <asp:Button ID="btnEdit" runat="server" Text="Edit Profile" OnClick="btnEdit_Click" ValidationGroup="btnEditGroup" />
                    </div>
                </div>
            </div>
        </div>
        
</asp:Content>
