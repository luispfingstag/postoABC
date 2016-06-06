unit untBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.FMTBcd, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Data.DB, Datasnap.Provider, Datasnap.DBClient,
  Data.SqlExpr, Vcl.DBLookup;

type
  TfrmBomba = class(TForm)
    Image1: TImage;
    pcCadastro: TPageControl;
    tbsLista: TTabSheet;
    tbsCadastro: TTabSheet;
    dbgLista: TDBGrid;
    dsbomba: TDataSource;
    Panel1: TPanel;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnCancelar: TBitBtn;
    btnConfirmar: TBitBtn;
    btnFechar: TBitBtn;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label3: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure dsbombaDataChange(Sender: TObject; Field: TField);
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
  frmBomba: TfrmBomba;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmBomba.btnAlterarClick(Sender: TObject);
begin
   dm.cdsBomba.Edit;
end;

procedure TfrmBomba.btnCancelarClick(Sender: TObject);
begin
   dm.cdsBomba.CancelUpdates;
end;

procedure TfrmBomba.btnConfirmarClick(Sender: TObject);
begin
   dm.salvar(dm.cdsBomba);

   pcCadastro.ActivePageIndex := 0;
end;

procedure TfrmBomba.btnExcluirClick(Sender: TObject);
begin
   dm.cdsAbastecimento.Open;
   try

     if dm.cdsAbastecimento.Locate('ID_BOMBA', dm.cdsBombaID_BOMBA.AsInteger, []) then
        MessageDlg('Não é possível excluir Bomba com movimentação!', mtWarning, [mbOk],0)
     else dm.cdsBomba.Delete;

   finally
      dm.cdsAbastecimento.close;
   end;
end;

procedure TfrmBomba.btnFecharClick(Sender: TObject);
begin
   close;
end;

procedure TfrmBomba.btnInserirClick(Sender: TObject);
begin
   dm.cdsBomba.Insert;
end;


procedure TfrmBomba.dbgListaDblClick(Sender: TObject);
begin
   pcCadastro.ActivePageIndex := 1;
end;

procedure TfrmBomba.dsbombaDataChange(Sender: TObject;
  Field: TField);
begin
   tratarBotoes(dm.cdsBomba.State in [dsEdit, dsInsert]);
end;

procedure TfrmBomba.FormShow(Sender: TObject);
begin
   pcCadastro.ActivePageIndex := 0;
end;

procedure TfrmBomba.tratarBotoes(isEdicao: boolean);
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
