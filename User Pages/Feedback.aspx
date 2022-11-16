<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Test2.User_Pages.Feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .myform {
        position: relative;
        display: -ms-flexbox;
        display: flex;
        padding: 1rem;
        /* align-items: center; */
        -ms-flex-direction: column;
        flex-direction: column;
        /* width: 100%; */
        pointer-events: auto;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #9D85BE;
        border-radius: 1.1rem;
        outline: 0;
        /* max-width: 500px; */
    }
    .login-or {
        position: relative;
        color: #aaa;
        margin-top: 10px;
        margin-bottom: 10px;
        padding-top: 10px;
        padding-bottom: 10px;
    }
    .hr-or {
        height: 1px;
        margin-top: 0px !important;
        margin-bottom: 0px !important;
    }
    .span-or {
        display: block;
        position: absolute;
        left: 50%;
        top: -2px;
        margin-left: -25px;
        background-color: #fff;
        width: 50px;
        text-align: center;
    }
    .font-family-1 {
        font-family: 'Kaushan Script', cursive;
        color: blue;
    }
    .error-message {
        color: red;
        font-weight: 600;
    }
</style>

    <header class="container-fluid" style="margin-top:15px; margin-bottom:15px;">
        <div class="container">
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="myform form ">
                        <div class="col-md-12 mb-3 text-center">
                          <h1 class="font-family-1">We value your feedback</h1>
                          <p>How was your experience ordering from us? We would like to know more!</p>  
                        </div> 
                        
                            <div class="form-group">
                                <asp:Label ID="Label1" runat="server" Text="How would you rate our service?"></asp:Label>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" ControlToValidate="DropDownList1" OnServerValidate="CustomValidator1_ServerValidate" ErrorMessage="* Please choose a rating" CssClass="error-message" ValidationGroup="feedback-form-group" />                                
                                <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="0">Select...</asp:ListItem>
                                    <asp:ListItem Value="1">1 - Very Poor</asp:ListItem>
                                    <asp:ListItem Value="2">2 - Poor</asp:ListItem>
                                    <asp:ListItem Value="3">3 - Average</asp:ListItem>
                                    <asp:ListItem Value="4">4 - Good</asp:ListItem>
                                    <asp:ListItem Value="5">5 - Awesome</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                                <asp:Label ID="Label8" runat="server" Text="Insert your comment here" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtComment" ErrorMessage="* Comment is required" CssClass="error-message" ValidationGroup="feedback-form-group" />
                                <asp:TextBox ID="txtComment" CssClass="form-control" runat="server" TextMode="MultiLine" Placeholder="Insert comment" MaxLength="500" ValidationGroup="btnEditGroup"></asp:TextBox> <br />
                            <div class="col-md-6 mx-auto ">
                                <asp:Button ID="btnSubmit" style="font-weight: bold;" CssClass="btn btn-block mybtn btn-primary tx-tfm" runat="server" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="feedback-form-group" /><br />
                                <asp:Button ID="btnCancel" style="font-weight: bold;" CssClass="btn btn-block mybtn btn-primary tx-tfm" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                            </div>
                        <asp:Label ID="dtRegistered" runat="server" Text="Label" Visible="false"></asp:Label>
                        <asp:Label ID="active" runat="server" Text="Label" Visible="false"></asp:Label>
                    </div>
                </div>
              </div>
          </div>
    </header>

</asp:Content>
