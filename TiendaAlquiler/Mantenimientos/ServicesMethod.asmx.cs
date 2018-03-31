using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using TiendaAlquiler.Datos;
using System.Web.Script.Services;
using Newtonsoft.Json;
using TiendaAlquiler.Model;

namespace TiendaAlquiler.Mantenimientos
{
    /// <summary>
    /// Summary description for ServicesMethod
    /// </summary>
    [WebService]//(Namespace = "http://tempuri.org/")
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ServicesMethod : System.Web.Services.WebService
    {
        private TiendaPeliculasEntities db = new TiendaPeliculasEntities();
        //Funciones category
        #region
        //Categorias funciones
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getCategories()
        {
            List<CategoryViewModel> lista = db.Categories.Select(a => new CategoryViewModel
            {
                Id = a.Id,
                Name = a.Name
            }).ToList();

            return JsonConvert.SerializeObject(lista); //db.Categories.ToList();

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getCategoryById(int Id)
        {
            CategoryViewModel model = db.Categories.Where(a => a.Id == Id).Select(a => new CategoryViewModel
            {
                Id = a.Id,
                Name = a.Name
            }).FirstOrDefault();
            return JsonConvert.SerializeObject(model);

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string AddCategory(string Name)
        {
            db.AddToCategories(new Category { Name = Name });
            if (db.SaveChanges() > 0)
            {
                return "Insertado";
            }
            else
            {
                return "Error al insertar";
            }

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string EditCategory(int Id, string Name)
        {
            Category c = db.Categories.FirstOrDefault(a => a.Id == Id);
            c.Name = Name;
            if (db.SaveChanges() > 0)
            {
                return "Actualizado";
            }
            else
            {
                return "Error al actualizar";
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string DeleteCategory(int Id)
        {
            db.DeleteObject(db.Categories.FirstOrDefault(a => a.Id == Id));
            if (db.SaveChanges() > 0)
            {
                return "Eliminado";
            }
            else
            {
                return "Error no se pudo eliminar";
            }

        }
        #endregion

        //Funciones Client
        #region

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getClients()
        {
            List<ClientViewModel> lista = db.Clients.Select(a => new ClientViewModel
            {
                Id = a.Id,
                Name = a.Name,
                Phone = a.Phone,
                Adress = a.Adress

            }).ToList();

            return JsonConvert.SerializeObject(lista); //db.Categories.ToList();

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getClientById(int Id)
        {
            ClientViewModel model = db.Clients.Where(a => a.Id == Id).Select(a => new ClientViewModel
            {
                Id = a.Id,
                Name = a.Name,
                Phone = a.Phone,
                Adress = a.Adress
            }).FirstOrDefault();
            return JsonConvert.SerializeObject(model);

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string AddClient(string client)
        {
            try
            {
                ClientViewModel c = JsonConvert.DeserializeObject<ClientViewModel>(client);
                db.AddToClients(new Client { Name = c.Name, Phone = c.Phone, Adress = c.Adress });
                if (db.SaveChanges() > 0)
                {
                    return "Insertado";
                }
                else
                {
                    return "Error al insertar";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }


        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string EditClient(string client)
        {
            try
            {
                ClientViewModel cm = JsonConvert.DeserializeObject<ClientViewModel>(client);
                Client c = db.Clients.FirstOrDefault(a => a.Id == cm.Id);
                c.Name = cm.Name;
                c.Phone = cm.Phone;
                c.Adress = cm.Adress;
                if (db.SaveChanges() > 0)
                {
                    return "Actualizado";
                }
                else
                {
                    return "Error al actualizar";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string DeleteClient(int Id)
        {
            db.DeleteObject(db.Clients.FirstOrDefault(a => a.Id == Id));
            if (db.SaveChanges() > 0)
            {
                return "Eliminado";
            }
            else
            {
                return "Error no se pudo eliminar";
            }

        }
        #endregion

        //Funciones Movie
        #region

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getMovies()
        {
            List<MovieViewModel> lista = db.Movies.Select(a => new MovieViewModel
            {
                Id = a.Id,
                Title = a.Title,
                Description = a.Description,
                CategoryId = a.Category.Id,
                Year = a.Year,
                Stock = a.Stock,
                Exhausted = a.Exhausted,
                Status = a.Status

            }).ToList();

            return JsonConvert.SerializeObject(lista); //db.Categories.ToList();

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getMoviesFilter(int year , string title, int category)
        {
            List<MovieViewModel> lista = db.Movies.Select(a => new MovieViewModel
            {
                Id = a.Id,
                Title = a.Title,
                Description = a.Description,
                CategoryId = a.Category.Id,
                CategoryName = a.Category.Name,
                Year = a.Year,
                Stock = a.Stock,
                Exhausted = a.Exhausted,
                Status = a.Status

            }).ToList();
            if (!string.IsNullOrEmpty(title))
            {
              lista =   lista.Where(a => a.Title.Contains(title)).ToList();
            }
            if (year > 0)
            {
               lista =  lista.Where(a => a.Year == year).ToList();
            }
            if (category > 0)
            {
               lista =  lista.Where(a => a.CategoryId == category).ToList();
            }
            

            return JsonConvert.SerializeObject(lista); //db.Categories.ToList();

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getMovieById(int Id)
        {
            MovieViewModel model = db.Movies.Where(a => a.Id == Id).Select(a => new MovieViewModel
            {
                Id = a.Id,
                Title = a.Title,
                Description = a.Description,
                CategoryId = a.Category.Id,
                Year = a.Year,
                Stock = a.Stock,
                Exhausted = a.Exhausted,
                Status = a.Status
            }).FirstOrDefault();
            return JsonConvert.SerializeObject(model);

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getAlquiler(int IdMovie)
        {
            ParametersRental param = db.ParametersRentals.Where(a => a.Id == 1).First();
            Movie _movie = db.Movies.Where(a => a.Id == IdMovie).First();


            AlquilerViewModel model = new AlquilerViewModel();
            model.IdMovie = IdMovie;
            model.Title = _movie.Title;
            model.Cantidad = 1;
            model.Price = _movie.Exhausted.Value ? (float)param.CostRentalExhausted.Value : (float)param.CostRental.Value;
            model.Total = model.Cantidad *  model.Price;
            return JsonConvert.SerializeObject(model);

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string getReturn()
        {
            var query = (from a in db.RentalMovies
                             where a.DateRetund < DateTime.Now
                             && a.StatusRental.Id != 3
                             select a);

            if (query.Count() > 0)
            {
                foreach (var i in query)
                {
                    i.StatusRental = db.StatusRentals.Where(a => a.Id == 4).First();
                    
                }
                db.SaveChanges();
            }

            List<ReturnViewModel> model  = db.RentalDetails.Select(a => new ReturnViewModel
            {
                MovieId = a.Movie.Id,
                DetailId = a.Id,
                MovieTitle = a.Movie.Title,
                AlquilerId = a.RentalMovie.Id,
                Price = (float)a.Price.Value,
                Cantidad = a.Quantity.Value,
                subTotal = (float)a.SubTotal.Value,
                ClientId = a.RentalMovie.Client.Id,
                ClientName = a.RentalMovie.Client.Name,
                DateReturn = a.RentalMovie.DateRetund.Value,
                StatudId = a.RentalMovie.StatusRental.Id,
                StatusName = a.RentalMovie.StatusRental.Description,
                Penality = a.RentalMovie.StatusRental.Id == 4 ,
                Mount = a.RentalMovie.StatusRental.Id == 4 ? (float)(a.SubTotal.Value * .05) : 0,
                 isDevuelta = a.isDevuelta.Value
            }).Where(a => a.StatudId == 1 || a.StatudId == 2 || a.StatudId == 4 || a.StatudId == 5).ToList();

            return JsonConvert.SerializeObject(model);

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string DevolverPelicula(int MovieId, int ClientId, int Cantidad, int RentalDetailId, string Penality, float Mount, int AlquilerId ) 
        {
            try
            {
                bool _penality = Penality == "Si" ? true : false;
                RentalDetail rd = db.RentalDetails.FirstOrDefault(a => a.Id == RentalDetailId);
                RentalMovie r = db.RentalMovies.FirstOrDefault(a => a.Id == AlquilerId);
                ReturnMovie rm = new ReturnMovie
                {
                    Movie = db.Movies.FirstOrDefault(a => a.Id == MovieId),
                    Client = db.Clients.FirstOrDefault(a => a.Id == ClientId),
                    Quantity = Cantidad,
                    DateReturn = DateTime.Now,
                    RentalDetail = rd,
                    Penality = _penality,
                    Mount = Mount,
                    Status = true,
                    Usuario = db.Usuarios.FirstOrDefault(a => a.Id == 1)
                };

                db.AddToReturnMovies(rm);
                rd.isDevuelta = true;
                db.SaveChanges();
                var c = db.ReturnMovies.Where(a => a.RentalDetail.RentalMovie.Id == r.Id).Count();
                if (r.QuantityMovie == c)
                {
                    r.StatusRental = db.StatusRentals.FirstOrDefault(a => a.Id == 3);
                }
                else
                {
                    r.StatusRental = db.StatusRentals.FirstOrDefault(a => a.Id == 2);
                }
                db.SaveChanges();
            }
            catch (Exception ex)
            {

            }
            return "";
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string AddAlquiler(int idCliente, int days,int cantidad, int total, string Details)
        {
            try
            {
                List<AlquilerViewModel> avm = JsonConvert.DeserializeObject<List<AlquilerViewModel>>(Details);
                int idUser = 1;// Convert.ToInt32(Session["idUsuario"].ToString());
                RentalMovie r = new RentalMovie();
                r.Client = db.Clients.Where(a => a.Id == idCliente).First();
                r.Days = days;
                r.DateRental = DateTime.Now;
                r.DateRetund = r.DateRental.Value.AddDays(days);
                r.QuantityMovie = cantidad;
                r.Total = total;
                r.StatusRental = db.StatusRentals.Where(a => a.Id == 1).First();
                r.Usuario = db.Usuarios.Where(a => a.Id == idUser).First();
                db.AddToRentalMovies(r);
                if (db.SaveChanges() > 0)
                {
                    foreach (AlquilerViewModel a in avm)
                    {
                        RentalDetail rn = new RentalDetail();
                        rn.Movie = db.Movies.Where(m => m.Id == a.IdMovie).First();
                        rn.Price = a.Price;
                        rn.Quantity = a.Cantidad;
                        rn.SubTotal = a.Total;
                        rn.RentalMovie = r;
                        rn.isDevuelta = false;
                        db.AddToRentalDetails(rn);
                    }
                    db.SaveChanges();
                }
                return "";
            }
            catch (Exception ex)
            {
               return ex.ToString();
            }
          
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string AddMovie(string movie)
        {
            try
            {
                MovieViewModel m = JsonConvert.DeserializeObject<MovieViewModel>(movie);
                db.AddToMovies(new Movie
                {
                    Title = m.Title,
                    Description = m.Description,
                    Category = db.Categories.FirstOrDefault(a => a.Id == m.CategoryId),
                    Year = m.Year,
                    Stock = m.Stock,
                    Exhausted = m.Exhausted,
                    Status = m.Status
                });
                if (db.SaveChanges() > 0)
                {
                    return "Insertado";
                }
                else
                {
                    return "Error al insertar";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }


        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string EditMovie(string movie)
        {
            try
            {
                MovieViewModel m = JsonConvert.DeserializeObject<MovieViewModel>(movie);

                Movie c = db.Movies.FirstOrDefault(a => a.Id == m.Id);
                c.Title = m.Title;
                c.Description = m.Description;
                c.Category = db.Categories.FirstOrDefault(a => a.Id == m.CategoryId);
                c.Year = m.Year;
                c.Stock = m.Stock;
                c.Status = m.Status;
                c.Exhausted = m.Exhausted;
                if (db.SaveChanges() > 0)
                {
                    return "Actualizado";
                }
                else
                {
                    return "Error al actualizar";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string DeleteMovie(int Id)
        {
            db.DeleteObject(db.Movies.FirstOrDefault(a => a.Id == Id));
            if (db.SaveChanges() > 0)
            {
                return "Eliminado";
            }
            else
            {
                return "Error no se pudo eliminar";
            }

        }
        #endregion
    }
}
