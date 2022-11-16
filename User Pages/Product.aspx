<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Test2.Product" %>
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

    .product-box:hover {
        cursor: pointer;
        -webkit-box-shadow: 0px 0px 30px 0px #9d85be;
        -moz-box-shadow: 0px 0px 30px 0px #9D85BE;
        box-shadow: 0px 0px 30px 0px #9d85be;
    }
    .product-box > a{
        color: black;    
        text-decoration: none;
    }

</style> 

    <div class="container features">
        <div class="row form-group" >
            <h2 class="mx-auto">Sort By:</h2>
            <asp:DropDownList ID="ddlCategory" style="border-radius:0.25rem !important;" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"  AppendDataBoundItems="true" AutoPostBack="True" ValidationGroup="sorting-group" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="CategoryID">
               <Items>
                   <asp:ListItem Text="Select..." Value="Select" />
                   <asp:ListItem Text="All" Value="0" />
               </Items>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" SelectCommand="SELECT * FROM [tblCategory]"></asp:SqlDataSource>
        </div>
    </div>

    <div class="container features">
        <div class="row form-group mt2">
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                   <div class=" product-column col-lg-3 col-md-6 col-12 mb-4">
                       <div class="product-box">
                           <asp:HiddenField ID="HiddenID" runat="server" Value='<%# Eval("PID") %>' />
                            <a href="View Product.aspx?PID=<%# Eval("PID") %>">
                                <asp:Image ID="productImage" CssClass="img-thumbnail rounded mx-auto d-block" style="height:200px" runat="server" ImageUrl='<%# ImagePath(Eval("p_image").ToString())%>' />
                                <asp:Label ID="Label1" runat="server" CssClass="text-center" style="word-break: break-all;" Text='<%# Eval("p_name").ToString().Length > 50 ? Eval("p_name").ToString().Substring(0,50) + "..." : Eval("p_name").ToString() %>'></asp:Label>
                                <hr style="border: 1px dashed black;" />
                                 <h5 style="color:#EE4D2D;">RM<span style="font-size:30px;"><%# Convert.ToDouble(Eval("p_price")).ToString("#,##0.00") %></span></h5>                             
                            </a>
                        </div>
                   </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connStrDB %>" SelectCommand="SELECT * FROM [tblProduct]"></asp:SqlDataSource>
        </div>
    </div>


</asp:Content>
