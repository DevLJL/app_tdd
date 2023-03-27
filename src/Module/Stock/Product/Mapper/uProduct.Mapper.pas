unit uProduct.Mapper;

interface

uses
  uProduct.DTO,
  uProduct,
  Data.DB,
  REST.Json,
  System.JSON,
  DataSetConverter4D,
  DataSetConverter4D.Impl;

type
  TProductMapper = class
  public
    class function DTOToEntity(const AInput: TProductDTO): TProduct;
    class function EntityToDTO(const AInput: TProduct): TProductDTO;
    class function DataSetToEntity(Const AInput: TDataSet): TProduct;
  end;

implementation

{ TProductMapper }

uses
  uSmartPointer;

class function TProductMapper.DataSetToEntity(const AInput: TDataSet): TProduct;
var
  lJO: Shared<TJSONObject>;
begin
  if AInput.IsEmpty then
  begin
    Result := nil;
    Exit;
  end;

  lJO    := TConverter.New.DataSet.Source(AInput).AsJSONObject;
  Result := TJson.JsonToObject<TProduct>(lJO.Value.ToString);
end;

class function TProductMapper.DTOToEntity(const AInput: TProductDTO): TProduct;
begin
  Result := TJson.JsonToObject<TProduct>(
    TJson.ObjectToJsonString(AInput)
  );
end;

class function TProductMapper.EntityToDTO(const AInput: TProduct): TProductDTO;
begin
  Result := TJson.JsonToObject<TProductDTO>(
    TJson.ObjectToJsonString(AInput)
  );
end;

end.
