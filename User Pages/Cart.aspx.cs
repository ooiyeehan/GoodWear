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
    public partial class Cart : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int CID = Convert.ToInt32(Session["CID"]);
            string DCID = Request.QueryString["DCID"];
            if (Session["CID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!Page.IsPostBack)
            {
                //Repeater1.DataSource = this.GetData(UID);
                //Repeater1.DataBind();
               
                GetData();
            }

            if (DCID != null)
            {
                DeleteCart(Convert.ToInt32(DCID));
            }

        }

        public void GetData()
        {
            int CID = Convert.ToInt32(Session["CID"]);
            string query = String.Format("SELECT C.*, P.p_name, P.p_image FROM [tblCart] C LEFT JOIN [tblProduct] P ON C.PID = P.PID WHERE C.CID = {0}", CID);
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
                            if(dt.Rows.Count == 0)
                            {
                                EmptyCart.Visible = true;
                                PaymentRow.Visible = false;
                            }
                            else
                            {
                                EmptyCart.Visible = false;
                                PaymentRow.Visible = true;
                                Repeater1.DataSource = dt;
                                Repeater1.DataBind();
                                GetPaymentData(CID);
                                GetUserData(CID);
                            }                    
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

        private void DeleteCart(int DCID)
        {
            try
            {
                string query = String.Format("DELETE FROM [tblCart] WHERE [CartID] = {0}", DCID);
                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("Cart.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }

        private void GetPaymentData(int CID)
        {
            string query = String.Format("SELECT SUM([c_quantity]) AS Total, SUM([c_totalprice]) AS TotalPrice" +
                " FROM [tblCart] WHERE [CID] = {0}", CID);

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
                            foreach (DataRow row in dt.Rows)
                            {
                                double totalPrice = Convert.ToDouble(row["TotalPrice"]);
                                lblTotalSumPrice.Text = totalPrice.ToString("#,##0.00");                                                            
                            }
                            
                        }
                    }
                }
            }
        }

        private void GetUserData(int CID)
        {
            string query = String.Format("SELECT * FROM [tblCustomer] WHERE CID = {0}", CID);

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
                            foreach (DataRow row in dt.Rows)
                            {
                                string fname = row["fname"].ToString();
                                string lname = row["lname"].ToString();
                                string fullname = fname + lname;
                                txtFullName.Text = fullname;
                                txtAddress.Text = row["address"].ToString();
                            }

                        }
                    }
                }
            }


        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (txtCardNumber.Text.Length != 16)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            Page.Validate("register-form-group");
            if (!Page.IsValid)
            {
                return;
            }
            int CID = Convert.ToInt32(Session["CID"]);
            string query = String.Format("SELECT * FROM [tblCart] WHERE CID = {0}", CID);
            string query2 = "INSERT INTO [tblOrder] VALUES (@status, @quantity, @dtpaid, @totalpaid, @PID, @CID)";

            try
            {
                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                con.Open();
                dataAdapter.SelectCommand = cmd;

                DataTable dt = new DataTable();
                dataAdapter.Fill(dt);

                int count = dt.Rows.Count;
                for (int i = 0; i < count; i++)
                {
                    int quantity = Convert.ToInt32(dt.Rows[i]["c_quantity"]);
                    int PID = Convert.ToInt32(dt.Rows[i]["PID"]);
                    cmd = new SqlCommand(query2, con);
                    cmd.Parameters.AddWithValue("@status", "Pending");
                    cmd.Parameters.AddWithValue("@quantity", quantity);
                    cmd.Parameters.AddWithValue("@dtpaid", DateTime.Today.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@totalpaid", Convert.ToDouble(dt.Rows[i]["c_totalprice"]));
                    cmd.Parameters.AddWithValue("@PID", PID);
                    cmd.Parameters.AddWithValue("@CID", CID);
                    cmd.ExecuteNonQuery();
                }
                CleanCart(CID);
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "paymentsuccess();", true);

            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }

        private void CleanCart(int CID)
        {
            string query = "DELETE FROM [tblCart] WHERE [CID] = @CID";
            try
            {
                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CID", CID);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Something went wrong: " + ex.Message);
            }
        }
    }
}