unit uView.CadastroDeProcedimento;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  uInterfaces.ProcedimentoController,
  uModel.Procedimento,
  uDAO.Cliente,
  uModel.Cliente,
  System.Generics.Collections;

type
  TFrmCadastroProcedimento = class(TForm)
    Panel1: TPanel;
    btnSalvar: TBitBtn;
    btnNovo: TBitBtn;
    btnEditar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    DBNavigator1: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label3: TLabel;
    Edit3: TEdit;
    btnPesquisar: TBitBtn;
    DBGrid1: TDBGrid;
    cbCliente: TDBLookupComboBox;
    cbProcedimento: TDBLookupComboBox;
    lblCliente: TLabel;
    lblProcedimento: TLabel;
    edtDataProcedimento: TDateTimePicker;
    memObservacoes: TMemo;
    btnAdicionaFotosdoProcedimento: TBitBtn;
    Label1: TLabel;
    lblDataDoProcedimento: TLabel;
    lblObservacoes: TLabel;
    chkConcluido: TCheckBox;
    btnCancelar: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
    FIDCliente: Integer;
    FController: IProcedimentoController;
    ProcedimentoSelecionadoID: Integer;
    ProcedimentoEmEdicaoID: Integer;
    FClienteDAO: TClienteDAO;

  public
    { Public declarations }
    procedure DefinirCliente(AIDCliente: Integer);
    procedure HabilitarEdicao(Ativo: Boolean);
    procedure LimparCampos;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;


  end;

var
  FrmCadastroProcedimento: TFrmCadastroProcedimento;

implementation

{$R *.dfm}

uses uDao.Dm, uController.Procedimento;

{ TFrmCadastroProcedimento }

procedure TFrmCadastroProcedimento.btnCancelarClick(Sender: TObject);
begin
  LimparCampos;
  HabilitarEdicao(False);
end;

procedure TFrmCadastroProcedimento.btnEditarClick(Sender: TObject);
var
  Procedimento: TProcedimento;
begin
  Procedimento := FController.BuscarPorID(ProcedimentoSelecionadoID);
  if Assigned(Procedimento) then
  begin
    cbCliente.KeyValue        := Procedimento.IDCLIENTE;
    cbProcedimento.KeyValue   := Procedimento.IDSERVICO;
    memObservacoes.Text       := Procedimento.OBSERVACOES.DataString;
    chkConcluido.Checked      := Procedimento.CONCLUIDO;

    ProcedimentoEmEdicaoID    := Procedimento.IDPROCEDIMENTO;

    HabilitarEdicao(True);
    cbCliente.SetFocus;
  end
  else
    MessageDlg('Procedimento não encontrado.', mtWarning, [mbOK], 0);

end;

procedure TFrmCadastroProcedimento.btnNovoClick(Sender: TObject);
begin
  FController.NovoProcedimento; // sinaliza intenção de novo cadastro

  cbCliente.KeyValue := Null;
  cbProcedimento.KeyValue := Null;
  memObservacoes.Clear;
  chkConcluido.Checked := False;

  cbCliente.SetFocus;
  HabilitarEdicao(True);

End;

procedure TFrmCadastroProcedimento.btnSalvarClick(Sender: TObject);
begin
  DataModule1.qryProcedimentos.FieldByName('IDCLIENTE').AsInteger := FIDCliente;
  btnAdicionaFotosdoProcedimento.Enabled:= True;
end;



constructor TFrmCadastroProcedimento.Create(AOwner: TComponent);
begin
  inherited;
  FClienteDAO := TClienteDAO.Create;
end;

procedure TFrmCadastroProcedimento.DBGrid1CellClick(Column: TColumn);
begin
  ProcedimentoSelecionadoID := DataModule1.qryProcedimentos.FieldByName('IDPROCEDIMENTO').AsInteger;
end;

procedure TFrmCadastroProcedimento.DefinirCliente(AIDCliente: Integer);
begin
  FIDCliente := AIDCliente;
end;

destructor TFrmCadastroProcedimento.Destroy;
begin
  FClienteDAO.Free;
  inherited;
end;

procedure TFrmCadastroProcedimento.FormCreate(Sender: TObject);
begin
  FController := TProcedimentoController.Create;
  FClienteDAO := TClienteDAO.Create;
end;

procedure TFrmCadastroProcedimento.FormShow(Sender: TObject);
begin
  DataModule1.FDQueryClientes.Open;
  DataModule1.qryProcedimentos.Open;
end;

procedure TFrmCadastroProcedimento.HabilitarEdicao(Ativo: Boolean);
begin
  cbCliente.Enabled := Ativo;
  cbProcedimento.Enabled := Ativo;
  memObservacoes.Enabled := Ativo;
  chkConcluido.Enabled := Ativo;
  btnSalvar.Enabled := Ativo;
  btnCancelar.Enabled := Ativo;
end;

procedure TFrmCadastroProcedimento.LimparCampos;
begin
  cbCliente.KeyValue := Null;
  cbProcedimento.KeyValue := Null;
  memObservacoes.Clear;
  chkConcluido.Checked := False;
end;


end.
