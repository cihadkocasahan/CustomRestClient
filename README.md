# CustomRestClient
I create a Custom Rest Client Implementation with RestResponse,RestRequest,RestClient,RESTResponseDataSetAdapter.
You can use it give an url and get data with rootelement.

var 
Client:fCustomRestClient;

Client:=TCustomClient.Createrequest('BaseURL').Get;
or 
Client:=TCustomClient.Createrequest('BaseURL').Get('datas');
Client.Dataset := FDMemTable1;
Client.ExecuteRequest;

Later you can see data in fdmemtable.



