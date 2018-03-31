<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AlquilerForm.aspx.cs" Inherits="TiendaAlquiler.AlquilerForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dialog, form;
       
        $(document).ready(function () {
            Categories();
            Clients();
            $('#cantidad').val(0);
            $('#total').val(0);
            $('#subtotal').val(0);
                       
            $('#dias').change(function () { CalculaTotales(); });
            $('#dias').keydown(function (event) {
                if(event.keyCode == 13)
                    CalculaTotales();
            });

            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 520,
                width: 600,
                modal: true,
                buttons: {
                    "Seleccionar Pelicula": SelectMovie,
                    Cancel: function () {
                        dialog.dialog("close");
                    }
                },
                close: function () {
                    //form[0].reset();
                    //  allFields.removeClass("ui-state-error");
                }
            });
            form = dialog.find("form").on("submit", function (event) {
                event.preventDefault();
                //  addUser();
            });
            $('#btBuscar').click(function () {
                var title = $('#titulo').val(); 
                var idcategory = $('#ddlCategory').val();
                var year = $('#ddlYear').val();
                $('#tblDatosfilter tbody').html('');
                $.get('/mantenimientos/ServicesMethod.asmx/getMoviesFilter',{ year:year ,  title:title,  category:idcategory}, function (result) {
                    var obj = $.parseJSON($(result).find('string[xmlns]').html());
                    console.log('o', obj);
                    var rows = '';
                    $.each(obj, function (index, row) {
                        rows += '<tr>';
                        rows += '<td>' + row.Id + '</td>';
                        rows += '<td>' + row.Title + '</td>';
                        rows += '<td>' + row.Description + '</td>';
                        rows += '<td>' + row.CategoryName + '</td>'
                        rows += '<td>' + row.Year + '</td>';
                        if (row.Exhausted == true) {
                            rows += '<td>Si</td>';
                        } else {
                            rows += '<td>No</td>';
                        }
                        rows += '<td> <input type="checkbox" value="' + row.Id + '" /> ';
                        rows += '</tr>';
                    });
                    $('#tblDatosfilter tbody').append(rows);
                    
                });

                dialog.dialog("open");
            });

        });
        var SelectMovie = function () {
            var total = $('#total').val();
            var cantidad = $('#cantidad').val();
            $("#tblDatosfilter tbody tr input[type=checkbox]:checked").each(function () {
                var idMovie = $(this).val();
                
                $.get('/mantenimientos/ServicesMethod.asmx/getAlquiler', { IdMovie:idMovie }, function (result) {
                    var obj = $.parseJSON($(result).find('string[xmlns]').html());
                    console.log('o', obj);
                    var rows = '';
                    
                        rows += '<tr>';
                        rows += '<td>' + obj.IdMovie + '</td>';
                        rows += '<td>' + obj.Title + '</td>';
                        rows += '<td class="Cant">' + obj.Cantidad + '</td>';
                        rows += '<td>' + obj.Price + '</td>'
                        rows += '<td class="Total">' + obj.Total + '</td>';
                        rows += '<td>  <a href="" id="removeMovieSelected"  title="Delete"><img src="../Style/img/delete.ico" /></a></td>';
                        rows += '</tr>';
                        
                        $('#tblDatos tbody').append(rows);
                        CalculaTotales();
                });


            });            
            
            dialog.dialog("close");            
        };

        $(document).on('click', '#removeMovieSelected', function () {
            $(this).closest('tr').remove();
            CalculaTotales();
            return false;
        });

        var CalculaTotales = function () {
            var Total = 0;
            var Cantidad = 0;
            $('#tblDatos tbody tr').each(function () {
                var coltotal = $("td:eq(4)", this).html();
                var colcantidad = $("td:eq(2)", this).html();
                if (coltotal != null && coltotal != "") {

                    Total += parseInt(coltotal);
                }
                if (colcantidad != null && colcantidad != "") {

                    Cantidad += parseInt(colcantidad);
                }
            });
            $('#cantidad').val(Cantidad);
            $('#subtotal').val(Total);
            $('#total').val($('#subtotal').val() * $('#dias').val());
        };

      

        var Categories = function () {
            var _id = $('#ddlCategory');
            var _text = 'Name';
            var _value = 'Id';
            var _selected = '-- SELECCIONE --';
            $.get('/mantenimientos/ServicesMethod.asmx/getCategories', function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                if (!IsNullOrEmpty(_selected)) {
                    _selected = '<option selected="selected"  value="0">' + _selected + '</option>';
                    $(_id).append(_selected);
                }

                $.each(obj, function (index, i) {

                    $(_id).append("<option value='" + i[_value] + "'>" + i[_text] + "</option>");
                });
            });
        }
        var Clients = function () {
            var _id = $('#ddlClient');
            var _text = 'Name';
            var _value = 'Id';
            var _selected = '-- SELECCIONE --';
            $.get('/mantenimientos/ServicesMethod.asmx/getClients', function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                if (!IsNullOrEmpty(_selected)) {
                    _selected = '<option selected="selected"  value="0">' + _selected + '</option>';
                    $(_id).append(_selected);
                }

                $.each(obj, function (index, i) {

                    $(_id).append("<option value='" + i[_value] + "'>" + i[_text] + "</option>");
                });
            });
        }
        var Grabar = function () {
            var nFilas = $("#tblDatos tbody tr").length;
            
            if (nFilas < 1) {
                alert('Debe seleccionar la(s) Peliculas');
                return;
            }
            if ($('#ddlClient').val() < 1) {
                alert('Debe seleccionar un cliente');
                return;
            }
            if (IsNullOrEmpty($('#dias').val())) {
                alert('Debe espeficicar los dias');
                $('#dias').focus();
                return;
            }
            CalculaTotales();
            var idcliente = $('#ddlClient').val();
            var days = $('#dias').val();
            var cant = $('#cantidad').val();
            var total = $('#total').val();
           
           
            var d = [];
            $('#tblDatos tbody tr').each(function () {
                var Al = {
                    IdMovie : $("td:eq(0)", this).html(),
                    Title : $("td:eq(1)", this).html(),
                    Price : $("td:eq(3)", this).html(),
                    Cantidad : $("td:eq(2)", this).html(),
                    Total: $("td:eq(4)", this).html()
                };
                d.push(Al);
               
            });

            $.post('/mantenimientos/ServicesMethod.asmx/AddAlquiler',{idCliente:idcliente, days:days, cantidad:cant,  total:total,  Details:JSON.stringify(d)}, function (result) {
                console.log('r', result);
                location.reload();
            });


        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="leftCol" style="float: left; width: 40%;">
        <fieldset class="criterio">
            <legend>Alquiler</legend>
            <div>

                <label for="ddlClient">Cliente:</label>
                <select id="ddlClient" class="text ui-widget-content ui-corner-all"></select>
            </div>
            <div>
                <label for="dias">Dias:</label>
                <input type="text" id="dias" class="field" />
            </div>
            <div>
                <label for="cantidad">Cantidad:</label>
                <input type="text" id="cantidad" readonly="true" class="field" />
            </div>
                <div>

                <label for="total">SubTotal:</label>
                <input type="text" id="subtotal" readonly="true" class="field" />
            </div>
            <div>

                <label for="total">Total:</label>
                <input type="text" id="total" readonly="true" class="field" />
            </div>

        </fieldset>
    </div>

    <div style="float: right; width: 40%;">
        <fieldset>
            <legend>Busqueda Pelicula</legend>
            <div>
                <label for="ddlCategory">Categorias:</label>
                <select id="ddlCategory" class="text ui-widget-content ui-corner-all"></select>
            </div>
            <div>
                <label for="ddlYear">Años:</label>
                <select id="ddlYear" class="text ui-widget-content ui-corner-all">
                    <option value="0">--SELECCIONE--</option>
                    <option value="2018">2018</option>
                    <option value="2017">2017</option>
                    <option value="2016">2016</option>
                    <option value="2015">2015</option>
                    <option value="2014">2014</option>
                    <option value="2013">2013</option>
                    <option value="2012">2012</option>
                    <option value="2011">2011</option>
                    <option value="2010">2010</option>
                    <option value="2009">2009</option>
                </select>
            </div>
            <div>
                <label for="titulo">Titulo:</label>
                <input type="text" id="titulo" class="field" />
            </div>
            <div>
                <a href="#" id="btBuscar" class="bt">Buscar
                    <img src="Style/img/preview_search_find_locate_1551.png" style="width: 20px; height: 20px;" /></a>
            </div>
        </fieldset>

    </div>
    <div id="dialog-form" title="Filtro Pelicula">
        <form>

            <table id="tblDatosfilter">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Titulo</th>
                        <th>Descripción</th>
                        <th>Categoria</th>
                        <th>Año</th>
                        <th>Extreno</th>
                        <th>Acciones</th>
                    </tr>

                </thead>
                <tbody></tbody>
            </table>
        </form>
    </div>
    <div>
 <table id="tblDatos">
        <thead>
            <tr>
                <th>Id</th>
                <th>Titulo</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Total</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    </div>
   
    <div>
        <a href="#" id="btAceptar" onclick="Grabar();"  class="bt">Aceptar</a>
        <a href="#" id="btCancelar" class="bt">Cancelar</a>
    </div>
</asp:Content>
