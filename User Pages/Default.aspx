<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Test2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    @media (max-width: 575.98px) {
        .mobileHeader{
            height: 360px !important;
        }
    }
</style>
    <header class="mobileHeader page-header header container-fluid"> 
        <div class="overlay">
            <div class="description">
                <h1>Welcome to GOODWEAR!</h1>
       
                <p>Quality Wearing Online Sales at <strong style="color: #FF8C00;"> Affordable Prices!</strong> </p>
            
            </div>
                
        </div>


    </header>

    <div class="container features">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
                <h3 class="feature-title">Shopping with us!</h3>
                <img src="../images/Shopping.jpg" class="img-fluid">
                <p>"Whoever said that money can't buy happiness simply didn't know where to go shopping."
                    Enjoy your shopping online on GOODWEARS with quality brands and prices now!
                </p>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12">
                <h3 class="feature-title">Shop Safely!</h3>
                <img src="../images/online-shopping.png" class="img-fluid">
                <p>You don't have to stop your shopping fever due to COVID-19 anymore! GOODWEAR offers
                   you a sweet and safe platform that you can shop anywhere and anytime you like! 
                </p>
            </div>

        </div>



    </div>

</asp:Content>
