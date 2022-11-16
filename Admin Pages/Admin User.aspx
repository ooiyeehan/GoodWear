<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin User.aspx.cs" Inherits="Test2.Admin_Pages.Admin_Home" %>
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
        <h1 class="text-center">Manage Users</h1>
        <asp:GridView ID="GridView1" CssClass="GridStyle table table-bordered table-condensed table-responsive table-hover text-center" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand" AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="CID" HeaderText="CID" />
                <asp:BoundField DataField="fname" HeaderText="First Name" />
                <asp:BoundField DataField="lname" HeaderText="Last Name" />
                <asp:BoundField DataField="email" HeaderText="Email" />
                <asp:BoundField DataField="date_registered" HeaderText="Date Registered" />
                <asp:BoundField DataField="address" HeaderText="Address" />
                <asp:BoundField DataField="active" HeaderText="Active" />
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>                
                        <a class="btn btn-success" style='<%# DisplayReactivate(Convert.ToInt32(Eval("active"))) %>' id=': <%# Eval("CID").ToString() %>' href='Admin User.aspx?DUID=<%# Eval("CID").ToString() %>' onclick="return confirm('Are you sure you want to reactivate this user?')">Reactivate</a>
                        <a class="btn btn-danger" style='<%# DisplayDeactivate(Convert.ToInt32(Eval("active"))) %>' id='<%# Eval("CID").ToString() %>' href='Admin User.aspx?DUID=<%# Eval("CID").ToString() %>' onclick="return confirm('Are you sure you want to deactivate this user?')">Deactivate</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
                 <EmptyDataTemplate>
                    <div align="center">No records found.</div>
                </EmptyDataTemplate>
        </asp:GridView>
    </div>

</asp:Content>
