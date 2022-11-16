<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin Category.aspx.cs" Inherits="Test2.Admin_Pages.Admin_Category" %>
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
    .error-message {
        color: red;
        font-weight: 600;
    }
</style> 
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" DeleteCommand="DELETE FROM [tblCategory] WHERE [CategoryID] = @CategoryID" InsertCommand="INSERT INTO [tblCategory] ([name]) VALUES (@name)" SelectCommand="SELECT * FROM [tblCategory]" UpdateCommand="UPDATE [tblCategory] SET [name] = @name WHERE [CategoryID] = @CategoryID">
        <DeleteParameters>
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtName" Name="name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <div class="container features">
        <h1 class="text-center">Manage Categories</h1><br /><br />
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Category Name:"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Name is required" Display="Dynamic" ControlToValidate="txtName" CssClass="error-message" ValidationGroup="login-form-group" />
            <asp:TextBox ID="txtName" runat="server" Placeholder="Enter Category Name" CssClass="form-control col-lg-3" ValidationGroup="login-form-group"></asp:TextBox>
        </div>
        <asp:Button ID="btnAdd" CssClass="btn btn-primary" style=" border-radius: 0.25rem !important; margin-bottom:20px !important" runat="server" OnClick="btnAdd_Click" Text="Add New Category" ValidationGroup="login-form-group" />
        <asp:GridView ID="GridView1" CssClass="GridStyle table table-bordered table-condensed table-responsive table-hover" style="display:inline-table;" runat="server" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting"  AutoGenerateColumns="False" AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="CategoryID" HeaderText="Category ID" ReadOnly="true"/>
                <asp:TemplateField HeaderText="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
                <EmptyDataTemplate>
                    <div align="center">No records found.</div>
                </EmptyDataTemplate>
        </asp:GridView>

    </div>

</asp:Content>

