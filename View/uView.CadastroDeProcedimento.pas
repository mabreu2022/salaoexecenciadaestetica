unit uView.CadastroDeProcedimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

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
    cbServico: TDBLookupComboBox;
    lblCliente: TLabel;
    lblServico: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FIDCliente: Integer;
  public
    { Public declarations }
    procedure DefinirCliente(AIDCliente: Integer);
  end;

var
  FrmCadastroProcedimento: TFrmCadastroProcedimento;

implementation

{$R *.dfm}

uses uDao.Dm;

{ TFrmCadastroProcedimento }

procedure TFrmCadastroProcedimento.btnSalvarClick(Sender: TObject);
begin
  DataModule1.qryProcedimentos.FieldByName('IDCLIENTE').AsInteger := FIDCliente;
end;

procedure TFrmCadastroProcedimento.DefinirCliente(AIDCliente: Integer);
begin
  FIDCliente := AIDCliente;
end;

procedure TFrmCadastroProcedimento.FormShow(Sender: TObject);
begin
  DataModule1.FDQueryClientes.Open;
end;

end.
