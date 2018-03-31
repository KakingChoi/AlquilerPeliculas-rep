using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TiendaAlquiler.Datos;

namespace TiendaAlquiler
{
    public partial class Login : System.Web.UI.Page
    {
        TiendaPeliculasEntities db = new TiendaPeliculasEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btEntrar_Click(object sender, EventArgs e)
        {
            var user = db.Usuarios.Where(a => a.UsarName == txtUserName.Text && a.Password == Password.Text).FirstOrDefault();
            if (user == null)
            {
                lblErrorlogin.Visible = true;
                lblErrorlogin.Text = "Usuario  o clave invalido o Usario no existe!";
            }
            else
            {
                Session["idUsuario"] = user.Id;
                Session["Name"] = user.Name;
                Response.Redirect("/Default.aspx");
            }
            

        }
        
      
    }
}