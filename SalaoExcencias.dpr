program SalaoExcencias;

uses
  Vcl.Forms,
  uView.Principal in 'View\uView.Principal.pas' {FrmPrincipal},
  uView.Login in 'View\uView.Login.pas' {FrmLogin},
  uDao.Dm in 'Dao\uDao.Dm.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  // Cria manualmente a tela de login e exibe como modal
  FrmLogin := TFrmLogin.Create(nil);
  try
    if FrmLogin.ShowModal = 1 then
    begin
      Application.CreateForm(TFrmPrincipal, FrmPrincipal);
      Application.Run;
    end
    else
      Application.Terminate;
  finally
    FrmLogin.Free;
  end;
end.
