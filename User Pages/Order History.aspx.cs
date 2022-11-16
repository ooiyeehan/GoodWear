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
    public partial class Order_History : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int CID = Convert.ToInt32(Session["CID"]);
            if (Session["CID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!Page.IsPostBack)
            {
                GetData();
            }

        }
        public void GetData()
        {
            int CID = Convert.ToInt32(Session["CID"]);
            string query = String.Format("SELECT O.*, P.p_name, P.p_image FROM [tblOrder] O " +
                "LEFT JOIN [tblProduct] P ON O.PID = P.PID WHERE " +
                "(O.status = 'Delivered' OR O.status = 'Delivered and Feedback Given') AND O.CID={0}", CID);
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        dataAdapter.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            dataAdapter.Fill(dt);
                            if (dt.Rows.Count == 0)
                            {
                                EmptyOrder.Visible = true;
                            }
                            else
                            {
                                EmptyOrder.Visible = false;
                                Repeater1.DataSource = dt;
                                Repeater1.DataBind();
                            }
                        }
                    }
                }
            }
        }


        protected string ImagePath(string src)
        {
            string path = "~/images/";
            string product_path = "~/Product Images/";
            if (src == "")
            {
                return path + "goodwear-logo.png";
            }
            return product_path + src;
        }
        protected string DisplayFeedback(string status)
        {
            if (status == "Delivered and Feedback Given")
            {
                return "display: none";
            }
            else
            {
                return "display: block";
            }

        }

        protected string DisplayFeedbackGiven(string status)
        {
            if (status == "Delivered")
            {
                return "display: none";
            }
            else
            {
                return "display: block";
            }

        }
    }
}