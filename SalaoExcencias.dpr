program SalaoExcencias;

uses
  Vcl.Forms,
  uView.Principal in 'View\uView.Principal.pas' {FrmPrincipal},
  uView.Login in 'View\uView.Login.pas' {FrmLogin},
  uDao.Dm in 'Dao\uDao.Dm.pas' {DataModule1: TDataModule},
  uView.CadastroDeClientes in 'View\uView.CadastroDeClientes.pas' {FrmCadastroDeClientes},
  uModel.Cliente in 'Model\uModel.Cliente.pas',
  uController.Cliente in 'Controller\uController.Cliente.pas',
  Vcl.Themes,
  Vcl.Styles,
  uInterfaces.ClienteController in 'Interfaces\uInterfaces.ClienteController.pas',
  uView.Configuracao in 'View\uView.Configuracao.pas' {FrmConfiguracao},
  uModel.Categoria in 'Model\uModel.Categoria.pas',
  uInterfaces.CategoriasController in 'Interfaces\uInterfaces.CategoriasController.pas',
  uInterfaces.FotoProcedimentoController in 'Interfaces\uInterfaces.FotoProcedimentoController.pas',
  uModel.FotoProcedimento in 'Model\uModel.FotoProcedimento.pas',
  uInterfaces.ProcedimentoController in 'Interfaces\uInterfaces.ProcedimentoController.pas',
  uModel.Procedimento in 'Model\uModel.Procedimento.pas',
  uInterfaces.ServicoController in 'Interfaces\uInterfaces.ServicoController.pas',
  uModel.Servico in 'Model\uModel.Servico.pas',
  uDAO.Cliente in 'Dao\uDAO.Cliente.pas',
  uDAO.Categoria in 'Dao\uDAO.Categoria.pas',
  uDAO.Servico in 'Dao\uDAO.Servico.pas',
  uDAO.Procedimento in 'Dao\uDAO.Procedimento.pas',
  uView.CadastroCategorias in 'View\uView.CadastroCategorias.pas' {FrmCadastroCategorias},
  uController.Categoria in 'Controller\uController.Categoria.pas',
  uDAO.FotoProcedimento in 'Dao\uDAO.FotoProcedimento.pas',
  uView.CadastroDeServicos in 'View\uView.CadastroDeServicos.pas' {FrmCadastrodeServicos},
  uController.Servico in 'Controller\uController.Servico.pas',
  uController.Procedimento in 'Controller\uController.Procedimento.pas',
  uView.FotoProcedimento in 'View\uView.FotoProcedimento.pas' {FrmFotoProcedimento},
  uController.FotoProcedimento in 'Controller\uController.FotoProcedimento.pas',
  uView.FotoAmpliada in 'View\uView.FotoAmpliada.pas' {FrmFotoAmpliada},
  uSessao in 'Infraestrutura\uSessao.pas',
  uConstantes in 'Core\uConstantes.pas',
  uView.CadastroDeProcedimento in 'View\uView.CadastroDeProcedimento.pas' {FrmCadastroProcedimento};

//  Vcl.Themes,
//  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmCadastroDeClientes, FrmCadastroDeClientes);
  Application.CreateForm(TFrmConfiguracao, FrmConfiguracao);
  Application.CreateForm(TFrmCadastroCategorias, FrmCadastroCategorias);
  Application.CreateForm(TFrmCadastrodeServicos, FrmCadastrodeServicos);
  Application.CreateForm(TFrmFotoProcedimento, FrmFotoProcedimento);
  Application.CreateForm(TFrmFotoAmpliada, FrmFotoAmpliada);
  Application.CreateForm(TFrmCadastroProcedimento, FrmCadastroProcedimento);
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
