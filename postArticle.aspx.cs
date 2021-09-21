using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class postArticle : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string title = TextBox2.Text;
        if (title == "")
        {
            title = "無標題";
        }
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;


        SqlDataSource1.Insert();
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            string selectStatement = "SELECT id FROM title WHERE title= @title ORDER BY time DESC ";
            SqlCommand comm = new SqlCommand(selectStatement, connection);
            comm.Parameters.AddWithValue("title", title);
            comm.CommandType = System.Data.CommandType.Text;
            SqlDataReader reader = comm.ExecuteReader();
            reader.Read();
            articleID.Value = reader[0].ToString();

        }
        SqlDataSource2.Insert();
        Response.Redirect("read.aspx?id="+ articleID.Value);
    }
}