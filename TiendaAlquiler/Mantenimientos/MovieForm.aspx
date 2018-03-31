<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MovieForm.aspx.cs" Inherits="TiendaAlquiler.Mantenimientos.MovieForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dialogEdit;
        $(document).ready(function () {
            Movies();
            var dialog, form;

            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 520,
                width: 350,
                modal: true,
                buttons: {
                    "Crear Pelicula": AddMovie,
                    Cancel: function () {
                        dialog.dialog("close");
                    }
                },
                close: function () {
                    //form[0].reset();
                    //  allFields.removeClass("ui-state-error");
                }
            });
            dialogEdit = $("#dialog-form-edit").dialog({
                autoOpen: false,
                height: 520,
                width: 350,
                modal: true,
                buttons: {
                    "Editar Pelicula": editMovie,
                    Cancel: function () {
                        dialogEdit.dialog("close");
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
            $("#new").button().on("click", function () {
                var _id = $('#idCategory');
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

                dialog.dialog("open");
            });
        });
        var AddMovie = function () {

            var c = {
                Title: $('#title').val(),
                Description: $('#description').val(),
                CategoryId: $('#idCategory').val(),
                Year: $('#year').val(),
                Stock: $('#stock').val(),
                Exhausted: $('#texhausted').is(':checked'),
                Status: $('#status').is(':checked')

            };

            $.post('/mantenimientos/ServicesMethod.asmx/AddMovie', { movie: JSON.stringify(c) }, function (result) {
                console.log('R', result);
                location.reload();

            });
        };
        var Movies = function () {
            $.get('/mantenimientos/ServicesMethod.asmx/getMovies', function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                var rows = '';
                $.each(obj, function (index, row) {
                    rows += '<tr>';
                    rows += '<td>' + row.Id + '</td>';
                    rows += '<td>' + row.Title + '</td>';
                    rows += '<td>' + row.Description + '</td>';
                    rows += '<td>' + row.Year + '</td>';
                    rows += '<td><a href="#" onclick="EditRow(' + row.Id + ');" data-toggle="modal" data-target="#m_modal_edit" ><img src="../Style/img/edit.ico" /> </a>  ';
                    rows += '  <a href="#" onclick="RemoveRow(' + row.Id + ');" title="Delete"><img src="../Style/img/delete.ico" /></a></td>';
                    rows += '</tr>';
                });
                $('#tblDatos tbody').append(rows);
            });
        }

        var EditRow = function (Id) {
            Categories();
            $.get('/mantenimientos/ServicesMethod.asmx/getMovieById', { Id: Id }, function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                console.log('o', obj);
                $('#idEdit').val(obj.Id);
                $('#Edittitle').val(obj.Title);
                $('#Editdescription').val(obj.Description);
                $('#EditidCategory').val(obj.CategoryId);
                $('#Edityear').val(obj.Year);
                $('#Editstock').val(obj.Stock);
                $('#Editexhausted').attr('checked', obj.Exhausted);          //.val(obj.Exhausted);
                $('#Editstatus').attr('checked',obj.Status);

                dialogEdit.dialog("open");

            });

        };

        var editMovie = function () {
            var c = {
                Id: $('#idEdit').val(),
                Title: $('#Edittitle').val(),
                Description: $('#Editdescription').val(),
                CategoryId: $('#EditidCategory').val(),
                Year: $('#Edityear').val(),
                Stock: $('#Editstock').val(),
                Exhausted: $('#Editexhausted').is(':checked'),
                Status: $('#Editstatus').is(':checked')
            };

            $.get('/mantenimientos/ServicesMethod.asmx/EditMovie', { movie: JSON.stringify(c) }, function (result) {
                console.log('R', result);
                location.reload();

            });
        }
        var Categories = (function () {
            var _id = $('#EditidCategory');
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
            
        });
        var RemoveRow = function (Id) {
            var Okay = confirm('Estas Seguro Que Deseas Eliminar Este Registro?');
            if (Okay) {
                $.get('/mantenimientos/ServicesMethod.asmx/DeleteMovie', { Id: Id }, function (result) {
                    console.log('R', result);
                    location.reload();
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog-form" title="Crear Pelicula">

        <form id="add">
            <fieldset>
                <label for="title" class="modal">Titulo</label>
                <input type="text"  name="title" id="title" value="" class="text ui-widget-content ui-corner-all modal" />
                <label for="description" class="modal">Descripción</label>
                <input type="text"  name="description" id="description" value="" class="text ui-widget-content ui-corner-all modal" />
                <label for="idCategory" class="modal ">Categoria</label>
                <select id="idCategory" class="text ui-widget-content ui-corner-all modal"></select>
                
                <label for="year" class="modal">Año</label>
                <input type="text" name="year" id="year" value="" class="text ui-widget-content ui-corner-all modal" />

                <label for="stock">Existencia</label>
                <input type="text" name="stock" id="stock" value="" class="text ui-widget-content ui-corner-all modal" />
                <label for="exhausted" class="modal ">Extreno</label>
                <input type="radio" name="exhausted" id="exhausted" value="" class="text ui-widget-content ui-corner-all modal" />
                <label for="status" class="modal ">Disponble</label>
                <input type="radio" name="status" id="status" value="" class="text ui-widget-content ui-corner-all modal" />
                <!-- Allow form submission with keyboard without duplicating the dialog button -->
                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>
    <div id="dialog-form-edit" title="Edtar Pelicula">

        <form id="edit">
            <fieldset>

                <input type="hidden" id="idEdit" />
                <label for="Edittitle" class="modal ">Titulo</label>
                <input type="text" name="title" id="Edittitle" value="" class=" text ui-widget-content ui-corner-all" />
                <label for="Editdescription" class="modal ">Descripción</label>
                <input type="text" name="description" id="Editdescription" value="" class="text ui-widget-content ui-corner-all" />
                <label for="EditidCategory" class="modal ">Categoria</label>
                 <select id="EditidCategory" class="text ui-widget-content ui-corner-all"></select>
                
                <label for="Edityear" class="modal ">Año</label>
                <input type="text" name="year" id="Edityear" value="" class=" text ui-widget-content ui-corner-all" />

                <label for="Editstock" class="modal ">Existencia</label>
                <input type="text" name="stock" id="Editstock" value="" class=" text ui-widget-content ui-corner-all" />
                <label for="Editexhausted" class="modal ">Extreno</label>
                <input type="radio" name="exhausted" id="Editexhausted" value="" class="  text ui-widget-content ui-corner-all" />
                <label for="Editstatus" class="modal ">Disponble</label>
                <input type="radio" name="status" id="Editstatus" value="" class="text ui-widget-content ui-corner-all" />

                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>

    <div style="padding: 4px 4px 4px 4px; margin-bottom: auto">
        <a href="#" id="new" class="bt">Nueva Pelicula</a>

    </div>
    <table id="tblDatos">
        <thead>
            <tr>
                <th>Id</th>
                <th>Titulo</th>
                <th>Descripción</th>
                <th>Año</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</asp:Content>
