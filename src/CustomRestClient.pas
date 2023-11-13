unit CustomRestClient;

interface

uses
   REST.Client, REST.Response.Adapter, FireDAC.Comp.Client, System.Bindings.EvalProtocol, REST.Types, Classes, JSON,
   System.Generics.Collections, Dialogs, System.SysUtils,IpPeerClient;

type
   ICustomClient = interface
      ['{C9CCDDA4-B71B-4243-8989-A92C04861B92}']
      function GetClient: TRESTClient;
      procedure SetClient(const Value: TRESTClient);
      function GetRequest: TRESTRequest;
      procedure SetRequest(const Value: TRESTRequest);
      function GetResponse: TRESTResponse;
      procedure SetResponse(const Value: TRESTResponse);
      function GetDataset: TFDMemTable;
      procedure SetDataset(const Value: TFDMemTable);
      function GetBaseURL: string;
      procedure SetBaseURL(const Value: string);
      function Get(RootElement: string = string.Empty): ICustomClient;
      function AddResource(EndPoint: string): ICustomClient;
      property BaseURL: string read GetBaseURL write SetBaseURL;
      property Client: TRESTClient read GetClient write SetClient;
      property Request: TRESTRequest read GetRequest write SetRequest;
      property Response: TRESTResponse read GetResponse write SetResponse;
      property Dataset: TFDMemTable read GetDataset write SetDataset;
      function ExecuteRequest: ICustomClient;

   end;

   TCustomClient = class(TInterfacedObject, ICustomClient)
   strict protected
      fRestClient: TRESTClient;
      fRestRequest: TRESTRequest;
      fRestResponse: TRESTResponse;
      fRestDatasetAdapter: TRESTResponseDataSetAdapter;
      fDataset: TFDMemTable;
      fbaseURL: string;
      fResponseData: TStrings;
      function GetClient: TRESTClient;
      procedure SetClient(const Value: TRESTClient);
      function GetRequest: TRESTRequest;
      procedure SetRequest(const Value: TRESTRequest);
      function GetResponse: TRESTResponse;
      procedure SetResponse(const Value: TRESTResponse);

      function GetBaseURL: string;
      procedure SetBaseURL(const Value: string);
      function Get(RootElement: string = string.Empty): ICustomClient;
      function AddResource(EndPoint: string): ICustomClient;
      property BaseURL: string read GetBaseURL write SetBaseURL;
      property Client: TRESTClient read GetClient write SetClient;
      property Request: TRESTRequest read GetRequest write SetRequest;
      property Response: TRESTResponse read GetResponse write SetResponse;

   private
      function GetDataset: TFDMemTable;
      procedure SetDataset(const Value: TFDMemTable);
   public
      property Dataset: TFDMemTable read GetDataset write SetDataset;
      constructor Create(BaseURL: string);
      destructor Destroy; override;
      class function CreateRequest(BaseURL: string): ICustomClient;
      function ExecuteRequest: ICustomClient;

   end;

implementation

{ TCustomRestClient }

function FindJSONValue(const AJSON: TJSONValue; const APath: string): TJSONValue;
var
   LCurrentValue: TJSONValue;
   LParser: TJSONPathParser;
   LError: Boolean;
begin
   LParser := TJSONPathParser.Create(APath);
   try
      LCurrentValue := AJSON;
      LError := False;
      while (not LParser.IsEof) and (not LError) do
      begin
         case LParser.NextToken of
            TJSONPathParser.TToken.Name:
               begin
                  if LCurrentValue is TJSONObject then
                  begin
                     if LCurrentValue = nil then
                        Exit(nil);
                     LCurrentValue := TJSONObject(LCurrentValue).Values[LParser.TokenName];
                     if LCurrentValue = nil then
                        LError := True;
                  end
                  else
                     LError := True;
               end;
            TJSONPathParser.TToken.ArrayIndex:
               begin
                  if LCurrentValue is TJSONArray then
                     if LParser.TokenArrayIndex < TJSONArray(LCurrentValue).Count then
                        LCurrentValue := TJSONArray(LCurrentValue).Items[LParser.TokenArrayIndex]
                     else
                        LError := True
                  else
                     LError := True
               end;
            TJSONPathParser.TToken.Error:
               LError := True;
         else
            Assert(LParser.Token = TJSONPathParser.TToken.Eof); // case statement is not complete
         end;
      end;

      if LParser.IsEof and not LError then
         Result := LCurrentValue
      else
         Result := nil;

   finally
      LParser.Free;
   end;
end;

function TCustomClient.AddResource(EndPoint: string): ICustomClient;
begin
   Self.fRestRequest.Resource := EndPoint;
   Result := Self;
end;

constructor TCustomClient.Create(BaseUrl: string);
begin
   fRestClient := TRESTClient.Create(BaseUrl);
   fRestResponse := TRESTResponse.Create(fRestClient);
   fRestRequest := TRESTRequest.Create(fRestClient);
   fRestRequest.Client := fRestClient;
   fRestRequest.Response := fRestResponse;
   fRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
   fRestRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
   fRestDatasetAdapter := TRESTResponseDataSetAdapter.Create(fRestClient);
   fRestDatasetAdapter.ResponseJSON := fRestResponse;
   fResponseData := TStringList.Create;
end;

class function TCustomClient.CreateRequest(BaseUrl: string): ICustomClient;
begin
   Result := TCustomClient.Create(BaseUrl);
end;

destructor TCustomClient.Destroy;
begin
   fResponseData.Free;
   fRestClient.Free;
   inherited Destroy;
end;

function TCustomClient.ExecuteRequest: ICustomClient;
begin
   Self.fRestRequest.Execute;
   fResponseData.Clear;
   Result := Self;
end;

function TCustomClient.Get(RootElement: string = string.Empty): ICustomClient;
begin
   Request.Method := rmGET;
   Response.RootElement := RootElement;
   Result := Self;
end;

function TCustomClient.GetBaseURL: string;
begin
   Result := fbaseURL;
end;

function TCustomClient.GetClient: TRESTClient;
begin
   Result := fRestClient;
end;

function TCustomClient.GetDataset: TFDMemTable;
begin
   Result := fDataset;
end;

function TCustomClient.GetRequest: TRESTRequest;
begin
   Result := fRestRequest;
end;

function TCustomClient.GetResponse: TRESTResponse;
begin
   Result := fRestResponse;
end;



procedure TCustomClient.SetBaseURL(const Value: string);
begin
   fbaseURL := Value;
end;

procedure TCustomClient.SetClient(const Value: TRESTClient);
begin
   fRestClient := Value;
end;

procedure TCustomClient.SetDataset(const Value: TFDMemTable);
begin
   fDataset := Value;
   fRestDatasetAdapter.Dataset := fDataset;
end;

procedure TCustomClient.SetRequest(const Value: TRESTRequest);
begin
   fRestRequest := Value;
end;

procedure TCustomClient.SetResponse(const Value: TRESTResponse);
begin
   fRestResponse := Value;
end;



end.

