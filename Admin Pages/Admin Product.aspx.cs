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
    public partial class Admin_Product : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int PID = Convert.ToInt32(Request.QueryString["PID"]);
            if (!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("../User Pages/Login.aspx");
                }
                if (Request.QueryString["PID"] != null)
                {
                    DeleteProduct(PID);
                }
                GetData();
                
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("Add Product.aspx");
        }
        private void GetData()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM [tblProduct]"))
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

        private void DeleteProduct(int PID)
        {
            try
            {
                DeleteProductImage(PID);
                string query = "DELETE FROM [tblProduct] WHERE PID = @PID";
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@PID", PID);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "deleteproductsuccess();", true);
                }


            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }

        private void DeleteProductImage(int PID)
        {
            string query = String.Format("SELECT [p_image] FROM [tblProduct] WHERE [PID] = {0}", PID);

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter())
                    {
                        dataAdapter.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            dataAdapter.Fill(dt);
                            foreach (DataRow row in dt.Rows)
                            {
                                var image = row["p_image"].ToString();
                                if (image != "")
                                {
                                    File.Delete(Server.MapPath("~/Product Images/" + image));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}