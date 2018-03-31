using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TiendaAlquiler.Model
{
    public class ReturnViewModel
    {
        public int AlquilerId { get; set; }
        public int DetailId { get; set; }
        public int MovieId { get; set; }
        public string MovieTitle { get; set; }
        public float Price { get; set; }
        public int Cantidad { get; set; }
        public float subTotal { get; set; }
        public int ClientId { get; set; }
        public string ClientName { get; set; }
        public DateTime DateReturn { get; set; }
        public int StatudId { get; set; }
        public string StatusName { get; set; }
        public bool Penality { get; set; }

        public float Mount { get; set; }
        public bool isDevuelta { get; set; }
    }
}


/*
 
 select a.RentalId, a.MovieId,a.price, a.quantity, a.subtotal, b.clientid,
     b.dateRetund, b.statusid
   from rentaldetail a
   join RentalMovie b on a.RentalId = b.id
   where b.statusid in (1,2,4,5)
 */