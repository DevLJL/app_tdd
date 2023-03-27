unit uProduct.DTO;

interface

uses
  uBase.DTO;

type
  TProductDTO = class(TBaseDTO)
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
  end;

implementation

end.
