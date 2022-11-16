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
    public partial class View_Product : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int PID = Convert.ToInt32(Request.QueryString["PID"]);
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["PID"] == null)
                {
                    Response.Write("<script>alert('Product is not found!'); window.location = 'Product.aspx'; </script>");
                }
                GetData(PID);
                Repeater1.DataSource = this.GetRatingData(PID);
                Repeater1.DataBind();

            }
        }

        private void GetData(int PID)
        {
            string query = String.Format("SELECT P.*, C.name FROM [tblProduct] P LEFT JOIN [tblCategory] C ON P.CategoryID = C.CategoryID WHERE P.[PID] = {0}", PID);
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
                            if (dt.Rows.Count > 0)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    string p_name = row["p_name"].ToString();
                                    string p_stock = row["p_stock"].ToString();
                                    string p_price = Convert.ToDouble(row["p_price"]).ToString("#,##0.00");
                                    string p_category = row["CategoryID"].ToString();
                                    string p_description = row["p_description"].ToString();
                                    string p_image = row["p_image"].ToString();
                                    string c_name = row["name"].ToString();

                                    productLink.HRef = "View Product?PID=" + row["PID"].ToString();
                                    productLink.InnerText = p_name;
                                    productCategory.HRef = "Product?sortBy=" + row["CategoryID"].ToString();
                                    productCategory.InnerText = c_name;

                                    this.lblName.Text = p_name;
                                   //this.lblStock.Text = p_stock;
                                   this.lblPrice.Text = p_price;
                                   this.lblDescription.Text = p_description;
                                   this.productImage.ImageUrl = "~/Product Images/" + p_image;

                                }
                            }
                        }
                    }
                }
            }
        }

        private DataTable GetRatingData(int PID)
        {
            string query = "SELECT F.*, C.fname + SPACE(1) + C.lname AS fname FROM [tblFeedback] F " +
                "LEFT JOIN [tblCustomer] C ON F.CID = C.CID WHERE F.PID = @PID";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@PID", PID);
                        cmd.Connection = con;
                        dataAdapter.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            dataAdapter.Fill(dt);
                            int count = dt.Rows.Count;
                            if (count > 0)
                            {                            
                                EmptyRating.Visible = false;
                            }
                            return dt;
                        }
                    }
                }
            }
        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            if (Session["CID"] == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "loginrequired();", true);
            }
            else
            {

                try
                {
                    string query = "INSERT INTO [tblCart] VALUES (@c_quantity, @c_unitprice, @c_totalprice, @PID, @CID)";
                    int PID = Convert.ToInt32(Request.QueryString["PID"]);
                    int CID = Convert.ToInt32(Session["CID"]);
                    int quantity = Convert.ToInt32(hiddenQuantity.Value);
                    double price = Convert.ToDouble(lblPrice.Text);
                    double totalPrice = quantity * price;

                    SqlConnection con = new SqlConnection(constr);
                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@c_quantity", quantity);
                    cmd.Parameters.AddWithValue("@c_unitprice", price);
                    cmd.Parameters.AddWithValue("@c_totalprice", totalPrice);
                    cmd.Parameters.AddWithValue("@PID", Convert.ToInt32(PID));
                    cmd.Parameters.AddWithValue("@CID", CID);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "addtocartsuccess();", true);

                }
                catch (Exception ex)
                {
                    Response.Write("Something went wrong: " + ex.Message);
                }
            }
        }
    }
}