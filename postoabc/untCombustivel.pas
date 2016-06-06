unit untCombustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.FMTBcd, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Data.DB, Datasnap.Provider, Datasnap.DBClient,
  Data.SqlExpr;

type
  TfrmCombustivel = class(TForm)
    Image1: TImage;
    pcCadastro: TPageControl;
    tbsLista: TTabSheet;
    tbsCadastro: TTabSheet;
    dbgLista: TDBGrid;
    dsCombustivel: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Panel1: TPanel;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnCancelar: TBitBtn;
    btnConfirmar: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsCombustivelDataChange(Sender: TObject; Field: TField);
    procedure btnFecharClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgListaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure tratarBotoes(isEdicao: boolean);
  end;

var
  frmCombustivel: TfrmCombustivel;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmCombustivel.btnAlterarClick(Sender: TObject);
begin
   dm.cdsCombustivel.Edit;
end;

procedure TfrmCombustivel.btnCancelarClick(Sender: TObject);
begin
   dm.cdsCombustivel.CancelUpdates;
end;

procedure TfrmCombustivel.btnConfirmarClick(Sender: TObject);
begin
   dm.salvar(dm.cdsCombustivel);

   pcCadastro.ActivePageIndex := 0;
end;

procedure TfrmCombustivel.btnExcluirClick(Sender: TObject);
begin
   dm.cdsTanque.Open;
   try

     if dm.cdsTanque.Locate('ID_COMBUSTIVEL', dm.cdsCombustivelID_COMBUSTIVEL.AsInteger, []) then
        MessageDlg('Antes de excluir esse Combustível você deve desviculá-lo do Tanque '+dm.cdsTanqueID_TANQUE.AsString+'.', mtWarning, [mbOk],0)
     else dm.cdsCombustivel.Delete;

   finally
      dm.cdsTanque.Close;
   end;
end;

procedure TfrmCombustivel.btnFecharClick(Sender: TObject);
begin
   close;
end;

procedure TfrmCombustivel.btnInserirClick(Sender: TObject);
begin
   dm.cdsCombustivel.Insert;
end;

procedure TfrmCombustivel.dbgListaDblClick(Sender: TObject);
begin
   pcCadastro.ActivePageIndex := 1;
end;

procedure TfrmCombustivel.dsCombustivelDataChange(Sender: TObject;
  Field: TField);
begin
   tratarBotoes(dm.cdsCombustivel.State in [dsEdit, dsInsert]);
end;

procedure TfrmCombustivel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   dm.cdsCombustivel.Close;
end;

procedure TfrmCombustivel.FormShow(Sender: TObject);
begin
   dm.cdsCombustivel.Open;

   pcCadastro.ActivePageIndex := 0;
end;

procedure TfrmCombustivel.tratarBotoes(isEdicao: boolean);
begin

   btnInserir.Enabled := not isEdicao;
   btnAlterar.Enabled := not isEdicao;
   btnExcluir.Enabled := not isEdicao;
   btnConfirmar.Enabled := isEdicao;
   btnCancelar.Enabled := isEdicao;

   if isEdicao then
      pcCadastro.ActivePageIndex := 1
   else pcCadastro.ActivePageIndex := 0;

end;

end.
