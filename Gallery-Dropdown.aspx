<asp:XmlDataSource ID="xmlDS" runat="server" XPath="rss/channel/item" />

<h4>Select Gallery</h4>
<asp:DropDownList ID="ddlGallery" runat="server" AutoPostBack="true">
    <asp:ListItem Text="1838622: Uruguay - Colonia" Value="1838622" />

    <asp:ListItem Text="2473610: Lower Hellhole Canyon Desert Hike" Value="2473610" />
    <asp:ListItem Text="1887671: New Zealand - Whakarewarewa Thermal Village" Value="1887671" />

</asp:DropDownList>
<br /><br />
<asp:DataList ID="dlPhotos" runat="server" RepeatColumns="6">

<ItemTemplate>
    <a href="<%# XPath("link").ToString() %>">
        <asp:Image ID="img" ImageUrl='<%# XPath("guid") %>' runat="server" /></a>

</ItemTemplate>
</asp:DataList>
<asp:Label ID="lblError" Visible="false" runat="server" />
