unit uMain;

interface

uses
   winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
   Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   Vcl.Grids, Vcl.DBGrids, CustomRestClient;

type
   TfrmMain = class(TForm)
      DBGrid1: TDBGrid;
      DataSource1: TDataSource;
      FDMemTable1: TFDMemTable;
      edtUrl: TEdit;
      btnExecute: TButton;
      procedure btnExecuteClick(Sender: TObject);
   private
    { Private declarations }
   public
      fCustomRestClient: ICustomClient;
   end;

var
   frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnExecuteClick(Sender: TObject);
begin
   // You can get custom root element
   //fCustomRestClient := TCustomClient.Createrequest(edtUrl.Text).Get('products');
   fCustomRestClient := TCustomClient.Createrequest(edtUrl.Text).Get('products');
   //Assign data to fdmemtable from response data
   fCustomRestClient.Dataset := FDMemTable1;

   fCustomRestClient.ExecuteRequest;
end;

end.

