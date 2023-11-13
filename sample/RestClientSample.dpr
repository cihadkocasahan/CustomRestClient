program RestClientSample;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  CustomRestClient in '..\src\CustomRestClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
