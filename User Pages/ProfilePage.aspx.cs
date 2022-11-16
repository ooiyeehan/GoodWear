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
    public partial class ProfilePage : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    string query = "SELECT * FROM [tblCustomer] WHERE [CID] = @CID";
                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query))
                        {
                            using (SqlDataAdapter sda = new SqlDataAdapter())
                            {
                                cmd.Parameters.AddWithValue("@CID", Session["CID"].ToString());
                                cmd.Connection = con;
                                sda.SelectCommand = cmd;
                                using (DataTable dt = new DataTable())
                                {
                                    sda.Fill(dt);
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        string address = row["address"].ToString();
                                        this.txtFName.Text = Session["fname"].ToString();
                                        this.txtLName.Text = Session["lname"].ToString();
                                        this.txtEmail.Text = Session["email"].ToString();
                                        this.txtAddress.Text = address;
                                    }
                                }
                            }
                        }
                    }
                }
            }



        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Page.Validate("btnEditGroup");
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "emailexist();", true);
                return;
            }

            try
            {
                int CID = Convert.ToInt32(Session["CID"]);
                SqlConnection conn = new SqlConnection(constr);
                conn.Open();
                string query = "UPDATE tblCustomer SET fname=@fname, lname=@lname, email=@email, address=@address WHERE CID =@cid";
                SqlCommand comm = new SqlCommand(query, conn);

                comm.Parameters.AddWithValue("@cid", Session["CID"].ToString());
                comm.Parameters.AddWithValue("@fname", txtFName.Text.Trim());
                comm.Parameters.AddWithValue("@lname", txtLName.Text.Trim());
                comm.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                comm.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
                comm.ExecuteNonQuery();

                Session["cid"] = CID.ToString();
                Session["fname"] = txtFName.Text.Trim();
                Session["lname"] = txtLName.Text.Trim();
                Session["email"] = txtEmail.Text.Trim();
                Session["fullname"] = txtFName.Text.Trim() + "\n" + txtLName.Text.Trim();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "updateprofilesuccess();", true);
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
                                                                                                                    
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int CID = Convert.ToInt32(Session["CID"]);
            using (SqlConnection con = new SqlConnection(constr))
            {

                using (SqlCommand cmd = new SqlCommand("SELECT email FROM [tblCustomer] WHERE CID != @CID"))
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
                                string email = row["email"].ToString().ToUpper();
                                string newemail = this.txtEmail.Text.Trim().ToUpper();
                                if (email.Equals(newemail))
                                {

                                    args.IsValid = false;
                                    break;
                                }
                                else
                                {
                                    args.IsValid = true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}