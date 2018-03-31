<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TiendaAlquiler.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="float:left;width:40%;">
        Iniciar Session
        <p align="justify">
            <asp:label id="lblErrorlogin" runat="server" text="Label" forecolor="Red" visible="False"></asp:label>
        </p>
        <div class="form-group">
            <asp:label runat="server" associatedcontrolid="txtUserName" cssclass="col-md-2 control-label">Usuario</asp:label>
            <div class="col-md-10">
                <asp:textbox runat="server" id="txtUserName" cssclass="text ui-widget-content ui-corner-all" />
                <asp:requiredfieldvalidator runat="server" controltovalidate="txtUserName"
                    cssclass="text-danger" errormessage="Este Campo debe estar vacio." />
            </div>
        </div>
        <div class="form-group">
            <asp:label runat="server" associatedcontrolid="Password" cssclass="col-md-2 control-label">Password</asp:label>
            <div class="col-md-10">
                <asp:textbox runat="server" id="Password" textmode="Password" cssclass="text ui-widget-content ui-corner-all" />
                <asp:requiredfieldvalidator runat="server" controltovalidate="Password" cssclass="text-danger" errormessage="Este Campo debe estar vacio." />
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:button id="btEntrar" runat="server" onclick="btEntrar_Click" text="Log in" cssclass="bt" />
            </div>
        </div>


    </div>
    <div style="float:right;">
        <h1>Bienvenido al sistema de alquier de peliculas</h1>
    </div>
</asp:Content>
