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
    public partial class Login : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert();", true);
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string originalPsw;
            string customerid;
            string active;

            if (email == "admin@mail.com" && password == "admin123")
            {
                this.Session["CID"] = "admin";
                Response.Write("<script>alert('You have logged in as admin!'); window.location = '../Admin Pages/Admin User.aspx'; </script>");
            }
            else
            {
                string query = "SELECT * FROM [tblCustomer] WHERE [email] = @email";
                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@email", email);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                cmd.ExecuteNonQuery();

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {

                        customerid = row["CID"].ToString();
                        originalPsw = row["password"].ToString();
                        active = row["active"].ToString();

                        if (!BC.Verify(password, originalPsw))
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "loginfailed();", true);
                        }
                        else if (active == "0")
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "loginblocked();", true);
                        }
                        else
                        {
                            //session created if login successful
                            this.Session["email"] = email;
                            this.Session["fname"] = row["fname"].ToString();
                            this.Session["lname"] = row["lname"].ToString();
                            this.Session["fullname"] = row["fname"].ToString() + "\n" + row["lname"].ToString();
                            this.Session["CID"] = customerid;
                            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "loginsuccess();", true);

                        }
                    }
                }
                else
                {
                    //Notification message if login is not successful
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "loginfailed();", true);

                }
            }

        }

    }
}