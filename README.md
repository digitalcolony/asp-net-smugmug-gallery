asp-net-smugmug-gallery
=======================

Displaying a SmugMug Gallery with ASP.NET

Back in the day I used to host all my own image galleries on my site. It’s a tedious process and you can quickly use up your allocated disk space with today’s multi-mega pixel cameras. Fortunately we have companies like SmugMug and Flickr that will host, manage and back-up all our images.

The problem with not hosting photo galleries is you send your audience away from your site over to their server. And your photo galleries develop their own audience which knows nothing about the parent site.

I discovered that using the XmlDataSource and DataList ASP.NET controls you can build a photo gallery on your site while the images stay over on SmugMug using a simple RSS feed.

The XmlDataSource

ASP.NET 2.0 introduced the asp:XmlDataSource control which we will use to connect to the SmugMug RSS feed. The DataFile parameter is the path to the RSS file for that photo gallery. In the snippet below, I hard-coded that value. In the example and lab that value is populated in the code behind. Also important is the XPath parameter. This is the address inside the XML Document that holds the information about each photo.

<asp:XmlDataSource ID="xmlDS" runat="server" XPath="rss/channel/item"
    DataFile= "http://www.smugmug.com/hack/feed.mg?Type=gallery&Data=1838622&format=rss200" />

The RSS Feed (XML Document)

Here is a snippet of how a single photo is represented inside the XML Document. I’ve removed the portion which deals with the gallery name, as it is not used in this example. In this example the 2 values that are used when rendering the gallery inside the DataList will be link and guid.

<item>
    <title>Image Title</title>

    <link>http://criticalmas.smugmug.com/gallery/1838622/1/92083732</link>
    <description>Image description</description>
    <category>Vacation</category>

    <comments>http://criticalmas.smugmug.com/comment.mg...</comments>
    <exif:DateTimeOriginal>2006-08-24 19:07:19</exif:DateTimeOriginal>
    <pubDate>Thu, 31 Aug 2006 19:02:05 -0700</pubDate>

    <author>feeds-nobody@smugmug.com (criticalmas)</author>
    <guid isPermaLink="true">http://criticalmas.smugmug.com/photos/92083732-Th.jpg</guid>
    <enclosure url="http://criticalmas.smugmug.com/photos/92083732-Th.jpg" length="7741" type="image/jpeg"/>

</item>
The DataList Control

For this gallery, I set the RepeatColumns to 6 and just displayed the thumbnail image with a link to the full-sized image back on the SmugMug web site.

<asp:DataList ID="dlPhotos" runat="server" RepeatColumns="6">

<ItemTemplate>
  <a href="<%# XPath("link").ToString() %>">
     <asp:Image ID="img" ImageUrl='<%# XPath("guid") %>' runat="server"  /></a>

</ItemTemplate>
</asp:DataList>
Sample ASPX Using a Gallery Dropdown

The GalleryID is pulled from the URL of the photo gallery over on SmugMug. This is covered in detail in the sample lab.

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
And the Code Behind (C#)

protected void Page_Load(object sender, EventArgs e)
{
   string rssURL;
   string galleryID;
   galleryID = ddlGallery.SelectedValue.ToString();
   rssURL = "http://www.smugmug.com/hack/feed.mg?Type=gallery&Data=" + galleryID + "&format=rss200";

   try

   {
       xmlDS.DataFile = rssURL;
       dlPhotos.DataSource = xmlDS;
       dlPhotos.DataBind();
   }
   catch (XmlException err)
   {
       lblError.Text = "Oops, looks like an error occured with this gallery: " + err.Message;
       lblError.Visible = true;
   }
}
Lab Demo

SmugMug Image Gallery in ASP.NET

The gallery uses a simple 6 column layout. Once you have the RSS feed, you can be as creative as you like in designing the layout for your photo gallery.
