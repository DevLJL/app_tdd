unit uProduct.Store.UseCase;

interface

uses
  uProduct.DTO,
  uEither,
  uProduct.Repository.Interfaces;

type
  IProductStoreUseCase = Interface
    ['{2254030F-7715-4EE6-A7C1-50752EF91DBF}']
    function Execute(const AInput: TProductDTO): Either<String, Int64>;
  End;

  TProductStoreUseCase = class(TInterfacedObject, IProductStoreUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(const ARepository: IProductRepository);
  public
    class function Make(const ARepository: IProductRepository): IProductStoreUseCase;
    function Execute(const AInput: TProductDTO): Either<String, Int64>;
  end;

implementation

{ TProductStoreUseCase }

uses
  uEntityValidation.Exception,
  uProduct,
  uProduct.Mapper,
  System.SysUtils,
  uSmartPointer;

constructor TProductStoreUseCase.Create(const ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductStoreUseCase.Execute(const AInput: TProductDTO): Either<String, Int64>;
var
  lProduct: Shared<TProduct>;
  lErrors: String;
begin
  lProduct := TProductMapper.DTOToEntity(AInput);
  lErrors  := lProduct.Value.Validate;
  if not lErrors.Trim.IsEmpty then
    raise TEntityValidationException.Create(lErrors);

  Result := FRepository.Store(lProduct);
end;

class function TProductStoreUseCase.Make(const ARepository: IProductRepository): IProductStoreUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
