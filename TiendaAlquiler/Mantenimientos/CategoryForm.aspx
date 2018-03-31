<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CategoryForm.aspx.cs" Inherits="TiendaAlquiler.Mantenimientos.CategoryForm" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var dialogEdit;
        $(document).ready(function () {
            Categories();
            var dialog, form;
            
            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 200,
                width: 350,
                modal: true,
                buttons: {
                    "Crear Categoria": AddCategory,
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
                height: 200,
                width: 350,
                modal: true,
                buttons: {
                    "Editar Categoria": editCategory,
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
                dialog.dialog("open");
            });
        });
        var AddCategory = function () {

            var name = $('#name').val();
            $.get('/mantenimientos/ServicesMethod.asmx/AddCategory', { Name: name}, function (result) {
                console.log('R', result);
                location.reload();
                
            });
        };
            var Categories = function () {
                $.get('/mantenimientos/ServicesMethod.asmx/getCategories', function (result) {
                    var obj = $.parseJSON($(result).find('string[xmlns]').html());
                    var rows = '';
                    $.each(obj, function (index, row) {
                        rows += '<tr>';
                        rows += '<td>' + row.Id + '</td>';
                        rows += '<td>' + row.Name + '</td>';
                        rows += '<td><a href="#" onclick="EditRow(' + row.Id + ');" data-toggle="modal" data-target="#m_modal_edit" ><img src="../Style/img/edit.ico" /> </a>  ';
                        rows += '  <a href="#" onclick="RemoveRow(' + row.Id + ');" title="Delete"><img src="../Style/img/delete.ico" /></a></td>';
                        rows += '</tr>';
                    });
                    $('#tblDatos tbody').append(rows);
                });
            }
            
            var EditRow = function (Id) {
               
                $.get('/mantenimientos/ServicesMethod.asmx/getCategoryById', { Id: Id }, function (result) {
                    var obj = $.parseJSON($(result).find('string[xmlns]').html());
                    $('#idEdit').val(obj.Id);
                    $('#Editname').val(obj.Name);
                    dialogEdit.dialog("open");

                });
                
            };
           
            var editCategory = function () {
                var name = $('#Editname').val();
                var Id = $('#idEdit').val();
                $.get('/mantenimientos/ServicesMethod.asmx/EditCategory', {Id:Id, Name: name }, function (result) {
                    console.log('R', result);
                    location.reload();

                });
            }

            var RemoveRow = function (Id) {
                var Okay = confirm('Estas Seguro Que Deseas Eliminar Este Registro?');
                if (Okay) {
                    $.get('/mantenimientos/ServicesMethod.asmx/DeleteCategory', { Id: Id }, function (result) {
                        console.log('R', result);
                        location.reload();
                    });
                }
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="dialog-form" title="Crear Nueva Categoria">
        
        <form id="add">
            <fieldset>
                <label for="name">Name</label>
                <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all"/>
                
                <!-- Allow form submission with keyboard without duplicating the dialog button -->
                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>
        <div id="dialog-form-edit" title="Edtar Categoria">
        
        <form id="edit">
            <fieldset>
                <label for="Editname">Name</label>
                <input type="text" name="name" id="Editname" value="" class="text ui-widget-content ui-corner-all"/>
                <input type="hidden" id="idEdit" />
                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>

    <div style="padding:4px 4px 4px 4px;margin-bottom:auto">
        <a href="#" id="new" class="bt">Nueva Categoria</a>
       
    </div>
    <table id="tblDatos">
        <thead>
            <tr>
                <th>Id</th>
                <th>Descripcion</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</asp:Content>
