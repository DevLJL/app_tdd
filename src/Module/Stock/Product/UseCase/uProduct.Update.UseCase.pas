unit uProduct.Update.UseCase;

interface

uses
  uProduct.DTO,
  uEither,
  uProduct.Repository.Interfaces;

type
  IProductUpdateUseCase = Interface
    ['{A1A63F79-A014-4301-924F-4EB2878E966C}']
    function Execute(const AInput: TProductDTO; const AId: Int64): Either<String, Int64>;
  End;

  TProductUpdateUseCase = class(TInterfacedObject, IProductUpdateUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(const ARepository: IProductRepository);
  public
    class function Make(const ARepository: IProductRepository): IProductUpdateUseCase;
    function Execute(const AInput: TProductDTO; const AId: Int64): Either<String, Int64>;
  end;

implementation

{ TProductUpdateUseCase }

uses
  uEntityValidation.Exception,
  uProduct,
  uProduct.Mapper,
  System.SysUtils,
  uSmartPointer;

constructor TProductUpdateUseCase.Create(const ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductUpdateUseCase.Execute(const AInput: TProductDTO; const AId: Int64): Either<String, Int64>;
var
  lProduct: Shared<TProduct>;
  lErrors: String;
begin
  lProduct := TProductMapper.DTOToEntity(AInput);
  lErrors  := lProduct.Value.Validate;
  if not lErrors.Trim.IsEmpty then
    raise TEntityValidationException.Create(lErrors);

  Result := FRepository.Update(lProduct, AId);
end;

class function TProductUpdateUseCase.Make(const ARepository: IProductRepository): IProductUpdateUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
