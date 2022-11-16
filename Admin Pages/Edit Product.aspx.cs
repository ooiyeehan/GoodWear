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
   
    public partial class Edit_Product : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int PID = Convert.ToInt32(Request.QueryString["PID"]);
                if (Session["CID"] == null)
                {
                    Response.Redirect("../User Pages/Login.aspx");
                }
                else if(Request.QueryString["PID"] == null)
                {
                    Response.Write("<script>alert('Product is not found!'); window.location = '../Admin Pages/Admin Product.aspx'; </script>");
                }
                GetData(PID);
            }
        }

        private void DeleteOldProductImage(int PID)
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
                                var oldImage = row["p_image"].ToString();
                                if (oldImage != "")
                                {
                                    File.Delete(Server.MapPath("~/Product Images/" + oldImage));
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            int PID = Convert.ToInt32(Request.QueryString["PID"]);

            string newImage = txtImage.FileName.ToString();
            if (newImage != "") //If there is new image, delete old image and add new image
            {
                string imageFileName = Guid.NewGuid() + newImage;
                //to move the uploaded file from fileupload control to Images folder
                txtImage.PostedFile.SaveAs(Server.MapPath("~/Product Images/") + imageFileName);
                try
                {
                    string query = String.Format("UPDATE [tblProduct] SET p_name=@p_name, " +
                        "p_description=@p_description, p_price=@p_price, p_stock=@p_stock, " +
                        "p_image=@p_image, CategoryID = @CategoryID WHERE [PID] = {0}", PID);
                    SqlConnection con = new SqlConnection(constr);
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@p_name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@p_description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@p_price", Convert.ToDouble(txtPrice.Text.Trim()));
                    cmd.Parameters.AddWithValue("@p_stock", Convert.ToInt32(txtStock.Text.Trim()));
                    cmd.Parameters.AddWithValue("@p_image", imageFileName);
                    cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue.Trim());                

                    con.Open();
                    DeleteOldProductImage(PID);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "editproductsuccess();", true);
                }
                catch (Exception ex)
                {
                    Response.Write("Something went wrong: " + ex.Message);
                }
            }
            else //If there is no new image, don't update image
            {
                try
                {
                    string query = String.Format("UPDATE [tblProduct] SET p_name=@p_name, " +
                        "p_description=@p_description, p_price=@p_price, p_stock=@p_stock, " +
                        "CategoryID = @CategoryID WHERE [PID] = {0}", PID);
                    SqlConnection con = new SqlConnection(constr);
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@p_name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@p_description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@p_price", Convert.ToDouble(txtPrice.Text.Trim()));
                    cmd.Parameters.AddWithValue("@p_stock", Convert.ToInt32(txtStock.Text.Trim()));
                    cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "editproductsuccess();", true);
                }
                catch (Exception ex)
                {
                    Response.Write("Something went wrong: " + ex.Message);
                }
            }

        }

        private void GetData(int PID)
        {
            string query = String.Format("SELECT * FROM [tblProduct] WHERE [PID] = {0}", PID);
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

                                    this.txtName.Text = p_name;
                                    this.txtStock.Text = p_stock;
                                    this.txtPrice.Text = p_price;
                                    this.ddlCategory.SelectedValue = p_category;
                                    this.txtDescription.Text = p_description;                                  
                                    this.productImage.ImageUrl = "~/Product Images/" + p_image;

                                }
                            }
                        }
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Admin Pages/Admin Product.aspx");
        }
    }
}