program postoABC;

uses
  Vcl.Forms,
  untDM in 'untDM.pas' {dm: TDataModule},
  untHome in 'untHome.pas' {frmHome},
  untCombustivel in 'untCombustivel.pas' {frmCombustivel},
  untTanque in 'untTanque.pas' {frmTanque},
  untBomba in 'untBomba.pas' {frmBomba},
  untAbastecimento in 'untAbastecimento.pas' {frmAbastecimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmAbastecimento, frmAbastecimento);
  Application.Run;
end.
