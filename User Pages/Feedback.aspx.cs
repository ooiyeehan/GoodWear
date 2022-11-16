using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2.User_Pages
{
    public partial class Feedback : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int CID = Convert.ToInt32(Session["CID"]);
            string OID = Request.QueryString["OID"];
            string PID = Request.QueryString["PID"];
            if (Session["CID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!Page.IsPostBack)
            {
                if (OID == null | PID == null)
                {
                    Response.Redirect("Order History.aspx");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (!Page.IsValid)
            {
                return;
            }
            int CID = Convert.ToInt32(Session["CID"]);
            int OID = Convert.ToInt32(Request.QueryString["OID"]);
            int PID = Convert.ToInt32(Request.QueryString["PID"]);
            string query = "INSERT INTO [tblFeedback] VALUES (@rating, @comment, @dtadded, @PID, @CID)";

            try
            {
                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@rating", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@comment", txtComment.Text);
                cmd.Parameters.AddWithValue("@dtadded", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@PID", PID);
                cmd.Parameters.AddWithValue("@CID", CID);
                con.Open();
                cmd.ExecuteNonQuery();
                UpdateOrder(OID);
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "addratingsuccess();", true);
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.ToString());
            }
        }
        private void UpdateOrder(int OID)
        {
            string query = "UPDATE [tblOrder] SET [status] = @status WHERE [OID] = @OID";
            try
            {
                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@status", "Delivered and Feedback Given");
                cmd.Parameters.AddWithValue("@OID", OID);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Order History.aspx");
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if(DropDownList1.SelectedValue == "0")
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
    }


}