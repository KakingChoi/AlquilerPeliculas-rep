<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientForm.aspx.cs" Inherits="TiendaAlquiler.Mantenimientos.ClientForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dialogEdit;
        $(document).ready(function () {
            Clients();
            var dialog, form;

            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 350,
                width: 350,
                modal: true,
                buttons: {
                    "Crear Cliente": AddClient,
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
                height: 350,
                width: 350,
                modal: true,
                buttons: {
                    "Editar Cliente": editClient,
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
        var AddClient = function () {

            var c = {
                Name: $('#name').val(),
                Phone: $('#phone').val(),
                Adress: $('#adress').val()
            };

            $.post('/mantenimientos/ServicesMethod.asmx/AddClient', { client: JSON.stringify(c) }, function (result) {
                console.log('R', result);
                location.reload();

            });
        };
        var Clients = function () {
            $.get('/mantenimientos/ServicesMethod.asmx/getClients', function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                var rows = '';
                $.each(obj, function (index, row) {
                    rows += '<tr>';
                    rows += '<td>' + row.Id + '</td>';
                    rows += '<td>' + row.Name + '</td>';
                    rows += '<td>' + row.Phone + '</td>';
                    rows += '<td>' + row.Adress + '</td>';
                    rows += '<td><a href="#" onclick="EditRow(' + row.Id + ');" data-toggle="modal" data-target="#m_modal_edit" ><img src="../Style/img/edit.ico" /> </a>  ';
                    rows += '  <a href="#" onclick="RemoveRow(' + row.Id + ');" title="Delete"><img src="../Style/img/delete.ico" /></a></td>';
                    rows += '</tr>';
                });
                $('#tblDatos tbody').append(rows);
            });
        }

        var EditRow = function (Id) {

            $.get('/mantenimientos/ServicesMethod.asmx/getClientById', { Id: Id }, function (result) {
                var obj = $.parseJSON($(result).find('string[xmlns]').html());
                $('#idEdit').val(obj.Id);
                $('#Editname').val(obj.Name);
                $('#Editphone').val(obj.Phone);
                $('#Editadress').val(obj.Adress);
                dialogEdit.dialog("open");

            });

        };

        var editClient = function () {
            var c = {
                Id: $('#idEdit').val(),
                Name: $('#Editname').val(),
                Phone: $('#Editphone').val(),
                Adress: $('#Editadress').val()
            };

            $.get('/mantenimientos/ServicesMethod.asmx/EditClient', { client: JSON.stringify(c) }, function (result) {
                console.log('R', result);
                location.reload();

            });
        }

        var RemoveRow = function (Id) {
            var Okay = confirm('Estas Seguro Que Deseas Eliminar Este Registro?');
            if (Okay) {
                $.get('/mantenimientos/ServicesMethod.asmx/DeleteClient', { Id: Id }, function (result) {
                    console.log('R', result);
                    location.reload();
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog-form" title="Crear Cliente">

        <form id="add">
            <fieldset>
                <label for="name">Name</label>
                <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all" />
                <label for="phone">Teléfono</label>
                <input type="text" name="phone" id="phone" value="" class="text ui-widget-content ui-corner-all" />
                <label for="adress">Dirección</label>
                <input type="text" name="adress" id="adress" value="" class="text ui-widget-content ui-corner-all" />

                <!-- Allow form submission with keyboard without duplicating the dialog button -->
                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>
    <div id="dialog-form-edit" title="Edtar Cliente">

        <form id="edit">
            <fieldset>
                <label for="Editname">Name</label>
                <input type="text" name="name" id="Editname" value="" class="text ui-widget-content ui-corner-all" />
                <input type="hidden" id="idEdit" />
                <label for="Editphone">Teléfono</label>
                <input type="text" name="phone" id="Editphone" value="" class="text ui-widget-content ui-corner-all" />
                <label for="Editadress">Dirección</label>
                <input type="text" name="adress" id="Editadress" value="" class="text ui-widget-content ui-corner-all" />
                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>

    <div style="padding: 4px 4px 4px 4px; margin-bottom: auto">
        <a href="#" id="new" class="bt">Nuevo Cliente</a>

    </div>
    <table id="tblDatos">
        <thead>
            <tr>
                <th>Id</th>
                <th>Nombre</th>
                <th>Teléfono</th>
                <th>Dirección</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</asp:Content>
