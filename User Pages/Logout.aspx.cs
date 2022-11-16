using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Abandon();
            //Response.Write("<script>alert('Logout successfully!'); window.location = 'Default.aspx'; </script>");
            Response.Redirect("../User Pages/Default.aspx");
        }
    }
}