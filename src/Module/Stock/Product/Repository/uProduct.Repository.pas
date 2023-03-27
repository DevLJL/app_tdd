unit uProduct.Repository;

interface

uses
  uProduct.Repository.Interfaces,
  uProduct,
  uZLConnection.Interfaces,
  uIndexResult;

type
  TProductRepository = class(TInterfacedObject, IProductRepository)
  private
    FConn: IZLConnection;
    constructor Create(const AConn: IZLConnection);
  public
    class function Make(const AConn: IZLConnection): IProductRepository;
    function Store(const AEntity: TProduct): Int64;
    procedure Delete(const AId: Int64);
    function Show(const AId: Int64): TProduct;
    function Update(const AEntity: TProduct; const AId: Int64): Int64;
    function Index: IIndexResult;
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uProduct.Mapper,
  uMemTable.Factory;

{ TProductRepository }

constructor TProductRepository.Create(const AConn: IZLConnection);
begin
  inherited Create;
  FConn := AConn;
end;

procedure TProductRepository.Delete(const AId: Int64);
const
  L_DELETE_SQL = ' DELETE FROM product '+
                 ' WHERE product.id = %s ';
begin
  FConn.MakeQry.ExecSQL(Format(L_DELETE_SQL, [QuotedStr(AId.ToString)]));
end;

function TProductRepository.Index: IIndexResult;
const
  L_SELECT_ALL_SQL = ' SELECT '+
                     '   product.* '+
                     ' FROM '+
                     '   product ';
begin
  Result := TIndexResult.Make
    .Data(TMemTableFactory.Make.FromDataSet(FConn.MakeQry.Open(L_SELECT_ALL_SQL).DataSet));
end;

class function TProductRepository.Make(const AConn: IZLConnection): IProductRepository;
begin
  Result := Self.Create(AConn);
end;

function TProductRepository.Show(const AId: Int64): TProduct;
const
  L_SELECT_BY_ID_SQL = ' SELECT '+
                       '   product.* '+
                       ' FROM '+
                       '   product '+
                       ' WHERE '+
                       '   product.id = %s';
begin
  Result := TProductMapper.DataSetToEntity(
    FConn.MakeQry.Open(Format(L_SELECT_BY_ID_SQL, [QuotedStr(AId.ToString)])).DataSet
  );
end;

function TProductRepository.Store(const AEntity: TProduct): Int64;
const
  L_INSERT_SQL = ' INSERT INTO product '+
                 '   (id, name, price, note) '+
                 ' VALUES '+
                 '   (%s, %s, %s, %s)';
  LAST_INSER_ID_SQL = 'SELECT LAST_INSERT_ID()';
begin
  FConn.MakeQry.ExecSQL(Format(L_INSERT_SQL, [
    QuotedStr(AEntity.id.ToString),
    QuotedStr(AEntity.name),
    QuotedStr(Format('%.2f', [AEntity.price], TFormatSettings.Create('en-US'))),
    QuotedStr(AEntity.note)
  ]));

  Result := FConn.MakeQry.Open(LAST_INSER_ID_SQL).DataSet.Fields[0].AsLargeInt;
end;

function TProductRepository.Update(const AEntity: TProduct; const AId: Int64): Int64;
const
  L_UPDATE_SQL = ' UPDATE product '+
                 ' SET '+
                 '   name  = %s, '+
                 '   price = %s, '+
                 '   note  = %s  '+
                 ' WHERE '+
                 '   product.id = %s';
begin
  FConn.MakeQry.ExecSQL(Format(L_UPDATE_SQL, [
    QuotedStr(AEntity.name),
    QuotedStr(Format('%.2f', [AEntity.price], TFormatSettings.Create('en-US'))),
    QuotedStr(AEntity.note),
    QuotedStr(AId.ToString)
  ]));

  Result := AId;
end;

end.
