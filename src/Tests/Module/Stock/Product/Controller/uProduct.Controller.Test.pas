unit uProduct.Controller.Test;

interface

uses
  TestFramework,
  uProduct.Controller.Interfaces,
  uProduct.DTO;

type
  TProductControllerTest = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  private
    FController: IProductController;
    function GenerateProductDTO: TProductDTO;
  published
    procedure Store;
    procedure Update;
    procedure Delete;
    procedure Show;
    procedure Index;
  end;

implementation

uses
  uController.Factory,
  uEither,
  uHlp,
  System.SysUtils,
  uConnection.Factory,
  uIndexResult,
  uTrans,
  uSmartPointer,
  REST.Json;

{ TProductControllerTest }

procedure TProductControllerTest.Delete;
var
  lInput: Shared<TProductDTO>;
  lFound: Shared<TProductDTO>;
  lStoredId: Either<String, Int64>;
begin
  lInput    := Self.GenerateProductDTO;
  lStoredId := FController.Store(lInput);
  if not lStoredId.Match then
    raise Exception.Create(Trans.DataInsertionFailure);

  FController.Delete(lStoredId.Right);

  lFound := FController.Show(lStoredId.Right);
  Check(not Assigned(lFound.Value));
end;

function TProductControllerTest.GenerateProductDTO: TProductDTO;
begin
  Result       := TProductDTO.Create;
  Result.name  := 'Produto: ' + NextUUID;
  Result.price := Random(10000);
  Result.note  := 'Observação: ' + NextUUID;
end;

procedure TProductControllerTest.Index;
const
  L_DELETE_ALL = 'delete from product';
var
  lInput: Shared<TProductDTO>;
  lI: Integer;
  lIndexResult: IIndexResult;
begin
  try
    for lI := 1 to 10 do
    begin
      lInput := Self.GenerateProductDTO;
      if not FController.Store(lInput).Match then
        raise Exception.Create(Trans.DataInsertionFailure);
    end;

    lIndexResult := FController.Index;
    Check(lIndexResult.Data.DataSet.RecordCount = 10);
  finally
    // Limpar dados
    TConnectionFactory.Make.MakeQry.ExecSQL(L_DELETE_ALL);
  end;
end;

procedure TProductControllerTest.SetUp;
begin
  inherited;
  FController := TControllerFactory.Product;
end;

procedure TProductControllerTest.Show;
var
  lStoredId: Either<String, Int64>;
  lInput: Shared<TProductDTO>;
  lOutPut: Shared<TProductDTO>;
  lAux: String;
begin
  lInput    := Self.GenerateProductDTO;
  lStoredId := FController.Store(lInput);
  if not lStoredId.Match then
    raise Exception.Create(Trans.DataInsertionFailure);

  lOutPut := FController.Show(lStoredId.Right);
  lInput.Value.id := lStoredId.Right;
  Check(TJson.ObjectToJsonString(lOutPut) = TJson.ObjectToJsonString(lInput));

  // Limpar dados
  FController.Delete(lStoredId.Right);
end;

procedure TProductControllerTest.Store;
var
  lInput: Shared<TProductDTO>;
  lStoredId: Either<String, Int64>;
begin
  lInput    := Self.GenerateProductDTO;
  lStoredId := FController.Store(lInput);
  if not lStoredId.Match then
    Check(false, lStoredId.Left);

  // Limpar dados
  FController.Delete(lStoredId.Right);
end;

procedure TProductControllerTest.TearDown;
const
  L_DELETE_ALL = 'delete from product';
begin
  inherited;
  TConnectionFactory.Make.MakeQry.ExecSQL(L_DELETE_ALL);
end;

procedure TProductControllerTest.Update;
var
  lStoredId: Either<String, Int64>;
  lInput: Shared<TProductDTO>;
  lInputUpdate: Shared<TProductDTO>;
  lFound: Shared<TProductDTO>;
begin
  lInput    := Self.GenerateProductDTO;
  lStoredId := FController.Store(lInput);
  if not lStoredId.Match then
    raise Exception.Create(Trans.DataInsertionFailure);

  lInputUpdate := Self.GenerateProductDTO;
  lStoredId := FController.Update(lInputUpdate.Value, lStoredId.Right);
  if not lStoredId.Match then
    Check(false, lStoredId.Left);

  lFound := FController.Show(lStoredId.Right);

  lInput.Value.id := lStoredId.Right;
  Check(lInput.Value.id = lFound.Value.id);
  Check(TJson.ObjectToJsonString(lFound) <> TJson.ObjectToJsonString(lInput));

  // Limpar dados
  FController.Delete(lFound.Value.id);
end;


initialization
  RegisterTest(TProductControllerTest.Suite);

end.
