unit uProduct;

interface

uses
  uBase.Entity;

type
  TProduct = class(TBaseEntity)
  private
    Fname: String;
    Fid: Int64;
    Fnote: String;
    Fprice: Double;
  public
    property id: Int64 read Fid write Fid;
    property name: String read Fname write Fname;
    property price: Double read Fprice write Fprice;
    property note: String read Fnote write Fnote;

    function Validate: String; override;
  end;

implementation

{ TProduct }

uses
  System.SysUtils,
  uTrans;

function TProduct.Validate: String;
begin
  Result := EmptyStr;

  if Fname.Trim.IsEmpty then
    Result := Result + Trans.FieldIsRequired('Nome') + #13;

  if (Fprice < 0) then
    Result := Result + Trans.NumberIsLessThan('Preço', Fprice.ToString) + #13;
end;

end.
