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
    public partial class Register : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Register_Click(object sender, EventArgs e)
        {
            //using (SqlConnection con = new SqlConnection(constr))
            //{

            //    using (SqlCommand cmd = new SqlCommand("SELECT email FROM [tblCustomer]"))
            //    {
            //        using (SqlDataAdapter sda = new SqlDataAdapter())
            //        {
            //            cmd.Connection = con;
            //            sda.SelectCommand = cmd;
            //            using (DataTable dt = new DataTable())
            //            {
            //                sda.Fill(dt);
            //                foreach (DataRow row in dt.Rows)
            //                {
            //                    string email = row["email"].ToString().ToUpper();
            //                    string newemail = this.email.Text.Trim().ToUpper();
            //                    if (email.Equals(newemail))
            //                    {
            //                        //Response.Write("<script>swal({title: 'Invalid Email!', text: 'The email you entered has already been registered!', icon: 'warning', button: 'ok', }); return false;</script>");
            //                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "emailexist();", true);
            //                        //lblErrorEmailExist.Visible = true;
            //                        break;
            //                    }
            //                    else if(!email.Equals(newemail))
            //                    {
            //                        //lblErrorEmailExist.Visible = false;
            //                        string passwordHash = BC.HashPassword(password.Text.Trim());
            //                        password.Text = passwordHash.Trim();
            //                        dtRegistered.Text = DateTime.Now.ToString();
            //                        active.Text = "1";
            //                        SqlDataSource1.Insert();
            //                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "registersuccess();", true);
            //                        break;
            //                    }
            //                    else
            //                    {
            //                        Response.Write("Unexpected Error Occurred...");
            //                        Response.End();
            //                    }
            //                }
            //            }
            //        }
            //    }
            //}
            Page.Validate();
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "emailexist();", true);
                return;
            }
            else
            {
                string passwordHash = BC.HashPassword(password.Text.Trim());
                password.Text = passwordHash.Trim();
                dtRegistered.Text = DateTime.Now.ToString();
                active.Text = "1";
                SqlDataSource1.Insert();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "registersuccess();", true);
            }

        }

        protected void EmailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {

                using (SqlCommand cmd = new SqlCommand("SELECT email FROM [tblCustomer]"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            foreach (DataRow row in dt.Rows)
                            {
                                string email = row["email"].ToString().ToUpper();
                                string newemail = this.email.Text.Trim().ToUpper();
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