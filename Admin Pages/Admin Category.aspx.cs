using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Test2.Admin_Pages
{

    public partial class Admin_Category : System.Web.UI.Page
    {
        private readonly string constr = ConfigurationManager.ConnectionStrings["connStrDB"].ConnectionString;
        //protected GridView GridView1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["CID"] == null)
                {
                    Response.Redirect("../User Pages/Login.aspx");
                }

                GetData();
                
            }

        }
        private void GetData()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM [tblCategory]"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            ViewState["CurrentTable"] = dt;
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //NewEditIndex property is used to determine the index of the row being edited. 
            GridView1.EditIndex = e.NewEditIndex;
            GetData();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //Finding the controls from Gridview for the row which is going to update  
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int id = Convert.ToInt32(row.Cells[0].Text);
            string name = (row.Cells[1].FindControl("TextBox1") as TextBox).Text.Trim();

            string query = "UPDATE [tblCategory] SET name = @name WHERE CategoryID = @id";

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);

                //use sqlParameters to prevent sql injection!
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@name", name);

                cmd.ExecuteNonQuery();

            }
            GridView1.EditIndex = -1;
            GetData();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            GetData();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //Finding the controls from Gridview for the row which is going to delete 
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int id = Convert.ToInt32(row.Cells[0].Text);
            string query = "DELETE FROM [tblCategory] WHERE CategoryID = @id";
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();

            }
            GridView1.EditIndex = -1;
            GetData();


        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                // reference the Delete LinkButton
                LinkButton db = e.Row.Cells[2].FindControl("LinkButton4") as LinkButton;
                if (db != null)
                {
                    db.OnClientClick = "return confirm('Are you certain you want to delete this category?');";
                }
                else
                {
                    
                }


            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            if(name == "")
            {
                
            }
            else
            {
                string query = "INSERT INTO [tblCategory] VALUES (@name)";
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(query, con);

                    //use sqlParameters to prevent sql injection!
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.ExecuteNonQuery();
                    Response.Redirect("Admin Category.aspx");
                }
            }
        }
    }
}