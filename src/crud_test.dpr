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
  // ---------------------------------------------------------------------------
  // Vendor
  // ---------------------------------------------------------------------------
  DataSet.Serialize.Config in 'Vendor\dataset-serialize\src\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'Vendor\dataset-serialize\src\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'Vendor\dataset-serialize\src\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'Vendor\dataset-serialize\src\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'Vendor\dataset-serialize\src\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'Vendor\dataset-serialize\src\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'Vendor\dataset-serialize\src\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'Vendor\dataset-serialize\src\DataSet.Serialize.Utils.pas',
  uZLConnection.Types in 'Vendor\ZLConnection\src\uZLConnection.Types.pas',
  uZLMemTable.Interfaces in 'Vendor\ZLConnection\src\uZLMemTable.Interfaces.pas',
  uZLMigration in 'Vendor\ZLConnection\src\uZLMigration.pas',
  uZLQry.Interfaces in 'Vendor\ZLConnection\src\uZLQry.Interfaces.pas',
  uZLScript.Interfaces in 'Vendor\ZLConnection\src\uZLScript.Interfaces.pas',
  uZLConnection.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLConnection.FireDAC.pas',
  uZLConnection.Interfaces in 'Vendor\ZLConnection\src\uZLConnection.Interfaces.pas',
  uZLMemTable.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLMemTable.FireDAC.pas',
  uZLQry.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLQry.FireDAC.pas',
  uZLScript.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLScript.FireDAC.pas',
  DataSetConverter4D.Helper in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.pas',
  DataSetConverter4D.Util in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.Util.pas',
  uSmartPointer in 'Vendor\SmartPointer\src\uSmartPointer.pas',
  uEither in 'Vendor\Either\src\uEither.pas',
  // ---------------------------------------------------------------------------
  uEnv in 'Shared\Environment\uEnv.pas',
  uSession.DTM in 'Shared\Config\uSession.DTM.pas' {SessionDTM: TDataModule},
  uProduct.Controller.Test in 'tests\Module\Stock\Product\Controller\uProduct.Controller.Test.pas',
  uProduct.Controller.Interfaces in 'Module\Stock\Product\Controller\uProduct.Controller.Interfaces.pas',
  uBase.DTO in 'Shared\DTO\uBase.DTO.pas',
  uProduct.DTO in 'Module\Stock\Product\DTO\uProduct.DTO.pas',
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
  uConnection.Factory in 'Shared\Config\uConnection.Factory.pas',
  uHlp in 'Shared\Util\uHlp.pas',
  uProduct.Delete.UseCase in 'Module\Stock\Product\UseCase\uProduct.Delete.UseCase.pas',
  uProduct.Show.UseCase in 'Module\Stock\Product\UseCase\uProduct.Show.UseCase.pas',
  uProduct.Update.UseCase in 'Module\Stock\Product\UseCase\uProduct.Update.UseCase.pas',
  uIndexResult in 'Shared\Util\uIndexResult.pas',
  uMemTable.Factory in 'Shared\Config\uMemTable.Factory.pas',
  uProduct.Index.UseCase in 'Module\Stock\Product\UseCase\uProduct.Index.UseCase.pas',
  uTrans in 'Shared\Resources\Language\uTrans.pas',
  uConnMigration in 'Shared\Config\uConnMigration.pas',
  u2023_03_27_07_32_00_create_product_table.migration in 'Shared\Config\Migrations\u2023_03_27_07_32_00_create_product_table.migration.pas',
  uBase.Migration in 'Shared\Config\uBase.Migration.pas';

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

