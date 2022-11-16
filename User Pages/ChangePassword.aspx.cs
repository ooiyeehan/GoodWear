using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using BC = BCrypt.Net.BCrypt;

namespace Test2
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void ChangePassword_Click(object sender, EventArgs e)
        {
            int CID = Convert.ToInt32(Session["CID"]);
            string query = "SELECT [password] FROM [tblCustomer] WHERE [CID] = @CID";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@CID", CID);
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            foreach (DataRow row in dt.Rows)
                            {
                                string password = row["password"].ToString();
                                if (!BC.Verify(this.txtOldPassword.Text, password)) //if password does not match db, show error
                                {
                                    //args.IsValid = false; 
                                    lblErrorOldPassword.Visible = true;
                                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "wrongoldpassword();", true);
                                }
                                else // if password matches, update password
                                {
                                    lblErrorOldPassword.Visible = false;
                                    string newHashPassword = BC.HashPassword(txtNewPassword.Text);
                                    SqlConnection conn = new SqlConnection(constr);
                                    conn.Open();
                                    string updatequery = "UPDATE [tblCustomer] SET [password] = @password WHERE [CID] = @CID";
                                    SqlCommand comm = new SqlCommand(updatequery, conn);
                                    comm.Parameters.AddWithValue("@cid", Session["CID"].ToString());
                                    comm.Parameters.AddWithValue("@password", newHashPassword);

                                    int result = comm.ExecuteNonQuery();

                                    if (result > 0)
                                    {
                                        Session.Abandon();
                                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "updatepasswordsuccess();", true);
                                    }
                                    else
                                    {
                                        Response.Write("Unexpected Error has Occurred...");
                                        Response.End();
                                    }

                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}