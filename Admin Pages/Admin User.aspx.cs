using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2.Admin_Pages
{
    public partial class Admin_Home : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int DUID = Convert.ToInt32(Request.QueryString["DUID"]);
            if (!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("../User Pages/Login.aspx");
                }
                else
                {
                    GetData();
                }
                if (Request.QueryString["DUID"] != null)
                {
                    UpdateUserActiveStatus(DUID);
                }
            }

        }
        private void GetData()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM [tblCustomer]"))
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

        private void UpdateUserActiveStatus(int DUID)
        {
            //string query = String.Format("SELECT * FROM [tblCustomer] WHERE [CID] = {0}", DUID);
            try
            {
                string check = "SELECT * FROM [tblCustomer] WHERE [CID] = @cid";
                string query = "UPDATE [tblCustomer] SET [active] = @active WHERE [CID] = @cidUpdate";
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(check))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.Parameters.AddWithValue("@cid", DUID); 
                            cmd.Connection = con;
                            con.Open();
                            sda.SelectCommand = cmd;
                            using (DataTable dt = new DataTable())
                            {
                                sda.Fill(dt);
                                foreach (DataRow row in dt.Rows)
                                {
                                    string active = row["active"].ToString();
                                    if (active.Equals("0")) // 0 = not active, so Update to 1
                                    {
                                        SqlCommand cmdUpdate = new SqlCommand(query);
                                        cmdUpdate.Connection = con;
                                        cmdUpdate.Parameters.AddWithValue("@cidUpdate", DUID);
                                        cmdUpdate.Parameters.AddWithValue("@active", 1);
                                        cmdUpdate.ExecuteNonQuery();
                                        con.Close();
                                        Response.Redirect("Admin User.aspx");
                                    }
                                    else // 1 = active, so Update to 0
                                    {
                                        SqlCommand cmdUpdate = new SqlCommand(query);
                                        cmdUpdate.Connection = con;
                                        cmdUpdate.Parameters.AddWithValue("@cidUpdate", DUID);
                                        cmdUpdate.Parameters.AddWithValue("@active", 0);
                                        cmdUpdate.ExecuteNonQuery();
                                        con.Close();
                                        Response.Redirect("Admin User.aspx");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }

        protected string DisplayReactivate(int active)
        {
            if (active == 0)
            {
                return "display: block";
            }
            else
            {
                return "display: none";
            }
            
        }

        protected string DisplayDeactivate(int active)
        {
            if (active == 0)
            {
                return "display: none";
            }
            else
            {
                return "display: block";
            }

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
    }
}