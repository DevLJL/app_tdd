unit uProduct.Repository.Interfaces;

interface

uses
  uProduct,
  uIndexResult;

type
  IProductRepository = Interface
    ['{1B2F90CC-B81D-486F-BA41-CF1452715DD1}']
    function Store(const AEntity: TProduct): Int64;
    procedure Delete(const AId: Int64);
    function Show(const AId: Int64): TProduct;
    function Update(const AEntity: TProduct; const AId: Int64): Int64;
    function Index: IIndexResult;
  End;

implementation

end.
