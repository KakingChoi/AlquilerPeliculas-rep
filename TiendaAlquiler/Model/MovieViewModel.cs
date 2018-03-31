using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TiendaAlquiler.Model
{
    public class MovieViewModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int Year { get; set; }
        public int? Stock { get; set; }
        public bool? Exhausted { get; set; }
        public bool? Status { get; set; }
    }
}