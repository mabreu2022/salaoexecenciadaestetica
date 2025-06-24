object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\FONTES\salaoexecencias\database\SALAOEXECENCIAS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\FONTES\salaoexecencias\Dao\fbclient.dll'
    Left = 224
    Top = 56
  end
  object FDQueryClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT '
      '  IDCLIENTE,'
      '  NOME,'
      '  TELEFONE,'
      '  EMAIL,'
      '  DATACADASTRO,'
      '  ENDERECO,'
      '  NUMERO,'
      '  COMPLEMENTO,'
      '  CEP'
      'FROM CLIENTES'
      'ORDER BY NOME')
    Left = 88
    Top = 168
  end
  object FDQqueryFotoProcedimento: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT'
      '  FP.IDFOTO,'
      '  FP.IDPROCEDIMENTO,'
      '  FP.CAMINHOARQUIVO,'
      '  FP.IMAGEM,'
      '  FP.DATAINCLUSAO'
      'FROM'
      '  FOTOSPROCEDIMENTO FP'
      'WHERE'
      '  FP.IDPROCEDIMENTO = :IDPROCEDIMENTO'
      'ORDER BY'
      '  FP.DATAINCLUSAO DESC')
    Left = 88
    Top = 232
    ParamData = <
      item
        Name = 'IDPROCEDIMENTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryProcedimentos: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT '
      '  P.IDPROCEDIMENTO,'
      '  P.IDCLIENTE,'
      '  P.IDSERVICO,'
      '  S.NOME AS NOMESERVICO,'
      '  P.DATAHORA,'
      '  P.OBSERVACOES,'
      '  P.CONCLUIDO,'
      '  P.ATIVO'
      'FROM '
      '  PROCEDIMENTOS P'
      'JOIN '
      '  SERVICOS S ON S.IDSERVICO = P.IDSERVICO'
      'WHERE '
      '  P.IDCLIENTE = :IDCLIENTE'
      'ORDER BY '
      '  S.NOME;')
    Left = 88
    Top = 296
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQuery4: TFDQuery
    Connection = FDConnection1
    Left = 88
    Top = 368
  end
  object DSClientes: TDataSource
    DataSet = FDQueryClientes
    Left = 216
    Top = 168
  end
  object dsFotoProcedimento: TDataSource
    DataSet = FDQqueryFotoProcedimento
    Left = 216
    Top = 232
  end
  object dsProcedimentos: TDataSource
    DataSet = qryProcedimentos
    Left = 216
    Top = 296
  end
  object DataSource4: TDataSource
    Left = 216
    Top = 368
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 352
    Top = 56
  end
end
