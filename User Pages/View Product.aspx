<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View Product.aspx.cs" Inherits="Test2.User_Pages.View_Product" %>
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
        height: 100%;
    }
     .product-box .title {
        text-decoration: none;
        color: #354172;
        font-size: 30px;
        /* font-weight: bold; */
    }
    .product-box .product-description {
        text-decoration: none;
        font-size: 22px;
    }
    a:hover {
        cursor: pointer;
        color: #9d85be;
        text-decoration:none;
    }
    a{
        color: black;    
        text-decoration: none;
    }
    .product-rating-review {
        display: flex;
        flex-direction: column;
        padding: 20px;
        margin: 0 auto;
        border-radius: 4px;
        margin-block-end: 2rem;
        margin-block-start: 1rem;
        box-shadow: 1px 2px 2px 1px rgba(0, 0, 0, 0.2);
        justify-content: space-between;
        background-color: white;
    }
    .product-rating-review h2 {
        padding: 20px;
        border-radius: 4px;
        background-color: #f3f3f3;
    }
</style> 
    
    <div class="container"> 
        
        <div class="row mx-3 my-3">
            <div class="product-nav">
                <a href="Product.aspx">Product</a> 
                <span>></span> 
                <a id="productCategory" runat="server" href="Product.aspx">Product</a>
                <span>></span> 
                <a id="productLink" runat="server" href="Product.aspx">Product</a>
            </div>
        </div>

        <div class="row">
            <div class ="col-lg-5">
                <asp:Image ID="productImage" CssClass="img-thumbnail rounded mx-auto d-block" runat="server" ImageUrl="~/images/goodwear-logo.png" />
            </div>
            <div class="col-lg-7">
                <div class="product-box">
                    <h3 class="title">
                        <asp:Label ID="lblName" runat="server" Text=""></asp:Label></h3>
                    <h5 style="color:#EE4D2D;">RM <asp:Label ID="lblPrice" style="font-size:30px;" runat="server" Text=""></asp:Label></h5>  
                    <p class="product-description">
                        <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label></p>
                    <div class="row d-flex flex-row align-items-center justify-content-between">	
						<div class="col-12 col-sm-3 text-center d-flex flex-row align-items-center justify-content-center justify-content-sm-start form-group">
							<button type="button" class="btn btn-danger btnMinus" disabled="disabled"><i class="fa fa-minus"></i></button>
					
							<%--<span class="quantity" style="font-weight: normal; font-size: 25px; width: 50px; display: inline-block;">--%>
                                <asp:Label ID="lblQuantity" style="font-weight: normal; font-size: 25px; width: 50px; display: inline-block;" runat="server" Text="1"></asp:Label>
                                <asp:HiddenField ID="hiddenQuantity" Value="0" runat="server" />
                                <%--</span>--%>
						
							<button type="button" class="btn btn-success btnPlus"><i class="fa fa-plus"></i></button>
							
						</div>	
						<div class="col-6 col-sm-4 form-group">
                            <asp:LinkButton ID="btnAddCart" CssClass="btn btn-outline-info btn-block addToCart" runat="server" OnClick="btnAddCart_Click"><i class="fa fa-shopping-cart"></i> Add to Cart</asp:LinkButton>
							<%--<button type="button" class="btn btn-outline-info btn-block addToCart" ><i class="fa fa-shopping-cart"></i> Add to Cart</button>--%>
						</div>
						<div class="col-6 col-sm-4 form-group">
							<a href="Cart.aspx" class="btn btn-outline-success btn-block"><i class="fa fa-shopping-cart"></i> Go to Cart</a>
						</div>
					</div>
                </div>
            </div>
        </div>

        <div class="row mx-3 my-3">
            <div class="product-rating-review">
                <h2>Product Ratings and Reviews</h2>
                <h3 id="EmptyRating" class="EmptyRating" style="text-align:center;" runat="server">There is no rating and review under this product currently</h3>
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <div class="form-group">
                            <h5>Name: <%# Eval("fname").ToString() %></h5>
                        </div>
                        <div class="form-group">
                            <h5>Date: <%#Eval("dtadded", "{0:dd/M/yyyy}")%></h5>
                        </div>
                        <div class="form-group">
                            <h5>Rating Given: <%# Eval("rating").ToString() %> / 5</h5>
                        </div>
                        <div class="form-group">
                            <h5>Comment: <%# Eval("comment").ToString() %></h5>
                        </div>
                        <hr />
                    </ItemTemplate>

                </asp:Repeater>
            </div>
        </div>
    </div>


<script type="text/javascript">

	$(document).on("click", ".btnPlus", function(){
        $(this).closest('.product-box').find('.btnMinus').attr('disabled', false);
        let quantity = $(this).closest('.product-box').find('#<%=lblQuantity.ClientID%>').text();
		quantity = parseInt(quantity);
		quantity += 1;

        $(this).closest('.product-box').find('#<%=lblQuantity.ClientID%>').text(quantity);
        $(this).closest('.product-box').find('#<%=hiddenQuantity.ClientID%>').val(quantity);
	});

	$(document).on("click", ".btnMinus", function(){

        let quantity = $(this).closest('.product-box').find('#<%=lblQuantity.ClientID%>').text();
		quantity = parseInt(quantity);
		quantity -= 1;
		
		//if(localStorage[`cartItems`]) //If item exist in localstorage
		//{
		//	const items = JSON.parse(localStorage.getItem(`cartItems`));
		//	const existIndex = items.findIndex(item => item.id == id);
		//	if(existIndex != '-1') //If item is found
		//	{
		//		if(quantity == 0)
		//		{
		//			if(confirm(`Do you want to remove this item?`))
		//			{
		//				items.splice(existIndex, 1);
		//			}
		//			else
		//			{
		//				quantity = 1;
		//			}
		//		}
		//		else
		//		{
		//			items[existIndex].quantity = quantity;
		//		}
					
		//		localStorage.setItem(`cartItems`, JSON.stringify(items))
		//		itemCount = items.length;
		//		$('.itemCount').html(itemCount);
		//	}
		//}

		if(quantity == 0)
		{
            $(this).closest('.product-box').find('.btnMinus').attr('disabled', true);
            $(this).closest('.product-box').find('.removeFromCart').replaceWith(`<button type="button" class="btn btn-outline-info btn-block addToCart" value="${id}"><i class="fa fa-shopping-cart"></i> Add to Cart</button>`);
		}
				
        $(this).closest('.product-box').find('#<%=lblQuantity.ClientID%>').text(quantity);
        $(this).closest('.product-box').find('#<%=hiddenQuantity.ClientID%>').val(quantity);
	})
</script>

</asp:Content>
