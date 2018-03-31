<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DevolucionForm.aspx.cs" Inherits="TiendaAlquiler.DevolicionForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            Devolucion();
        });
        var Devolucion = function ()
        {
            $('#tblDatos tbody').html('');
            $.get('/mantenimientos/ServicesMethod.asmx/getReturn', function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                var rows = '';
                $.each(obj, function (index, row) {
                    rows += '<tr>';
                    rows += '<td>' + row.AlquilerId + '</td>';
                    rows += '<td>' + row.DetailId + '</td>';
                    rows += '<td>' + row.MovieId + '</td>';
                    rows += '<td>' + row.MovieTitle + '</td>';
                    rows += '<td>' + row.Cantidad + '</td>';
                    rows += '<td>' + row.subTotal + '</td>';
                    rows += '<td>' + row.ClientId + '</td>';
                    rows += '<td>' + row.ClientName + '</td>';
                    rows += '<td>' + row.DateReturn + '</td>';
                    rows += '<td>' + row.StatusName + '</td>';
                    if (row.Penality == true) {
                        rows += '<td>Si</td>';
                    } else {
                        rows += '<td>No</td>';
                    }
                    
                    rows += '<td>' + row.Mount + '</td>';
                    if (row.isDevuelta == false) {
                        rows += '<td><a href=""id="returnMovieSelected"  title="Devolver Pelicula">  <img src="../Style/img/confirm.ico" /> </a></td>';
                    } else {
                        rows += '<td></td>';
                    }
                    
                    rows += '</tr>';
                });
                $('#tblDatos tbody').append(rows);
            });
        };
        $(document).on('click', '#returnMovieSelected', function () {
            var AlquilerId = $(this).closest('tr').find('td').eq(0).html();
            var DetailId = $(this).closest('tr').find('td').eq(1).html();
            var movieId = $(this).closest('tr').find('td').eq(2).html();
            var MovieTitle = $(this).closest('tr').find('td').eq(3).html();
            var Cantidad = $(this).closest('tr').find('td').eq(4).html();
            var subTotal = $(this).closest('tr').find('td').eq(5).html();
            var ClientId = $(this).closest('tr').find('td').eq(6).html();
            var ClientName = $(this).closest('tr').find('td').eq(7).html();
            var DateReturn = $(this).closest('tr').find('td').eq(8).html();
            var StatusName = $(this).closest('tr').find('td').eq(9).html();
            var Penality = $(this).closest('tr').find('td').eq(10).html();
            var Mount = $(this).closest('tr').find('td').eq(11).html();
            
            $.post('/mantenimientos/ServicesMethod.asmx/DevolverPelicula', { MovieId: movieId, ClientId: ClientId, Cantidad: Cantidad, RentalDetailId: DetailId, Penality: Penality, Mount: Mount, AlquilerId: AlquilerId }, function (result) {
                alert('Devolucion Exitosa');
                Devolucion();
                return false;
            });
           // CalculaTotales();
            return false;
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table id="tblDatos">
        <thead>
            <tr>
                <th>AlquilerId</th>
                <th>DetailId</th>
                <th>MovieId</th>
                <th>MovieTitle</th>
                <th>Cantidad</th>
                <th>subTotal</th>
                <th>ClientId</th>
                <th>ClientName</th>
                <th>DateReturn</th>
                <th>StatusName</th>
                <th>Penality</th>
                <th>Mount</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</asp:Content>
 
