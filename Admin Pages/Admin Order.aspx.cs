using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2.Admin_Pages
{
    public partial class Admin_Order : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string OID = Request.QueryString["OID"];
            string updatestatus = Request.QueryString["updateStatus"];
            if (!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("../User Pages/Login.aspx");
                }

                GetData();

                if(OID != null)
                {
                    UpdateStatus(Convert.ToInt32(OID), updatestatus);
                }
            }
        }

        private void GetData()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = "SELECT O.*, C.fname + SPACE(1) + C.lname AS fname, C.address, P.p_name FROM [tblOrder] O" +
                    " LEFT JOIN [tblCustomer] C ON O.CID = C.CID" +
                    " LEFT JOIN [tblProduct] P ON O.PID = P.PID";
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }

        private void UpdateStatus(int OID, string updatestatus)
        {
            try
            {
                
                string query = "UPDATE [tblOrder] SET [status] = @status WHERE [OID] = @OID";
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(query))
                    {
                        cmd.Connection = con;
                        con.Open();
                        cmd.Parameters.AddWithValue("@OID", OID);
                        cmd.Parameters.AddWithValue("@status", updatestatus);
                        cmd.ExecuteNonQuery();
                        con.Close();
                        Response.Redirect("Admin Order.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }

        protected string DisplaySentOutForDelivery(string status)
        {
            if (status == "Sent out for Delivery" || status == "Delivered" || status == "Delivered and Feedback Given")
            {
                return "display: none";
            }
            else
            {
                return "display: block";
            }

        }

        protected string DisplayDelivered(string status)
        {
            if (status == "Delivered" || status == "Pending" || status == "Delivered and Feedback Given")
            {
                return "display: none";
            }
            else
            {
                return "display: block";
            }

        }

        protected string DisplayOrderHasBeenDelivered(string status)
        {
            if (status == "Delivered" || status == "Delivered and Feedback Given")
            {
                return "display: block";
            }
            else
            {
                return "display: none";
            }

        }
    }
}