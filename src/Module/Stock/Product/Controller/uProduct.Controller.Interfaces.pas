unit uProduct.Controller.Interfaces;

interface

uses
  uProduct.DTO,
  uEither,
  uIndexResult;

type
  IProductController = Interface
    ['{BBE5F2F2-70E9-4F25-BD75-E9BCB35829E3}']
    function  Store(const AInput: TProductDTO): Either<String, Int64>;
    function  Update(const AInput: TProductDTO; const AId: Int64): Either<String, Int64>;
    procedure Delete(const AId: Int64);
    function  Show(const AId: Int64): TProductDTO;
    function  Index: IIndexResult;
  End;

implementation

end.
