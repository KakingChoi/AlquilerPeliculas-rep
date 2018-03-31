using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TiendaAlquiler
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session.Count == 0)
            {
                linkLogueo.Text = "Iniciar Sesión";
                lblUser.Visible = false;
            }
            else
            {
                linkLogueo.Text = "Cerrar Sesión";
                lblUser.Visible = true;
                lblUser.Text = "Bienvenido " + Session["Name"].ToString();
            }
        }

        protected void linkLogueo_Click(object sender, EventArgs e)
        {
            if (Session.Count == 0)
            {
                Response.Redirect("/Login.aspx");
            }
            else
            {
                Session.Abandon();
                Session.RemoveAll();
                Response.Redirect("/Login.aspx");
            }
        }
    }
}