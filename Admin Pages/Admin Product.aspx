<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin Product.aspx.cs" Inherits="Test2.Admin_Pages.Admin_Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .GridStyle th{
        background-color: #1691CB;
        color: #ffffff;
        vertical-align: middle;
    }
    .GridStyle td{
        vertical-align: middle;
    }
    .features .btn{
        margin: 0 !important;
    }
    .btn-danger{
        background-color: #dc3545 !important;
        border-color: #dc3545 !important;
    }
    .btn-primary{
        background-color: #007bff !important;
        border-color: #007bff !important;
    }

</style>
    

    <div class="container features">
          <h1 class="text-center">Manage Products</h1>
                <asp:Button ID="btnAdd" CssClass="btn btn-primary" style=" border-radius: 0.25rem !important; margin-bottom:20px !important" runat="server" OnClick="btnAdd_Click" Text="Add New Product" ValidationGroup="login-form-group" />
          <asp:GridView ID="GridView1" CssClass="GridStyle table table-bordered table-condensed table-responsive table-hover text-center" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="PID" HeaderText="PID"  />
                <asp:BoundField DataField="p_name" HeaderText="Name" />
                <asp:BoundField DataField="p_description" HeaderText="Description" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                          RM <%# Convert.ToDouble(Eval("p_price")).ToString("#,##0.00") %> 
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="p_stock" HeaderText="Stock" />
                <asp:BoundField DataField="p_dateAdded" HeaderText="Date Added" />
                <asp:TemplateField HeaderText="Image">
                    <%--<EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("p_image") %>'></asp:TextBox>
                    </EditItemTemplate>--%>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# ImagePath(Eval("p_image").ToString()) %>' />
                        <%--<asp:Label ID="Label1" runat="server" Text='<%# Bind("p_image") %>'></asp:Label>--%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CategoryID" HeaderText="Category ID" />
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <a class="btn btn-primary" id='<%# Eval("PID").ToString() %>' href='Edit Product.aspx?PID=<%# Eval("PID").ToString() %>' ">Edit</a>
                        <a class="btn btn-danger" href='Admin Product.aspx?PID=<%# Eval("PID").ToString() %>' onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
                 <EmptyDataTemplate>
                    <div align="center">No records found.</div>
                </EmptyDataTemplate>
        </asp:GridView>
    </div>

</asp:Content>
