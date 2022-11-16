using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2.Admin_Pages
{
    public partial class Add_Product : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("../User Pages/Login.aspx");
                }
                else
                {

                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (!Page.IsValid)
            {
                return;
            }
            try
            {
                lblDateAdded.Text = DateTime.Today.ToString("yyyy-MM-dd");
                string file_name = txtImage.FileName.ToString();

                
                string filename = Guid.NewGuid() + file_name;
                //to move the uploaded file from fileupload control to Images folder
                txtImage.PostedFile.SaveAs(Server.MapPath("~/Product Images/") + filename);
                SqlConnection con = new SqlConnection(constr);
                con.Open();
                string query = "INSERT INTO [tblProduct] VALUES (@p_name, @p_description, @p_price, @p_stock, @p_dateAdded, @p_image, @CategoryID)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@p_name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@p_description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@p_price", Convert.ToDouble(txtPrice.Text.Trim()));
                cmd.Parameters.AddWithValue("@p_stock", Convert.ToInt32(txtStock.Text.Trim()));
                cmd.Parameters.AddWithValue("@p_dateAdded", lblDateAdded.Text);
                cmd.Parameters.AddWithValue("@p_image", filename);
                cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue.Trim());

                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "addproductsuccess();", true);
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.ToString());
            }
        }
    }
}