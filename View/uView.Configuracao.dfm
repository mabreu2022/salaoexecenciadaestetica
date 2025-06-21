object FrmConfiguracao: TFrmConfiguracao
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Configuracao'
  ClientHeight = 316
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object lblServidor: TLabel
    Left = 8
    Top = 17
    Width = 43
    Height = 15
    Caption = 'Servidor'
  end
  object Label2: TLabel
    Left = 8
    Top = 49
    Width = 28
    Height = 15
    Caption = 'Porta'
  end
  object Label3: TLabel
    Left = 8
    Top = 81
    Width = 102
    Height = 15
    Caption = 'Caminho do Banco'
  end
  object Label4: TLabel
    Left = 8
    Top = 113
    Width = 40
    Height = 15
    Caption = 'Usu'#225'rio'
  end
  object Label5: TLabel
    Left = 8
    Top = 145
    Width = 32
    Height = 15
    Caption = 'Senha'
  end
  object Label6: TLabel
    Left = 8
    Top = 177
    Width = 41
    Height = 15
    Caption = 'CharSet'
  end
  object lblMaximoConexoes: TLabel
    Left = 8
    Top = 249
    Width = 94
    Height = 15
    Caption = 'MaximoConexoes'
  end
  object edtServidor: TEdit
    Left = 128
    Top = 14
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object edtPorta: TEdit
    Left = 128
    Top = 46
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object edtDatabase: TEdit
    Left = 128
    Top = 78
    Width = 213
    Height = 23
    TabOrder = 2
  end
  object edtUsuario: TEdit
    Left = 128
    Top = 110
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object edtSenha: TEdit
    Left = 128
    Top = 142
    Width = 121
    Height = 23
    TabOrder = 4
  end
  object edtCharSet: TEdit
    Left = 128
    Top = 174
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'UTF8'
  end
  object chkPooling: TCheckBox
    Left = 128
    Top = 214
    Width = 121
    Height = 17
    Caption = 'Pool de Conexao '
    TabOrder = 6
  end
  object edtMAximoConexoes: TEdit
    Left = 128
    Top = 246
    Width = 121
    Height = 23
    TabOrder = 7
  end
  object Panel1: TPanel
    Left = 0
    Top = 275
    Width = 349
    Height = 41
    Align = alBottom
    TabOrder = 8
    ExplicitLeft = 104
    ExplicitTop = 392
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 266
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
end
