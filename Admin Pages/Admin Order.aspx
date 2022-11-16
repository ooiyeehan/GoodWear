<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin Order.aspx.cs" Inherits="Test2.Admin_Pages.Admin_Order" %>
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
    .btn-success{
        color: #fff !important;
    }

</style>

    <div class="container features">
          <h1 class="text-center">Manage Orders</h1>           
          <asp:GridView ID="GridView1" CssClass="GridStyle table table-bordered table-condensed table-responsive table-hover text-center" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" AllowPaging="True">
                 <Columns>
                     <asp:BoundField DataField="OID" HeaderText="OID" />
                     <asp:BoundField DataField="fname" HeaderText="Customer Name" />
                     <asp:BoundField DataField="address" HeaderText="Deliver Address" />
                     <asp:BoundField DataField="p_name" HeaderText="Product Name" />
                     <asp:BoundField DataField="quantity" HeaderText="Quantity" />
                     <asp:BoundField DataField="dtpaid" HeaderText="Date of Payment" />
                     <asp:TemplateField HeaderText="Total Paid">
                        <ItemTemplate>
                              RM <%# Convert.ToDouble(Eval("totalpaid")).ToString("#,##0.00") %> 
                        </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Order Status">
                         <ItemTemplate>
                             <strong><%# Eval("status").ToString() %> </strong>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <a class="btn btn-primary" href='Admin Order.aspx?OID=<%# Eval("OID").ToString() %>&updateStatus=Sent out for Delivery' "
                                style='<%# DisplaySentOutForDelivery(Eval("status").ToString()) %>' onclick="return confirm('Are you certain that you want to set this order as Sent out for Delivery?')">Set as 'Sent out for Delivery'</a>
                            <a class="btn btn-primary" href='Admin Order.aspx?OID=<%# Eval("OID").ToString() %>&updateStatus=Delivered' "
                                style='<%# DisplayDelivered(Eval("status").ToString()) %>' onclick="return confirm('Are you certain that you want to set this order as Delivered?')">Set as 'Delivered'</a>
                            <a class="btn btn-success" style='<%# DisplayOrderHasBeenDelivered(Eval("status").ToString()) %>' aria-disabled="true">Order has been delivered</a>
                        </ItemTemplate>
                     </asp:TemplateField>
                 </Columns>
                 <EmptyDataTemplate>
                    <div align="center">No records found.</div>
                </EmptyDataTemplate>
        </asp:GridView>
    </div>

</asp:Content>
