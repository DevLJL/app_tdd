unit uProduct.Controller;

interface

uses
  uProduct.Controller.Interfaces,
  uProduct.DTO,
  uEither,
  uProduct.Repository.Interfaces,
  uIndexResult;

type
  TProductController = class(TInterfacedObject, IProductController)
  private
    FRepository: IProductRepository;
    constructor Create;
  public
    class function Make: IProductController;
    function  Store(const AInput: TProductDTO): Either<String, Int64>;
    procedure Delete(const AId: Int64);
    function  Show(const AId: Int64): TProductDTO;
    function  Update(const AInput: TProductDTO; const AId: Int64): Either<String, Int64>;
    function  Index: IIndexResult;
  end;

implementation

uses
  uRepository.Factory,
  uProduct.Store.UseCase,
  uApplication.Exception,
  uProduct.Delete.UseCase,
  uProduct.Show.UseCase,
  uProduct.Update.UseCase,
  uProduct.Index.UseCase;

{ TProductController }

constructor TProductController.Create;
begin
  inherited Create;
  FRepository := TRepositoryFactory.Make.Product;
end;

procedure TProductController.Delete(const AId: Int64);
begin
  TProductDeleteUseCase.Make(FRepository).Execute(AId);
end;

function TProductController.Index: IIndexResult;
begin
  Result := TProductIndexUseCase.Make(FRepository).Execute;
end;

class function TProductController.Make: IProductController;
begin
  Result := Self.Create;
end;

function TProductController.Show(const AId: Int64): TProductDTO;
begin
  Result := TProductShowUseCase.Make(FRepository).Execute(AId);
end;

function TProductController.Store(const AInput: TProductDTO): Either<String, Int64>;
begin
  try
    Result := TProductStoreUseCase.Make(FRepository).Execute(AInput);
  except
    on E: EEntityValidationException do
      Result := E.Message
    else
      raise;
  end;
end;

function TProductController.Update(const AInput: TProductDTO; const AId: Int64): Either<String, Int64>;
begin
  try
    Result := TProductUpdateUseCase.Make(FRepository).Execute(AInput, AId);
  except
    on E: EEntityValidationException do
      Result := E.Message
    else
      raise;
  end;
end;

end.
