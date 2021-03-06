<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Store_ReadData(object sender, StoreReadDataEventArgs e)
    {
        Store store = (Store)sender;
        List<StockQuotation> data = new List<StockQuotation>();
        
        int start = e.Start,
            limit = e.Limit;
        Random randow = new Random();
        DateTime now = DateTime.Now;
        
        for (int i = start + 1; i <= start + limit; i++)
        {
            StockQuotation qoute = new StockQuotation()
            {
                Company = "Company " + i,
                Price = randow.Next(0, 200),
                LastUpdate = now
            };
            
            data.Add(qoute);
        }
        store.Data = data;
        e.Total = 50000;
    }

    class StockQuotation
    {
        public string Company  { get; set; }
        public int Price { get; set; }
        public DateTime LastUpdate { get; set; }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scrolling - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Infinite Scrolling</h1>

        <p>Ext.Net 2's brand new grid supports infinite scrolling, which enables you to load any number of records into a grid without paging.</p>
        
        <p>The new grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>
        
        <ext:GridPanel 
            runat="server" 
            Width="500" 
            Height="500"
            DisableSelection="true" 
            Title="Stock Price">
            <Store>
                <ext:Store 
                    runat="server" 
                    Buffered="true" 
                    PageSize="100"
                    OnReadData="Store_ReadData">
                    <Proxy>
                        <ext:PageProxy>
                            <Reader>
                                <ext:JsonReader Root="data" />
                            </Reader>
                        </ext:PageProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Company" />
                                <ext:ModelField Name="Price" />
                                <ext:ModelField Name="LastUpdate" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>           
            <ColumnModel runat="server">
		        <Columns>
                    <ext:RowNumbererColumn 
                        runat="server" 
                        Width="50" 
                        Sortable="false" />
                    <ext:Column 
                        runat="server" 
                        Text="Company" 
                        DataIndex="Company" 
                        Flex="1" />
                    <ext:Column 
                        runat="server" 
                        Text="Price, $" 
                        DataIndex="Price" 
                        Width="70" 
                        Align="Center" />
                    <ext:Column 
                        runat="server" 
                        Text="Last Update" 
                        DataIndex="LastUpdate" 
                        Width="140">
                        <Renderer Format="Date" FormatArgs="'n/j/Y g:i:s A'" />
                    </ext:Column>
		        </Columns>
            </ColumnModel>           
            <View>
                <ext:GridView runat="server" TrackOver="false" />
            </View>                        
        </ext:GridPanel>
    </form>
</body>
</html>
