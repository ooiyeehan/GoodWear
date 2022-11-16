<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Add Product.aspx.cs" Inherits="Test2.Admin_Pages.Add_Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .error-message {
        color: red;
        font-weight: 600;
    }

</style>
    <div class="container features">
        <h1 class="text-center">Add New Product</h1>
            <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Product Name"></asp:Label>
            <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Product Name is required" Display="Dynamic" ControlToValidate="txtName" CssClass="error-message" ValidationGroup="register-form-group" />
            <asp:TextBox ID="txtName" runat="server" Placeholder="Enter Product Name" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
            <%-- <label for="exampleInputEmail1">First Name</label>
            <input type="text" name="fname" class="form-control" aria-describedby="emailHelp" placeholder="Enter First Name">--%>
        </div>
            <div class="form-group">
                <asp:Label ID="Label2" runat="server" Text="Product Description"></asp:Label>
                <asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Product Description is required" Display="Dynamic" ControlToValidate="txtDescription" CssClass="error-message" ValidationGroup="register-form-group" />
                <asp:TextBox ID="txtDescription" runat="server" Placeholder="Enter Product Description" CssClass="form-control" TextMode="MultiLine" ValidationGroup="register-form-group"></asp:TextBox>
            <%-- <label for="exampleInputEmail1">Last Name</label>
            <input type="text" name="lname" class="form-control" aria-describedby="emailHelp" placeholder="Enter Last Name">--%>
        </div>
        <div class="form-group">
            <asp:Label ID="Label3" runat="server" Text="Price"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Price is required" Display="Dynamic" ControlToValidate="txtPrice" CssClass="error-message" ValidationGroup="register-form-group" />
            <%--<asp:Label ID="lblErrorEmailExist" runat="server" Text="Label" Visible="false" CssClass="error-message">* Email has already been taken</asp:Label>--%>
            <%--<asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="* Email has already been taken" Display="Dynamic" ControlToValidate="email" OnServerValidate="EmailExist_ServerValidate" CssClass="error-message" ValidationGroup="register-form-group" />--%>
            <asp:TextBox ID="txtPrice" runat="server" Placeholder="Enter Price" TextMode="Number" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
            <%--<label for="exampleInputEmail1">Email address</label>
            <input type="email" name="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter Email">--%>
        </div>
        <div class="form-group">
            <asp:Label ID="Label4" runat="server" Text="Stock/Quantity"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Stock/Quantity is required" Display="Dynamic" ControlToValidate="txtStock" CssClass="error-message" ValidationGroup="register-form-group"  />
            <asp:TextBox ID="txtStock" runat="server" TextMode="Number" Placeholder="Enter Stock/Quantity" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
            <%--<label for="exampleInputEmail1">Password</label>
            <input type="password" name="password" class="form-control" aria-describedby="emailHelp" placeholder="Enter Password">--%>
        </div>
        <div class="form-group">
            <asp:Label ID="Label5" runat="server" Text="Image"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Image is required" Display="Dynamic" ControlToValidate="txtImage" CssClass="error-message" ValidationGroup="register-form-group"  />
            <br />
            <asp:FileUpload ID="txtImage" runat="server" />
        </div>
        <div class="form-group">
            <asp:Label ID="Label6" runat="server" Text="Category"></asp:Label>
            <asp:DropDownList ID="ddlCategory" CssClass="form-control" runat="server" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="CategoryID"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" SelectCommand="SELECT tblCategory.* FROM tblCategory"></asp:SqlDataSource>
        </div>
        <asp:Label ID="lblDateAdded" runat="server" Text="Label" Visible="false"></asp:Label>
        <div class="col-md-6 mx-auto ">
            <asp:Button ID="btnAdd" style="font-weight: bold;" CssClass="btn btn-block mybtn btn-primary tx-tfm" runat="server" Text="Add Product" OnClick="btnAdd_Click" ValidationGroup="register-form-group" />
            <%--<button id="Button1" type="submit" style="font-weight: bold;" class=" btn btn-block mybtn btn-primary tx-tfm" OnClick="Button1_Click">Register</button>--%>
        </div>
    </div>
</asp:Content>
