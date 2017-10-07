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
