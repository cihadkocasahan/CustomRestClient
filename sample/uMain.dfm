object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Custom Rest Client Sample'
  ClientHeight = 560
  ClientWidth = 979
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 963
    Height = 506
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object edtUrl: TEdit
    Left = 8
    Top = 8
    Width = 833
    Height = 25
    TabOrder = 1
    Text = 'https://dummyjson.com/products'
  end
  object btnExecute: TButton
    Left = 848
    Top = 8
    Width = 123
    Height = 25
    Caption = 'Execute Request'
    TabOrder = 2
    OnClick = btnExecuteClick
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 680
    Top = 344
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 744
    Top = 344
  end
end
