using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2
{
    public partial class Product : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
          
            GetData();

        }

        protected string ImagePath(string src)
        {
            string path = "~/Product Images/";
            if (src == "")
            {
                return path + "Deal&Bill.png";
            }
            return path + src;
        }

       /* public void GetData()
        {
            string query = "SELECT * FROM [tblProduct]";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        dataAdapter.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            dataAdapter.Fill(ds);
                            Repeater1.DataSource = ds;
                            Repeater1.DataBind();
                        }
                    }
                }
            }
        } */

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string getSortValue = ddlCategory.SelectedValue;
            Response.Redirect("Product.aspx?sortBy=" + getSortValue);
        }

        private string SortByCategory(string keyword)
        {
            string query = String.Format("SELECT * FROM [tblProduct] WHERE CategoryID = {0}", keyword);
            return query;
        }
        public void DisplayData(string query)
        {
            string sortCategory = Request.QueryString["sortBy"];
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        dataAdapter.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            dataAdapter.Fill(ds);
                            Repeater1.DataSource = ds;
                            Repeater1.DataBind();
                            
                        }
                    }
                }
            }
        }

        private void GetData()
        {
            string sortCategory = Request.QueryString["sortBy"];
            string query;
            if (sortCategory == "0" || sortCategory == null)
            {
                query = "SELECT * FROM [tblProduct]";
            }
            else
            {
                query = SortByCategory(sortCategory);
            }
            DisplayData(query);

        }


    }
}