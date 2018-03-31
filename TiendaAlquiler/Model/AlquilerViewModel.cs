using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TiendaAlquiler.Model
{
    public class AlquilerViewModel
    {
        public int IdMovie { get; set; }
        public string Title { get; set; }
        public float Price { get; set; }
        public int Cantidad { get; set; }
        public float Total { get; set; }
    }
}