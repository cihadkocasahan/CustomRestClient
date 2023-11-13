# CustomRestClient
I create a Custom Rest Client Implementation with RestResponse,RestRequest,RestClient,RESTResponseDataSetAdapter.
You can use it give an url and get data with rootelement.

## usage

```pascal
var 
Client:ICustomClient;
```

## Usage

```pascal
Client:=TCustomClient.Createrequest('BaseURL').Get;
```

or Get response with a root element
```pascal
Client:=TCustomClient.Createrequest('BaseURL').Get('datas')
```
To assign fdmemtable to TRestResponseDataSetAdapter
```pascal
Client.Dataset := FDMemTable1;
```

Finally execute
```pascal
Client.ExecuteRequest;
```
# 
You can see response as table in fdmemtable...
