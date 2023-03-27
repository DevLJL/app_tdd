program crud_test;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  uEnv in 'Shared\Environment\uEnv.pas',
  uSession.DTM in 'Shared\Config\uSession.DTM.pas' {SessionDTM: TDataModule},
  uProduct.Controller.Test in 'tests\Module\Stock\Product\Controller\uProduct.Controller.Test.pas',
  uProduct.Controller.Interfaces in 'Module\Stock\Product\Controller\uProduct.Controller.Interfaces.pas',
  uBase.DTO in 'Shared\DTO\uBase.DTO.pas',
  uProduct.DTO in 'Module\Stock\Product\DTO\uProduct.DTO.pas',
  uEither in 'Shared\Util\uEither.pas',
  uController.Factory in 'Shared\Controller\uController.Factory.pas',
  uProduct.Controller in 'Module\Stock\Product\Controller\uProduct.Controller.pas',
  uProduct.Repository.Interfaces in 'Module\Stock\Product\Repository\uProduct.Repository.Interfaces.pas',
  uRepository.Factory in 'Shared\Repository\uRepository.Factory.pas',
  uProduct.Repository in 'Module\Stock\Product\Repository\uProduct.Repository.pas',
  uProduct.Store.UseCase in 'Module\Stock\Product\UseCase\uProduct.Store.UseCase.pas',
  uEntityValidation.Exception in 'Shared\Exception\Entity\uEntityValidation.Exception.pas',
  uApplication.Exception in 'Shared\Exception\uApplication.Exception.pas',
  uProduct in 'Module\Stock\Product\Domain\Entity\uProduct.pas',
  uBase.Entity in 'Shared\Domain\Entity\uBase.Entity.pas',
  uProduct.Mapper in 'Module\Stock\Product\Mapper\uProduct.Mapper.pas',
  uConnection.Factory in 'Shared\Connection\uConnection.Factory.pas',
  DataSet.Serialize.Config in 'vendor\DatasetSerialize\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'vendor\DatasetSerialize\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'vendor\DatasetSerialize\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'vendor\DatasetSerialize\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'vendor\DatasetSerialize\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'vendor\DatasetSerialize\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'vendor\DatasetSerialize\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'vendor\DatasetSerialize\DataSet.Serialize.Utils.pas',
  uHlp in 'Shared\Util\uHlp.pas',
  uProduct.Delete.UseCase in 'Module\Stock\Product\UseCase\uProduct.Delete.UseCase.pas',
  uProduct.Show.UseCase in 'Module\Stock\Product\UseCase\uProduct.Show.UseCase.pas',
  uProduct.Update.UseCase in 'Module\Stock\Product\UseCase\uProduct.Update.UseCase.pas',
  uIndexResult in 'Shared\Util\uIndexResult.pas',
  uMemTable.Factory in 'Shared\Connection\uMemTable.Factory.pas',
  uProduct.Index.UseCase in 'Module\Stock\Product\UseCase\uProduct.Index.UseCase.pas',
  uTrans in 'Shared\Resources\Language\uTrans.pas',
  DataSetConverter4D.Helper in 'vendor\DataSetConverter4Delphi\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in 'vendor\DataSetConverter4Delphi\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in 'vendor\DataSetConverter4Delphi\DataSetConverter4D.pas',
  DataSetConverter4D.Util in 'vendor\DataSetConverter4Delphi\DataSetConverter4D.Util.pas',
  uSmartPointer in 'Shared\Util\uSmartPointer.pas' {R *.RES},
  uConnMigration in 'Shared\Connection\uConnMigration.pas',
  u2023_03_27_07_32_00_create_product_table.migration in 'Shared\Connection\Migrations\u2023_03_27_07_32_00_create_product_table.migration.pas',
  uBase.Migration in 'Shared\Connection\uBase.Migration.pas';

{R *.RES}

begin
  SessionDTM := TSessionDTM.Create(nil);
  ReportMemoryLeaksOnShutdown := true;
  DUnitTestRunner.RunRegisteredTests;

  {$IFDEF CONSOLE_TESTRUNNER}
  WriteLn('Pressione Enter para encerrar...');
  ReadLn;
  {$ENDIF}

  SessionDTM.Free;
end.

