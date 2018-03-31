using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using TiendaAlquiler.Datos;
using Newtonsoft.Json;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using TiendaAlquiler.Model;

namespace TiendaAlquiler.Mantenimientos
{
    public partial class CategoryForm : System.Web.UI.Page
    {
        TiendaPeliculasEntities db = new TiendaPeliculasEntities();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session.Count == 0)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        
    }
}