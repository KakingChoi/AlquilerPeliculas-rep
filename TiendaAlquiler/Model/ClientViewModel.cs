using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TiendaAlquiler.Model
{
    [Serializable]
    public class ClientViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
        public string Adress { get; set; }
    }
}