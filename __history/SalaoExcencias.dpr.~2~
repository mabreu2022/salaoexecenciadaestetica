program SalaoExcencias;

uses
  Vcl.Forms,
  uView.Principal in 'View\uView.Principal.pas' {Form1},
  uView.Login in 'View\uView.Login.pas' {FrmLogin},
  uDm in 'Dao\uDm.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
