<asp:DataList ID="dlPhotos" runat="server" RepeatColumns="6">

<ItemTemplate>
  <a href="<%# XPath("link").ToString() %>">
     <asp:Image ID="img" ImageUrl='<%# XPath("guid") %>' runat="server"  /></a>

</ItemTemplate>
</asp:DataList>
