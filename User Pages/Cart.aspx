<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Test2.User_Pages.Cart" %>
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
                <span style="color:#6c757d;">Cart</span>
            </div>
        </div>
        <div class="cart-container">
            <div class="col-sm-8 offset-sm-2 text-center" id="EmptyCart" runat="server" style="height: 300px; display:flex; flex-direction: column; align-items:center; justify-content:center;">
                <h2>Your cart is empty!</h2>
                <p><a href="Product" class="btn btn-primary">Shop now</a></p>
            </div>
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <div class="card-header">
                          <%# Eval("p_name").ToString() %>
                            <a class="btn btn-danger btn-sm float-right btnRemove" href='Cart.aspx?DCID=<%# Eval("CartID").ToString() %>' onclick="return confirm('Are you sure you want to remove this item from cart?')"><i class="fa fa-times"></i></a>
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
												<td width="50%"><strong>Price (per unit):</strong> </td>
												<td width="50%">RM <%# Eval("c_unitprice").ToString() %></td>
											</tr>
											<tr>
												<td width="50%"><strong>Quantity:</strong> </td>
												<td width="50%"><%# Eval("c_quantity").ToString() %></td>
											</tr>
											<tr>
												<td width="50%"><strong>Total:</strong> </td>
												<td width="50%">RM <%# Eval("c_totalprice").ToString()%></td>
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

            <div class="row mt-3" id="PaymentRow" runat="server">
                <div class="col-sm-8 form-group">
                    <div class="product-box" style="background-color: #F0F0F0;">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
                            <asp:TextBox ID="txtFullName" runat="server" Placeholder="Enter First Name" CssClass="form-control" ReadOnly="true" ValidationGroup="register-form-group"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" Text="Card Number"></asp:Label>
                            <asp:CustomValidator ID="CustomValidator1" ValidateEmptyText="true" runat="server" ControlToValidate="txtCardNumber" OnServerValidate="CustomValidator1_ServerValidate" CssClass="error-message" ErrorMessage="* Must be 16 numbers!" ValidationGroup="register-form-group"></asp:CustomValidator>
                            <asp:TextBox ID="txtCardNumber" runat="server" TextMode="Number" Placeholder="Enter Payment Card Number" CssClass="form-control" ValidationGroup="register-form-group"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" Text="Delivery Address"></asp:Label>
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Placeholder="Delivery Address" CssClass="form-control" ReadOnly="true" ValidationGroup="register-form-group"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 form-group">
                    <div class="product-box" style="align-items:center;justify-content:center;background-color: #F0F0F0;">
                        <div class="form-group">
                            <h4>
                                <strong>Total: </strong>
                                <strong>RM</strong>
                                <strong><asp:Label ID="lblTotalSumPrice" runat="server" Text=""></asp:Label></strong>
                            </h4>
                        </div>    
                        <div class="d-flex flex-column w-100 mt-3">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Select your Bank"></asp:Label>
                                <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                    <asp:ListItem>AGRONet </asp:ListItem>
                                    <asp:ListItem>Alliance Bank (Personal)</asp:ListItem>
                                    <asp:ListItem>AmBank</asp:ListItem>
                                    <asp:ListItem>Bank Islam</asp:ListItem>
                                    <asp:ListItem>Bank Muamalat</asp:ListItem>
                                    <asp:ListItem>Bank Rakyat</asp:ListItem>
                                    <asp:ListItem>BSN</asp:ListItem>
                                    <asp:ListItem>CIMB Clicks</asp:ListItem>
                                    <asp:ListItem>Hong Leong Bank</asp:ListItem>
                                    <asp:ListItem>HSBC Bank</asp:ListItem>
                                    <asp:ListItem>Maybank2E </asp:ListItem>
                                    <asp:ListItem>Maybank2U </asp:ListItem>
                                    <asp:ListItem>OCBC Bank</asp:ListItem>
                                    <asp:ListItem>Public Bank </asp:ListItem>
                                    <asp:ListItem>RHB Bank</asp:ListItem>
                                    <asp:ListItem>Standard Chartered </asp:ListItem>
                                    <asp:ListItem>UOB Bank </asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnCheckOut" CssClass="btn btn-info" runat="server" Text="Check Out" OnClick="btnCheckOut_Click"  ValidationGroup="register-form-group" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
