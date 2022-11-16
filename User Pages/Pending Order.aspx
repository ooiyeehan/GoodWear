<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pending Order.aspx.cs" Inherits="Test2.User_Pages.Pending_Order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .product-box {
        -webkit-border-radius: 20px;
        -moz-border-radius: 20px;
        border-radius: 20px;
        border: 1px solid lightgrey;
        padding: 20px;
        display: flex;
        flex-direction: column;
        flex-wrap: wrap;
        height: 100%;
        justify-content: center;
        background-color: white;
    }
    .card-header {
        color: #fff;
        background-color: #9D85BE!important;
        border-color: #fff;
        /*border-top-left-radius: 0.25rem;
        border-top-right-radius: 0.25rem;*/
    }
    .card-body {
        -ms-flex: 1 1 auto;
        flex: 1 1 auto;
        min-height: 1px;
        padding: 1.25rem;
    }
    .error-message {
        color: red;
        font-weight: 600;
    }
</style>

    <div class="container">
        <div class="row mx-3 my-3">
            <div class="product-nav">
                <a href="Default.aspx">Home</a> 
                <span>></span> 
                <span style="color:#6c757d;">Pending Orders</span>
            </div>
        </div>
        <div class="cart-container">
            <div class="col-sm-8 offset-sm-2 text-center" id="EmptyOrder" runat="server" style="height: 300px; display:flex; flex-direction: column; align-items:center; justify-content:center;">
                <h2>You don't have any pending orders!</h2>
                <p><a href="Product" class="btn btn-primary">Shop now</a></p>
            </div>
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <div class="card-header">
                          Order Status: <%# Eval("status").ToString() %>
                            <h5 class="float-right">Ordered on:  <%#Eval("dtpaid", "{0:dd/M/yyyy}")%></h5>
                        </div>
                        <div class="card-body">
                            <div class="row d-flex flex-row align-items-center">
                                <div class="col-lg-3">
                                    <asp:Image ID="productImage"  style="width: 100%; max-height: 250px; object-fit: contain; height:unset;" runat="server" ImageUrl='<%# ImagePath(Eval("p_image").ToString()) %>' />
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
										<table style="width: 100%;">
											<tbody>
                                            <tr>
												<td width="50%"><strong>Product:</strong> </td>
												<td width="50%"><%# Eval("p_name").ToString() %></td>
											</tr>
											<tr>
												<td width="50%"><strong>Quantity:</strong> </td>
												<td width="50%"><%# Eval("quantity").ToString() %></td>
											</tr>
											<tr>
												<td width="50%"><strong>Total:</strong> </td>
												<td width="50%">RM <%# Eval("totalpaid").ToString()%></td>
											</tr>
											</tbody>
										</table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>
